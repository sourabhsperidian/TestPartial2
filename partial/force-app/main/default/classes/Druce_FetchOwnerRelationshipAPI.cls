global class Druce_FetchOwnerRelationshipAPI implements Queueable, Database.AllowsCallouts{
	public Integer pageno = 1;
    public String reqpathUrl;
	public String rs;
	
	public Druce_FetchOwnerRelationshipAPI(Integer pageno){
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
				List<Vendor__c> vendorsList = [SELECT Id,Reapit_Id__c from Vendor__c where Relation_Checked__c = FALSE];
				Map<String,Boolean> vendorRelationMap = new Map<String,Boolean>();
				
				for(Vendor__c vendor : vendorsList){
					Http http = new Http();
					HttpRequest requestnew = new HttpRequest();
					reqpathUrl = '/vendors/'+vendor.Reapit_Id__c+'/relationships';
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
							string mapKey = exnewVar.vendorId+exnewVar.associatedId;
							if(!vendorRelationMap.containsKey(mapKey)){
								vendorRelationMap.put(mapKey, exnewVar.isMain);
							}
						}
                        vendor.Relation_Checked__c = TRUE;
					}
					else{
						system.debug('----> Relationship API call failed.');
					}
				}
                
				List<Ownership__c> ownershipList = [SELECT Id,IsPrimary__c,User_Key_Id__c from Ownership__c where User_Key_Id__c in :vendorRelationMap.keySet()];
				for(ownership__c o : ownershipList){
					if(vendorRelationMap.containsKey(o.User_Key_Id__c)){
						o.IsPrimary__C = vendorRelationMap.get(o.User_Key_Id__c);
					}
				}
				update vendorsList;
                update ownershipList;
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