@RestResource(urlMapping='/leads__test/*')
global class LeadRestService {
    
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
        system.debug('jsonString : '+jsonString);
        
        boolean successCheck;
        
        DXF_ResponseWrapper resWrapper = new DXF_ResponseWrapper();
        DXF_ResponseWrapper.response response = new DXF_ResponseWrapper.response();
        List<DXF_ResponseWrapper.results> resultList = new List<DXF_ResponseWrapper.results>();
        
        List<DXF_LeadRequestWrapper> wRespList = (List<DXF_LeadRequestWrapper>) JSON.deserialize(jsonString, List<DXF_LeadRequestWrapper>.class);
        
        List<Lead> leadList = new List<Lead>();
        List<Account> accountList = new List<Account>();
        List<View_Interest__c> lstViewInterest = new List<View_Interest__c>();
        List<Opportunity> NewOpp = new List<Opportunity>();
        
        for(DXF_LeadRequestWrapper wResp: wRespList){
            if(String.isNOtBlank(wResp.sf_Prop_Id) || String.isNOtBlank(wResp.sf_Unit_Id)){
                List<Account> checkExistingLeads = [SELECT Id, Phone, Name, PersonEmail FROM Account WHERE PersonEmail =: wResp.email AND Phone =: wResp.phone];
                if(!checkExistingLeads.isEmpty()){
                    
                    Opportunity opp = new Opportunity();
                   //opp.Lead__c = checkExistingLeads[0].Id;
                    if (wResp.lead_type == 'Buying')
                    {opp.RecordTypeId =Druce_Constants.Oppourtnitybuying;}
                    else if (wResp.lead_type == 'Selling')
                        {opp.RecordTypeId =Druce_Constants.Oppourtnityselling;}
                    else if (wResp.lead_type == 'Letting')
                        {opp.RecordTypeId =Druce_Constants.OppourtnityLetting;}
                    else if (wResp.lead_type == 'Tenancy')
                        {opp.RecordTypeId =Druce_Constants.OppourtnityTenancy;}
                        
   
		             opp.AccountId = checkExistingLeads[0].Id;
		             opp.StageName = 'Indicated Interest';
		             opp.CloseDate = System.today().addDays(10);
                   
                    //Account accountname = [SELECT Id,Name FROM Account WHERE Id =:wResp.user_Id];
					
					
                    if(String.isNOtBlank(wResp.sf_Prop_Id)){
                        opp.Project_Id__c = wResp.sf_Prop_Id;
                        /*Project__c project = [SELECT Id,Name FROM Project__c WHERE Id =:wResp.sf_Prop_Id];
                        vi.Property_Interested__c = project.Id;
                        vi.Name = wResp.lastName + ' Interest '+project.Name;*/
                    }
                    
                    if(String.isNOtBlank(wResp.sf_Unit_Id)){
                        opp.Unit_Id__c = wResp.sf_Unit_Id;
                        UNIT__c unit = [SELECT Id,Name FROM UNIT__c WHERE Id =:wResp.sf_Unit_Id];
                        //vi.Unit_Interested__c = unit.Id;
                        //vi.Name = wResp.lastName + ' Interest '+unit.Name;
						//String UnitTypeId = [SELECT Project_Unit_Type__c FROM UNIT__c WHERE Id = :wResp.sf_Unit_Id LIMIT 1].Project_Unit_Type__c;
                        Unit__c UnitType =  [select Project_Unit_Type__c , Project_Unit_Type__r.project__c FROM UNIT__c WHERE Id = :wResp.sf_Unit_Id];
                        
                        
                        opp.Project_Id__c = UnitType.Project_Unit_Type__r.project__c; 
                    }
                    UNIT__c unit = [SELECT Id,Name FROM UNIT__c WHERE Id =:wResp.sf_Unit_Id];
					opp.Name = checkExistingLeads[0].Name + unit.Name;
                    NewOpp.add(opp);
                }
            }else{
                
             	List<Lead> Leads = [SELECT Id, Phone, Email FROM Lead WHERE Email =: wResp.email AND Phone =: wResp.phone];   
                if(!Leads.isEmpty()){
                    DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                    
                    result.message = 'Lead details already exists in system.';
                    resultList.add(result);
                    
                    response.results = resultList;
                    response.Status = 'Failed';
                    response.status_code = '400';
                    resWrapper.response = response;
                    strJSON = JSON.serialize(resWrapper);
                    
                    RestContext.response.addHeader('Content-Type', 'application/json');
                    RestContext.response.responseBody = Blob.valueOf(strJSON);
                    
                }else{
                	Lead obj = new Lead();
                    Account acc = new Account();
                    obj.salutation = wResp.salutation;
                    obj.LastName = wResp.lastName;
                    obj.FirstName = wResp.firstName;
                    obj.Email = wResp.email;
                    obj.Phone = wResp.phone;
                    obj.Gender__c = wResp.gender;
                    obj.Language__c = wResp.language;
                    obj.Lead_Type__c = wResp.lead_type;
                    obj.Industry = wResp.industry;
                    obj.Title = wResp.title;
                    obj.Company = wResp.company;
                    obj.NumberOfEmployees = wResp.noofEmployees == NULL ? NULL : Integer.valueOf(wResp.noofEmployees);
                    obj.Rating = wResp.rating;
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
                    obj.MarketsInterestedIn__c = wResp.markets_Interested_In;
                    /*obj.CEARegistrationNo__c = wResp.referrer_CEA_RegNo;
                    obj.EmailReferral__c = wResp.referrer_Email;
                    obj.ContactReferral__c = wResp.referrer_Contact;
                    obj.CompanyReferral__c = wResp.referrer_Company;
                    obj.NameReferral__c = wResp.referrer_Name;*/
                    obj.Lead_DB_Id__c = wResp.Lead_DB_Id;
                    obj.street = wResp.street;
                    obj.city = wResp.city;
                    obj.state = wResp.state;
                    obj.country = wResp.country;
                    obj.postalCode = wResp.postalCode;
                    obj.DXF_Ext_User_Id__c = wResp.user_Id;
                    obj.DXF_SF_Prop_ID__c = wResp.sf_Prop_Id;
                    obj.DXF_SF_Unit_Id__c = wResp.sf_Unit_Id;
                    obj.Description = wResp.description;
                    leadList.add(obj);
                    
                    acc.lastname = wResp.lastName;
                    acc.FirstName = wResp.firstName;
                    acc.Salutation = wResp.salutation;
                    acc.IsActive__c = TRUE;
                    acc.PersonEmail = wResp.email;
                    acc.Phone = wResp.phone;
                    if(wResp.emailOptOut != NULL){
                        acc.PersonHasOptedOutOfEmail = wResp.emailOptOut;
                    }
                    acc.Gender__pc = wResp.gender;
                    acc.Rating = wResp.rating;
                    acc.Line_1__c = wResp.street;
                    acc.Country_Id__c = wResp.country;
                    acc.Postcode__c = wResp.postalCode;
                    acc.BillingStreet = wResp.street;
                    acc.BillingCity = wResp.city;
                    acc.BillingState = wResp.state;
                    acc.BillingCountry = wResp.country;
                    acc.BillingPostalCode = wResp.postalCode;
                    acc.Description = wResp.description;
                    accountList.add(acc);    
                }            	
            }            
        }
        
        try{
            if(leadList.size() > 0){
                insert leadList;
                
                insert accountList;
                Map<String, Account> mapAcc = new Map<String,Account>();
                for(Account a : accountList){
                    mapAcc.put(a.PersonEmail+''+a.Phone, a);
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
            if(!lstViewInterest.isEmpty()){
                Insert lstViewInterest;
                successCheck = true;     
                for(View_Interest__c vi :lstViewInterest){
                    DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                    result.extDB_Id = vi.External_Id__c;
                    result.salesforce_Id = vi.Id;
                    result.message = 'Interest Created successfully';
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