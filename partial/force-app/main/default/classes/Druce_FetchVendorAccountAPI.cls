global class Druce_FetchVendorAccountAPI implements Queueable, Database.AllowsCallouts {
    public Integer pageNo = 1;
    public String httpresponse;
    public String reqpathUrl;
    public String url;
    
    public Druce_FetchVendorAccountAPI(Integer pageNo)
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
                Druce_FetchVendorAccountAPI.wrapperAuth wrap = new Druce_FetchVendorAccountAPI.wrapperAuth();
                
                wrapperAuth ex = (wrapperAuth)JSON.deserialize(response.getBody(), wrapperAuth.class);
                system.debug(':::'+ex.access_token);
                Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
                //reqpathUrl = '/vendors?pagesize=15&pageNumber='+pageNo;  //'/vendors/CSO230287';
                reqpathUrl = '/vendors?pagenumber=1&pagesize=2&id=KOF230040';  //'/vendors/CSO230287';
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
                    Druce_FetchVendorAccountDataWrapper exnew = (Druce_FetchVendorAccountDataWrapper)JSON.deserialize(rs, Druce_FetchVendorAccountDataWrapper.class);
                    system.debug('Wrapper :: '+exnew);
                    List<Vendor__C> VendorList = new List<Vendor__C>();
                    List<Ownership__C> OwnershipList = new List<Ownership__C>();
                    Set<string> accIds = new Set<string>();
                    Map<String, Vendor__C> mapVendors = new Map<String, Vendor__C>();
                    Map<String, Ownership__C> mapOwnerships = new Map<String, Ownership__C>();
                    for(Druce_FetchVendorAccountDataWrapper.embeddedCls exnewVar : exnew.embedded){
                        system.debug('---->'+exnewVar.id);
                        Vendor__C Vendor = new Vendor__C();
                        Vendor.Reapit_ID__c = exnewVar.id;
                        Vendor.Reapit_Created_Date__c = exnewVar.created;
                        Vendor.Reapit_Modified_Date__c = exnewVar.modified;
                        Vendor.Last_Call__c = exnewVar.lastCall;
                        Vendor.Next_Call__c = exnewVar.nextCall;
                        Vendor.Selling_Reason_Id__c = exnewVar.sellingReasonId;
                        Vendor.Type_Id__c = exnewVar.typeId;
                        Vendor.Solicitor_Id__c = exnewVar.solicitorId;
                        if(!string.isBlank(exnewVar.propertyId)){
                            Vendor.Property_Reapit_Id__c = exnewVar.propertyId;
                            unit__c u = [SELECT id from unit__c where Reapit_Id__c =: exnewVar.propertyId];
                            Vendor.Unit_Id__c = u.Id;
                        }
                        Vendor.Etag__c = exnewVar.eTag;
                        if(exnewVar.source != NULL){
                            Vendor.Source_Type__c = exnewVar.source.type;
                            Vendor.Source_Id__c = exnewVar.source.id;
                        }
                        Vendor.Negotiator_Id__c = exnewVar.negotiatorId;
                        if(exnewVar.officeIds.size() > 0){
                            Vendor.Office_Id__c = exnewVar.officeIds[0];
                        }
                        for(Druce_FetchVendorAccountDataWrapper.relatedWrapperCls relatedWrapper : exnewVar.related){
                            Ownership__C Ownership = new Ownership__C();
                            Ownership.Account_Reapit_Id__c = relatedWrapper.Id;
                            Ownership.Vendor_Reapit_Id__c = exnewVar.id;
                            Ownership.User_Key_Id__c = exnewVar.id+relatedWrapper.Id;
                            
                            if(!string.isBlank(relatedWrapper.Id)){
                                Account a = [SELECT Id from Account WHERE Reapit_ID__c =: relatedWrapper.Id];
                                Ownership.Account_Id__c = a.Id;
                            }
                            
                            //accIds.add(element);
                            OwnershipList.add(Ownership);
                        }
                        VendorList.add(Vendor);
                    }
                    
                    upsert VendorList Reapit_Id__c;
                    for(Vendor__c ven : VendorList){
                        if(ven.Reapit_Id__c != NULL){
                            mapVendors.put(ven.Reapit_Id__c,ven);
                        }
                    }
                    
                    OwnershipList = new List<Ownership__c>(new Set<Ownership__c>(OwnershipList));
                    for(Ownership__c owned: OwnershipList){
                        //Account act = [SELECT Id FROM Account where Id = :AccMap.get(con.Reapit_ID__c)];
                        if(mapVendors.containsKey(owned.Vendor_Reapit_Id__c)){
                            owned.Vendor_Id__c = mapVendors.get(owned.Vendor_Reapit_Id__c).Id;
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