global class Druce_FetchContactAPI implements Queueable, Database.AllowsCallouts 
{    
    public Integer pageNo = 1;
    public String httpresponse;
    public String reqpathUrl;
    public String url;
    
    public Druce_FetchContactAPI(Integer pageNo)
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
                DXF_ReapitAPIClass.wrapperAuth wrap = new DXF_ReapitAPIClass.wrapperAuth();
                wrapperAuth ex = (wrapperAuth)JSON.deserialize(response.getBody(), wrapperAuth.class);
                system.debug(':::'+ex.access_token);
                Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
                //String reqpathUrl = '/contacts?pagenumber=1&pagesize=2&id=RPT12002346';
                String reqpathUrl = '/contacts?pageSize=20&pageNumber='+pageNo;
                requestnew.setMethod('GET');
                requestnew.setEndpoint('callout:Reapit_Properties'+reqpathUrl);
                requestnew.setHeader('Content-Type','application/json');
                requestnew.setHeader('Authorization','Bearer '+ex.access_token);
                requestnew.setHeader('reapit-customer', 'URA');
                requestnew.setHeader('api-version','2023-01-17');
                requestnew.setTimeout(100000);
                HttpResponse responseNew = http.send(requestnew);
                httpresponse = responseNew.getBody();
                API_Log__c apiLogAuth = new API_Log__c();
                apiLogAuth.Request_Body__c = 'Endpoint: ' + requestnew.getEndpoint() + 'Body: ' + requestnew.getBody();
                apiLogAuth.Response_Body__c = httpresponse;
                apiLogAuth.Object_Name__c = 'Unit__c';
                apiLogAuth.Method__c = 'GET';
                //  insert apiLogAuth;
                
                if(responseNew.getStatusCode() == 200){
                    string rs = responseNew.getBody();
                    rs = rs.replaceAll('_embedded','embedded');
                    rs = rs.replace('currency', 'currencyCode');
                    rs = rs.replace('_eTag', 'eTag');
                    rs = rs.replace('_links', 'links');
                    system.debug('Response Body ::'+rs);
                    Druce_FetchContactAPIWrapper exnew = (Druce_FetchContactAPIWrapper)JSON.deserialize(rs, Druce_FetchContactAPIWrapper.class);
                    system.debug('Wrapper :: '+exnew);
                    List<Account> AccountList = new List<Account>();
                    List<Contact> ContactList = new List<Contact>();
                    Map<String, Account> mapAccounts = new Map<String, Account>();
                    Map<String, Contact> mapContacts = new Map<String, Contact>();    
                    for(Druce_FetchContactAPIWrapper.Contact exnewVar : exnew.embedded){
                        system.debug('---->'+exnewVar.id);
                        Account Account = new Account();
                        Contact Contact = new Contact();
                        Account.Reapit_ID__c = exnewVar.id;
                        Account.Portal_Account__c = TRUE;
                        Account.RecordTypeId =Druce_Constants.IndAccount;
                        Account.Reapit_Created_Date__c = exnewVar.created;
                        Account.Reapit_Modified_Date__c = exnewVar.modified;
                        Account.Name = exnewVar.forename+' '+exnewVar.surname;
                        //Account.PersonBirthdate = exnewVar.dateOfBirth;
                        Account.IsActive__c = exnewVar.active;
                        Account.MarketingConsent__c = exnewVar.marketingConsent;
                        Account.Identity_Check__c = exnewVar.identityCheck;
                        if(exnewVar.source != null){
                            Account.Source_Id__c = exnewVar.source.id;
                            Account.Source_Type__c = exnewVar.source.type;
                        }
                        if(exnewVar.officeIds != null){
                            Account.officeIds__c = exnewVar.officeIds[0];
                        }
                        if(exnewVar.negotiatorIds != null){
                            Account.negotiatorId__c = exnewVar.negotiatorIds[0];
                        }
                        Contact.FirstName = exnewVar.forename;
                        Contact.LastName = exnewVar.surname;
                        Account.Phone = exnewVar.mobilePhone;
                        Account.Email__c = exnewVar.email;
                        Contact.fromArchieve__c = exnewVar.fromArchive;
                        if(exnewVar.PrimaryAddress != null){
                            Account.Building_Name__c = exnewVar.PrimaryAddress.buildingName;
                            Account.Building_Number__c = exnewVar.PrimaryAddress.buildingNumber;
                            Account.Line_1__c = exnewVar.PrimaryAddress.line1;
                            Account.Line_2__c = exnewVar.PrimaryAddress.line2;
                            Account.Line_3__c = exnewVar.PrimaryAddress.line3;
                            Account.Line_4__c = exnewVar.PrimaryAddress.line4;
                            Account.Postcode__c = exnewVar.PrimaryAddress.postcode;
                            Account.Country_Id__c = exnewVar.PrimaryAddress.countryId;
                            Contact.buildingName__c = exnewVar.PrimaryAddress.buildingName;
                            Contact.Building_Number__c = exnewVar.PrimaryAddress.buildingNumber;
                            Contact.Line_1__c = exnewVar.PrimaryAddress.line1;
                            Contact.line2__c = exnewVar.PrimaryAddress.line2;
                            Contact.Line_3__c = exnewVar.PrimaryAddress.line3;
                            Contact.Line_4__c = exnewVar.PrimaryAddress.line4;
                            Contact.Postcode__c = exnewVar.PrimaryAddress.postcode;
                            Contact.Country_ID__c = exnewVar.PrimaryAddress.countryId;
                        }
                        
                        Contact.Reapit_ID__c = exnewVar.Id;
                        Contact.Title = exnewVar.title;
                        Contact.Birthdate = exnewVar.dateOfBirth;
                        Contact.Type__c = 'Contact';
                        Contact.OtherPhone = exnewVar.workPhone;
                        Contact.Phone = exnewVar.homePhone;
                        Contact.MobilePhone = exnewVar.mobilePhone;
                        Contact.Email = exnewVar.email;
                        Contact.CommunicationPreferenceEmail__c = exnewVar.communicationPreferenceEmail;
                        Contact.CommunicationPreferenceLetter__c = exnewVar.communicationPreferenceLetter;
                        Contact.CommunicationPreferencePhone__c = exnewVar.communicationPreferencePhone;
                        Contact.CommunicationPreferenceSMS__c = exnewVar.communicationPreferenceSMS;
                        AccountList.add(Account);
                        ContactList.add(Contact);
                    }
                    AccountList = new List<Account>(new Set<Account>(AccountList));
                    upsert AccountList Reapit_ID__c;
                    Map<string,Account> AccMap = new Map<string,Account>();
                    for(Account acc : AccountList){
                        if(acc.Reapit_ID__c != NULL){
                            AccMap.put(acc.Reapit_ID__c,acc);
                        }
                    }
                    
                    ContactList = new List<Contact>(new Set<Contact>(ContactList));
                    for(Contact con: ContactList){
                        //Account act = [SELECT Id FROM Account where Id = :AccMap.get(con.Reapit_ID__c)];
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
    
    
    public class wrapperAuth{
        public String access_token;
        public Integer expire_in;
        public string token_type;
    }
}