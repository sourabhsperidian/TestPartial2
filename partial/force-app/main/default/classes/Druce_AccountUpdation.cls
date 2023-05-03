@RestResource(urlMapping='/Accounts/*')
global class Druce_AccountUpdation {
    @HttpPut
    global Static void updateAccount(){
        String strJSON;
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        system.debug(jsonString);
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        map<string,Account> mapaccount = new map<string,Account>();
        
        DXF_ResponseWrapper resWrapper = new DXF_ResponseWrapper();
        DXF_ResponseWrapper.response response = new DXF_ResponseWrapper.response();
        List<DXF_ResponseWrapper.results> resultList = new List<DXF_ResponseWrapper.results>();
        
        List<DXF_AccountWrapper> wRespList = (List<DXF_AccountWrapper>) JSON.deserialize(jsonString, List<DXF_AccountWrapper>.class);
        system.debug(wRespList);
        Contact Cont = new Contact();
        Account acc = new Account();
        for(DXF_AccountWrapper wResp: wRespList){
            List<Account> checkExistingAccount = [SELECT Id, Phone FROM Account WHERE Id =:wResp.SF_AccountID];
            if (!checkExistingAccount.isEmpty()){
                acc.Name = wResp.firstName +' ' + wResp.lastName;
                Cont.FirstName = wResp.firstName;
                Cont.lastName = wResp.lastName;
                acc.Email__c = wResp.Email;
                Cont.Email = wResp.Email; 
                acc.Phone = wResp.phone;
                Cont.Phone = wResp.phone; 
                acc.Id = wResp.SF_AccountID;
                Cont.Id = [SELECT Id FROM Contact WHERE AccountId =: wResp.SF_AccountID AND Portal_Contact__c = TRUE LIMIT 1].Id;
                Cont.Gender__c = wResp.Gender;
                Cont.Birthdate = wResp.Birthdate;
                Cont.Citizenship__c = wResp.Nationality;
                acc.Line_1__c = wResp.Address1;
                acc.Line_2__c = wResp.Address2;
                acc.Line_3__c = wResp.city;
                acc.Line_4__c = wResp.state;
                acc.Country_Id__c = wResp.country;
                acc.Postcode__c = wResp.postalcode;
                Cont.Line_1__c = wResp.Address1;
                Cont.line2__c = wResp.Address1;
                Cont.Postcode__c = wResp.postalcode;
                Cont.Country__c = wResp.country;
                //Cont.Country_ID__c = wResp.country;
                Cont.Line_3__c = wResp.city;
                Cont.Line_4__c = wResp.state;
                Cont.Occupation__c = wResp.occupation;
                acc.Industry = wResp.industry;
                acc.No_of_adults__c = wResp.adults;
                acc.No_of_children__c = wResp.childrens;
                acc.Income_range__c =wResp.incomeRange;
                acc.Interests__c = String.join(wResp.interets,';'); 
                acc.Vacation_Places__c = String.join(wResp.vacation, ';');
                acc.Social_Name__c = wResp.SocialName; 
                acc.Link_or_Username__c = wResp.Link;
                
                
                
                
                contactList.add(Cont);
                accountList.add(acc);
                
            }
            
        }
        upsert accountList;
        upsert contactList;
        DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
        result.salesforce_Id = acc.Id;
        result.message = 'Account updated successfully';
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