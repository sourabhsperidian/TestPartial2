@RestResource(urlMapping='/leads_olfd/*')
global class LeadRestService_adarsh {
    
    /**********************Monika: Lead API - Get: 0/01/2023**********************************/
    
    @HttpGet
    global Static List<Lead> getLead(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String recId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Lead> leadResult;
        system.debug('recId :'+recId);
        
        if(String.isNotBlank(recId)){
            leadResult = [SELECT Id, LastName, FirstName,Email,phone,Lead_DB_Id__c
                          FROM Lead WHERE Id = :recId];
        }     
        return leadResult;    
    }
    /**********************Monika: Lead API - Get End: 0/01/2023**********************************/
    
    @HttpPost
    global Static void createLead(){
        
        String strJSON;
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        
        boolean successCheck;
        List<Lead> leadList = new List<Lead>();
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        map<string,Account> mapaccount = new map<string,Account>();
        //system.debug('jsonString : '+jsonString);
        
        DXF_ResponseWrapper resWrapper = new DXF_ResponseWrapper();
        DXF_ResponseWrapper.response response = new DXF_ResponseWrapper.response();
        List<DXF_ResponseWrapper.results> resultList = new List<DXF_ResponseWrapper.results>();
        
        List<DXF_LeadRequestWrapper> wRespList = (List<DXF_LeadRequestWrapper>) JSON.deserialize(jsonString, List<DXF_LeadRequestWrapper>.class);
        
        for(DXF_LeadRequestWrapper wResp: wRespList){
            
            List<Lead> checkExistingLeads =[SELECT Id, Phone, Email, MobilePhone FROM Lead WHERE((Email =: wResp.email) OR (Phone =: wResp.phone))];
            if(checkExistingLeads.isEmpty()){
                //Lead,Account,contact creation
                Lead obj = new Lead();
                Account acc = new Account();
                
                obj.LastName = wResp.lastName;
                obj.FirstName = wResp.firstName;
                obj.Email = wResp.email;
                obj.Phone = wResp.phone;
                obj.Lead_Type__c = wResp.lead_type;
                if(wResp.fly_In_Program != NULL){
                    obj.Fly_in_Program__c = wResp.fly_In_Program;
                }
                if(wResp.donotCall != NULL){
                    obj.DoNotCall = wResp.donotCall;                
                }
                if(wResp.emailOptOut != NULL){
                    obj.HasOptedOutOfEmail = wResp.emailOptOut;
                }
                obj.MobilePhone = wResp.mobile;
                obj.Lead_DB_Id__c = wResp.Lead_DB_Id;
                obj.street = wResp.street;
                obj.city = wResp.city;
                obj.state = wResp.state;
                obj.country = wResp.country;
                obj.postalCode = wResp.postalCode;
                obj.DXF_SF_Prop_ID__c = wResp.sf_Prop_Id;
                obj.DXF_SF_Unit_Id__c = wResp.sf_Unit_Id;
                obj.Description = wResp.description;
                obj.Office_ID__c = wResp.office_Id;
                obj.Portal_Lead__c = TRUE;
                leadList.add(obj);
                
                acc.Name = wResp.firstName + wResp.lastName;
                //acc.FirstName = wResp.firstName;
                acc.IsActive__c = TRUE;
                acc.Email__c = wResp.email;
                acc.Phone = wResp.phone;
                acc.officeIds__c = wResp.office_Id;
                acc.RecordTypeId = Druce_Constants.IndAccount;
                acc.Portal_Account__c = TRUE;
                if(wResp.emailOptOut != NULL){
                    acc.PersonHasOptedOutOfEmail = wResp.emailOptOut;
                }
                acc.BillingStreet = wResp.street;
                acc.BillingCity = wResp.city;
                acc.BillingState = wResp.state;
                acc.BillingCountry = wResp.country;
                acc.BillingPostalCode = wResp.postalCode;
                acc.Description = wResp.description;
                accountList.add(acc); 
                Contact Contact = new Contact();                
                Contact.FirstName = wResp.firstName;
                Contact.lastName = wResp.lastName;
                //Contact.Title = wResp.title;
                Contact.Gender__c = wResp.gender;
                Contact.Birthdate = wResp.dateOfBirth;
                Contact.Type__c = wResp.type;
                Contact.OtherPhone = wResp.homePhone;
                Contact.Phone = wResp.phone;
                Contact.MobilePhone = wResp.mobilePhone;
                Contact.Email = wResp.email;
                Contact.buildingName__c = wResp.buildingName;
                Contact.Building_Number__c = wResp.buildingNumber;
                Contact.Line_1__c = wResp.line1;
                Contact.line2__c = wResp.line2;
                Contact.Line_3__c = wResp.line3;
                Contact.RecordTypeId = Druce_Constants.Contactrecords;
                Contact.Postcode__c = wResp.postalCode;
                Contact.Country_ID__c = wResp.country;
                Contact.Portal_Contact__c = TRUE;
                contactList.add(Contact);
            }
            
            else if(checkExistingLeads.size()>0){
                //UNIT__c unit = [SELECT Name,Project_Unit_Type__r.project__c FROM UNIT__c WHERE Id =:wResp.sf_Unit_Id];
                Account ExistingAccount = [SELECT Id, Phone, Name,PersonContactid, Email__c,officeIds__c FROM Account WHERE Email__c =: wResp.email AND Phone =: wResp.phone AND officeIds__c =: wResp.office_Id];
                list<Opportunity> CheckExistingOpportunity = [SELECT AccountId ,StageName FROM Opportunity WHERE ((AccountId=:ExistingAccount.Id AND Office_ID__c =: wResp.office_Id) AND  (StageName!='Accpeted offer'  AND StageName!='Rejected Offer'))];
                
                //system.debug(ExistingAccount);
                
                if(CheckExistingOpportunity.size()>0){
                    //Opp Already exists
                    DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                    
                    result.message = 'Opportunity details already exists in system.';
                    resultList.add(result);
                    
                    response.results = resultList;
                    response.Status = 'Failed';
                    response.status_code = '400';
                    resWrapper.response = response;
                    strJSON = JSON.serialize(resWrapper);
                    
                    RestContext.response.addHeader('Content-Type', 'application/json');
                    RestContext.response.responseBody = Blob.valueOf(strJSON);
                }
                else{
                    //Lead Exists Opp creation 
                    
                    UNIT__c unit = [SELECT Name,Project_Unit_Type__r.project__c FROM UNIT__c WHERE Id =:wResp.sf_Unit_Id];
                    Opportunity opp = new Opportunity();
                    if (wResp.lead_type == 'Selling' || wResp.lead_type == 'Valuation'){
                        opp.RecordTypeId =Druce_Constants.Oppourtnityselling;
                    }
                    else if (wResp.lead_type == 'Letting'){
                        opp.RecordTypeId =Druce_Constants.OppourtnityLetting;
                    }
                    else if (wResp.lead_type == 'Buying'){
                        opp.RecordTypeId =Druce_Constants.Oppourtnitybuying;
                    }
                    else if(wResp.lead_type == 'Renting'){
                        opp.RecordTypeId =Druce_Constants.Oppourtnitytenancy;
                    }
                    
                    opp.AccountId =ExistingAccount.Id; //wResp.user_Id;
                    opp.StageName = 'Indicated Interest';
                    opp.CloseDate = System.today().addDays(10);
                    opp.Office_ID__c = wResp.office_Id;
                    if(String.isNOtBlank(wResp.sf_Prop_Id)){
                        opp.Project_Id__c = wResp.sf_Prop_Id;
                    }
                    if(String.isNOtBlank(wResp.sf_Unit_Id)){
                        opp.Unit_Id__c = wResp.sf_Unit_Id;
                        opp.Unit__c = wResp.sf_Unit_Id;
                        opp.Project_Id__c = unit.Project_Unit_Type__r.project__c;
                    }
                    opp.Name = ExistingAccount.Name+' '+unit.Name;
                    Insert opp;
                    successCheck = true;
                    DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                    result.salesforce_Id = opp.Id;
                    result.message = 'Opportunity Created successfully';
                    resultList.add(result);
                    response.results = resultList;
                    response.Status = 'Success';
                    response.status_code = '200';
                    
                    resWrapper.response = response;
                    strJSON = JSON.serialize(resWrapper);
                    RestContext.response.addHeader('Content-Type', 'application/json');
                    RestContext.response.responseBody = Blob.valueOf(strJSON);
                    
                    
                }
                
            }
            
        }
            
            try{
                if(leadList.size() > 0){
                    insert leadList;
                    insert accountList;
                    for(Account a : accountList){
                        if(!mapaccount.containsKey(a.Phone+'_'+a.Email__c)){
                            mapaccount.put(a.Phone+'_'+a.Email__c, a);
                        }  
                    }
                    
                    for(Contact c :contactList){
                        if(mapaccount.containsKey(c.Phone+'_'+c.Email)){
                            c.AccountId = mapaccount.get(c.Phone+'_'+c.Email).Id;
                        }
                    }
                    insert contactList;
                    Map<String, Account> mapAcc = new Map<String,Account>();
                    for(Account a : accountList){
                        mapAcc.put(a.Email__c+''+a.Phone, a);
                    }
                    
                    successCheck = true;     
                    for(Lead ld : leadList){
                        DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                        result.extDB_Id = ld.Lead_DB_Id__c;
                        result.salesforce_Id = ld.Id;
                        if(mapAcc.containsKey(ld.Email+''+ld.Phone)){
                            result.userId = mapAcc.get(ld.Email+''+ld.Phone).Id;
                        }
                        result.message = 'User Created successfully';
                        resultList.add(result);
                    }                
                    
                    response.results = resultList;
                    response.Status = 'Success';
                    response.status_code = '200';
                    resWrapper.response = response;
                    strJSON = JSON.serialize(resWrapper);
                    
                    RestContext.response.addHeader('Content-Type', 'application/json');
                    RestContext.response.responseBody = Blob.valueOf(strJSON);
                }
            }
            catch(DmlException e){
                successCheck = false;
                Integer numErrors = e.getNumDml();
                String errormessage ='Error: ';
                for(Integer i=0;i<numErrors;i++) {
                    errormessage = errormessage + e.getDmlMessage(i);
                }
                
                if(errormessage.contains('Use one of these records')){
                    response.errormessage = 'Lead details already exists in system.';
                }else{
                    response.errormessage = errormessage + '; No. of Error: ' + numErrors;    
                }
                response.Status = 'Error';
                response.status_code = '400';
                resWrapper.response = response;
                strJSON = JSON.serialize(resWrapper);
                RestContext.response.addHeader('Content-Type', 'application/json');
                RestContext.response.responseBody = Blob.valueOf(strJSON);
            }
            catch(Exception e){
                successCheck = false;       
                response.errormessage = e.getMessage();
                response.Status = 'Failed';
                response.status_code = 'Err_Excep';
                resWrapper.response = response;
                strJSON = JSON.serialize(resWrapper);
                RestContext.response.addHeader('Content-Type', 'application/json');
                RestContext.response.responseBody = Blob.valueOf(strJSON);
            }
        }
        
        /**********************Monika: Lead API - Post End:**********************************/
        
        @HttpPUT
        global Static void updateLead(){
            
            String strJSON;
            RestRequest req = RestContext.request;
            RestResponse res = Restcontext.response;
            string jsonString = req.requestBody.tostring();
            system.debug('jsonString : '+jsonString);
            
            boolean successCheck;
            List<DXF_LeadRequestWrapper> wRespList = (List<DXF_LeadRequestWrapper>) JSON.deserialize(jsonString,List<DXF_LeadRequestWrapper>.class);
            
            List<Lead> leadList = new List<Lead>();
            
            for(DXF_LeadRequestWrapper wResp: wRespList){
                Lead obj = new Lead();
                obj.LastName = wResp.LastName;   
                obj.FirstName = wResp.FirstName;    
                obj.Email = wResp.Email;   
                obj.Phone = wResp.phone;
                obj.Id = wResp.Lead_SF_Id;
                // obj.Status = wResp.leadStatus;
                obj.Lead_DB_Id__c = wResp.Lead_DB_Id;
                leadList.add(obj);
            }
            DXF_ResponseWrapper resWrapper = new DXF_ResponseWrapper();
            DXF_ResponseWrapper.response response = new DXF_ResponseWrapper.response();
            List<DXF_ResponseWrapper.results> resultList = new List<DXF_ResponseWrapper.results>();
            try{
                if(leadList.size() > 0){
                    update leadList;
                    successCheck = true;
                    
                    for(Lead ld :leadList){
                        DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                        result.extDB_Id = ld.Lead_DB_Id__c;
                        result.salesforce_Id = ld.Id;
                        resultList.add(result);
                    }
                    response.results = resultList;
                    response.Status = 'Success';
                    response.status_code = '200';
                    resWrapper.response = response;
                    strJSON = JSON.serialize(resWrapper);    
                    RestContext.response.addHeader('Content-Type', 'application/json');
                    RestContext.response.responseBody = Blob.valueOf(strJSON);
                }
            }
            
            catch(Exception e){
                successCheck = false;
            }
        }
        /**********************Monika: Lead API - Put End: **********************************/
        
    }