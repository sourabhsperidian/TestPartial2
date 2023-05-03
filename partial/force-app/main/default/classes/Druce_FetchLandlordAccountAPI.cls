global class Druce_FetchLandlordAccountAPI implements Queueable, Database.AllowsCallouts {
    public Integer pageNo = 1;
    public String httpresponse;
    public String reqpathUrl;
    public String url;
    
    public Druce_FetchLandlordAccountAPI(Integer pageNo)
    {
        this.pageNo = pageNo;
    }
    public void execute(QueueableContext context) {
        try{
            Http h = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            String path = '?client_id=3ohfvftvn15aap62di1nksaglu&grant_type=client_credentials';
            request.setEndpoint('callout:Reapit_API');
            String payLoad = 'client_id=3ohfvftvn15aap62di1nksaglu&grant_type=client_credentials';
            request.setBody(payLoad);
            request.setTimeout(60000);
            HttpResponse response = h.send(request);
            system.debug('Response Auth ::'+response);
            if(response.getStatusCode() == 200){
                system.debug('response body :'+response.getBody());
                Druce_FetchLandlordAccountAPI.wrapperAuth wrap = new Druce_FetchLandlordAccountAPI.wrapperAuth();
                wrapperAuth ex = (wrapperAuth)JSON.deserialize(response.getBody(), wrapperAuth.class);
                system.debug(':::'+ex.access_token);
                Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
                reqpathUrl = '/landlords?pagenumber=1&pagesize=1&id=BGO230008';
                requestnew.setMethod('GET');
                requestnew.setEndpoint('callout:Reapit_Properties'+reqpathUrl);
                requestnew.setHeader('Content-Type','application/json');
                requestnew.setHeader('Authorization','Bearer '+ex.access_token);
                requestnew.setHeader('reapit-customer', 'URA');
                requestnew.setHeader('api-version','2023-01-17');
                requestnew.setTimeout(100000);
                HttpResponse responseNew = http.send(requestnew);
                httpresponse = responseNew.getBody();
                
                if(responseNew.getStatusCode() == 200){
                    string rs = responseNew.getBody();
                    rs = rs.replaceAll('_embedded','embedded');
                    rs = rs.replace('_eTag', 'eTag');
                    rs = rs.replace('_links', 'links');
                    
                    system.debug('Response Body ::'+rs);
                    Druce_FetchLandlordAccountWrapper exnew = (Druce_FetchLandlordAccountWrapper)JSON.deserialize(rs, Druce_FetchLandlordAccountWrapper.class);
                    system.debug('Wrapper :: '+exnew);
                    List<Landlord__c> LandlordList = new List<Landlord__c>();
                    List<Landlord_Ownership__c> OwnershipList = new List<Landlord_Ownership__c>();
                    Map<String, Landlord__c> mapLandlords = new Map<String, Landlord__c>();
                    Map<String, Landlord_Ownership__c> mapOwnerships = new Map<String, Landlord_Ownership__c>();
                    for(Druce_FetchLandlordAccountWrapper.embeddedCls exnewVar : exnew.embedded){
                        system.debug('---->'+exnewVar.id);
                        Landlord__c Landlord = new Landlord__c();
                       for(Druce_FetchLandlordAccountWrapper.relatedCls relatedWrapper : exnewVar.related){
                            
                            Landlord_Ownership__c Ownership = new Landlord_Ownership__c();
                            
                            Landlord.Reapit_Id__c = exnewVar.id;
                            Landlord.Reapit_Created_Date__c = exnewVar.created;
                            Landlord.Reapit_Modified_Date__c = exnewVar.modified;
                            Landlord.Active__c = exnewVar.active;
                            Landlord.Solicitor_Id__c = exnewVar.solicitorId;
                            Landlord.Office_Id__c = exnewVar.officeId;
                            Landlord.ETag__c = exnewVar.eTag;
                            if(exnewVar.source != NULL){
                               Landlord.Source_Type__c = exnewVar.source.type;
                               Landlord.Source_Id__c = exnewVar.source.id;
                            }
                            
                            Ownership.Account_Reapit_Id__c = relatedWrapper.Id;
                            Ownership.Landlord_Reapit_Id__c = exnewVar.id;
                            Ownership.User_Key_Id__c = exnewVar.id+relatedWrapper.Id;
                            
                            if(!string.isBlank(relatedWrapper.Id)){
                                Account a = [SELECT Id from Account WHERE Reapit_ID__c =: relatedWrapper.Id];
                                Ownership.Account_Id__c = a.Id;
                            }
                            //accIds.add(element);
                            
                            OwnershipList.add(Ownership);
                        }
                        LandlordList.add(Landlord);
                        List<Opportunity> opplist = [SELECT Unit_Id__c FROM Opportunity WHERE Landlord_Id__c =:exnewVar.id];
                        for(Landlord__c lw : LandlordList){
                            for(Opportunity o: opplist){
                            	lw.Unit_Id__c= o.Unit_Id__c;
                            }  
                        }
                    }
                System.Debug(LandlordList);
                    upsert LandlordList Reapit_Id__c;
                    for(Landlord__c lan : LandlordList){
                        if(lan.Reapit_Id__c != NULL){
                            mapLandlords.put(lan.Reapit_Id__c,lan);
                        }
                    } 

                    OwnershipList = new List<Landlord_Ownership__c>(new Set<Landlord_Ownership__c>(OwnershipList));
                    for(Landlord_Ownership__c owned: OwnershipList){
                        if(mapLandlords.containsKey(owned.Landlord_Reapit_Id__c)){
                            owned.Landlord__c = mapLandlords.get(owned.Landlord_Reapit_Id__c).Id;
                        }
                    }
                    upsert OwnershipList User_Key_Id__c;
                }
                else{system.debug('---->Failed');}
            }
        }
        catch(Exception e){
            system.debug('Exception '+e.getMessage()); 
            system.debug('Line Number '+e.getLineNumber()); 
        }
    }
    
    public class wrapperAuth {
        public String access_token;
        public Integer expire_in;
        public string token_type;
    }
    
    
}