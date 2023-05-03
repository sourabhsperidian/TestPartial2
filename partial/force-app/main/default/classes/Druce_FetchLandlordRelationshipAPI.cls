global class Druce_FetchLandlordRelationshipAPI implements Queueable, Database.AllowsCallouts{
	public Integer pageno = 1;
    public String reqpathUrl;
	public String rs;
	
	public Druce_FetchLandlordRelationshipAPI(Integer pageno){
		this.pageno = pageno;
	}
	
	public class wrapperAuth{
		public string access_token;
        public Integer expire_in;
        public string token_type;
	}
	
	public void execute(QueueableContext context){
		try{
			Http h = new Http();
			HttpRequest request = new HttpRequest();
			request.setMethod('POST');
			request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
			string payload = 'client_id=3ohfvftvn15aap62di1nksaglu&grant_type=client_credentials';
			request.setEndpoint('callout:Reapit_API');
            request.setBody(payload);
			request.setTimeout(60000);
			HttpResponse response = h.Send(request);
			if(response.getStatusCode() == 200){
				wrapperAuth ex = (wrapperAuth)JSON.deserialize(response.getBody(), wrapperAuth.class);
				List<Landlord__c> landlordsList = [SELECT Id,Reapit_Id__c from Landlord__c where Relation_Checked__c = FALSE];
				Map<String,Boolean> landlordsRelationMap = new Map<String,Boolean>();
				
				for(Landlord__c landlord : landlordsList){
					Http http = new Http();
					HttpRequest requestnew = new HttpRequest();
					reqpathUrl = '/landlords/'+landlord.Reapit_Id__c+'/relationships';
                    requestnew.setMethod('GET');
					requestnew.setEndpoint('callout:Reapit_Properties'+reqpathUrl);
					requestnew.setHeader('Content-Type','application/json');
					requestnew.setHeader('Authorization','Bearer '+ex.access_token);
					requestnew.setHeader('reapit-customer', 'URA');
					requestnew.setHeader('api-version','2023-01-17');
					requestnew.setTimeout(10000);
					HttpResponse responseNew = http.Send(requestnew);
					if(responseNew.getStatusCode() == 200){
						rs = responseNew.getBody();
						rs = rs.replaceAll('_embedded','embedded');
						rs = rs.replace('_eTag', 'eTag');
						rs = rs.replace('_links', 'links');
						
						Druce_FetchOwnerRelationshipWrapper exnew = (Druce_FetchOwnerRelationshipWrapper)JSON.deserialize(rs,Druce_FetchOwnerRelationshipWrapper.class);
						
						for(Druce_FetchOwnerRelationshipWrapper.EmbeddedRelationship exnewVar : exnew.embedded){
							string mapKey = exnewVar.landlordId+exnewVar.associatedId;
							if(!landlordsRelationMap.containsKey(mapKey)){
								landlordsRelationMap.put(mapKey, exnewVar.isMain);
							}
						}
                        landlord.Relation_Checked__c = TRUE;
					}
					else{
						system.debug('----> Relationship API call failed.');
					}
				}
				
				List<Landlord_Ownership__c> LandOwnerList = [SELECT Id,IsPrimary__c,User_Key_Id__c from Landlord_Ownership__c where User_Key_Id__c in :landlordsRelationMap.keySet()];
				for(Landlord_Ownership__c l : LandOwnerList){
					if(landlordsRelationMap.containsKey(l.User_Key_Id__c)){
						l.IsPrimary__C = landlordsRelationMap.get(l.User_Key_Id__c);
					}
				}
				update landlordsList;
                update LandOwnerList;
			}
			else{
				system.debug('----> Authrization Token call failed.');
			}
		}
		catch(Exception e){
			system.debug('Exception '+e.getMessage());
			system.debug('Line Number '+e.getLineNumber());
		}
	}
}