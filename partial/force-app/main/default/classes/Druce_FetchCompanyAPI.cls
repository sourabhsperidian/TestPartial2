global class Druce_FetchCompanyAPI implements Queueable, Database.AllowsCallouts {
    public Integer pageNo = 1;
    public String httpresponse;
    public String reqpathUrl;
    public String url;
    
    public Druce_FetchCompanyAPI(Integer pageNo)
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
                reqpathUrl = '/companies?pagesize=25&pageNumber='+pageNo;  //'/companies/CSO230287';
                //reqpathUrl = '/companies?pagenumber=1&pagesize=2&id=KOF230040';  //'/companies/CSO230287';
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
                    Druce_FetchCompanyAPIWrapper exnew = (Druce_FetchCompanyAPIWrapper)JSON.deserialize(rs, Druce_FetchCompanyAPIWrapper.class);
                    system.debug('Wrapper :: '+exnew);
                    List<Account> AccountList = new List<Account>();
                    List<Contact> ContactList = new List<Contact>();
                    Map<String, Account> mapAccounts = new Map<String, Account>();
                    for(Druce_FetchCompanyAPIWrapper.Company exnewVar : exnew.embedded){
                        system.debug('---->'+exnewVar.id);
                        Account Account = new Account();
                        Contact Contact = new Contact();
                        
                        Account.Reapit_ID__c = exnewVar.id;
                        Account.Portal_Account__c = TRUE;
                        Account.RecordTypeId = Druce_Constants.CorpAccount;
                        //Account.Reapit_Id_Calc__c = exnewVar.id+'_'+relatedWrapper.id;
                        Account.Reapit_Created_Date__c = exnewVar.created;
                        Account.Reapit_Modified_Date__c = exnewVar.modified;
                        Account.Name = exnewVar.name;
                        Account.Branch__c = exnewVar.branch;
                        Account.Notes__c = exnewVar.notes;
                        Account.IsActive__c = exnewVar.active;
                        Account.MarketingConsent__c = exnewVar.marketingConsent;
                        Account.Vat_Registered__c = exnewVar.vatRegistered;
                        String typeId = '';
                        if(exnewVar.typeIds.size() > 0){
                            for(string s : exnewVar.typeIds){
                                typeId = s + ' ' + typeId;
                            }
                        }
                        Account.TypeId__c = typeId;
                        Account.Supplier_Type_Id__c = exnewVar.supplierTypeId;
                        Account.Email__c = exnewVar.email;
                        
                        if(exnewVar.officeIds.size() > 0){
                            Account.officeIds__c = exnewVar.officeIds[0];
                        }
                        if(exnewVar.negotiatorIds.size() > 0){
                            Account.negotiatorId__c = exnewVar.negotiatorIds[0];
                        }
                        Account.ETag__c = exnewVar.eTag;
                        
                        
                        Contact.Reapit_ID__c = exnewVar.Id;
                        Contact.FirstName = exnewVar.name;
                        Contact.LastName = '.';
                        Contact.MobilePhone = exnewVar.mobilePhone;
                        Contact.OtherPhone = exnewVar.workPhone;
                        Contact.Email = exnewVar.email;
                        for(Druce_FetchCompanyAPIWrapper.ContactDetail  additionalDetails: exnewVar.additionalContactDetails)
                        {
                            Account.Phone = additionalDetails.value;
                            Contact.Phone = additionalDetails.value;
                            Contact.Type__c = additionalDetails.type;
                        }
                        
                        Contact.buildingName__c = exnewVar.address.buildingName;
                        Contact.Building_Number__c = exnewVar.address.buildingNumber;
                        Contact.Line_1__c = exnewVar.address.line1;
                        Contact.line2__c = exnewVar.address.line2;
                        Contact.Line_3__c = exnewVar.address.line3;
                        Contact.Line_4__c = exnewVar.address.line4;
                        Contact.Postcode__c = exnewVar.address.postcode;
                        Contact.Country_ID__c = exnewVar.address.country;
                        
                        Account.Building_Name__c = exnewVar.address.buildingName;
                        Account.Building_Number__c = exnewVar.address.buildingNumber;
                        Account.Line_1__c = exnewVar.address.line1;
                        Account.Line_2__c = exnewVar.address.line2;
                        Account.Line_3__c = exnewVar.address.line3;
                        Account.Line_4__c = exnewVar.address.line4;
                        Account.Postcode__c = exnewVar.address.postcode;
                        Account.Country_Id__c = exnewVar.address.country;
                        //Contact.Portal_Contact__c = TRUE;
                        
                        AccountList.add(Account);
                        ContactList.add(Contact);
                        
                    }
                    
                    upsert AccountList Reapit_Id__c;
                    Map<string,Account> AccMap = new Map<string,Account>();
                    for(Account acc : AccountList){
                        if(acc.Reapit_Id__c != NULL){
                            AccMap.put(acc.Reapit_Id__c,acc);
                        }
                    }
                    
                    for(Contact con: ContactList){
                        if(AccMap.containsKey(con.Reapit_ID__c)){
                            con.AccountId = AccMap.get(con.Reapit_ID__c).Id;
                        }
                    }
                    upsert ContactList Reapit_ID__c;
                    
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