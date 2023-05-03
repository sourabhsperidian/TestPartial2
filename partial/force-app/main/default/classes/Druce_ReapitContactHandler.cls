public class Druce_ReapitContactHandler {
    Public static void contactSync(String Contactstring){
        Druce_AccountContactDataWrapper requestWrapper = (Druce_AccountContactDataWrapper)JSON.deserialize(Contactstring, Druce_AccountContactDataWrapper.class); 
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        if(requestWrapper.embedded != NULL){
            Druce_AccountContactDataWrapper.embedded exnewVar = requestWrapper.embedded;
            System.debug('id :'+requestWrapper.embedded.id);
            Account acc = new Account();
            Contact cont = new Contact ();
            // Check Reapit Id not exists in System then assign Unit Type
            /* List<Account> accList = [SELECT Id FROM Account WHERE Reapit_Id__c =: exnewVar.Id ]; 
if(unitList.isEmpty() ){
unit.Project_Unit_Type__c = 'a070T000003NSzSQAW';
}  
Druce_FetchVendorAccountDataWrapper.Account accWrap = new Druce_FetchVendorAccountDataWrapper.Account();
accWrap = exnewVar.Account; */
            
            
            cont.Title =  exnewVar.title;
            cont.Firstname = exnewVar.forename;
            cont.lastname = exnewVar.surname;
            cont.Birthdate = exnewVar.dateOfBirth;
            cont.IsActive__c = exnewVar.active; //checkbox
            cont.HomePhone = exnewVar.homePhone;
            cont.MobilePhone = exnewVar.mobilePhone;
            cont.Email = exnewVar.email;
            cont.fromArchieve__c =exnewVar.fromArchive; //checkbox
            //cont.Name = exnewVar
            //cont.Description = exnewVar
            cont.buildingName__c = exnewVar.primaryAddress.buildingName;
            cont.Building_Number__c = exnewVar.primaryAddress.buildingNumber;
            cont.Line_1__c = exnewVar.primaryAddress.line1;
            cont.line2__c = exnewVar.primaryAddress.line2;
            cont.Line_3__c = exnewVar.primaryAddress.line3;
            cont.Line_4__c = exnewVar.primaryAddress.line4;
            cont.Postcode__c = exnewVar.primaryAddress.postcode;
            cont.Country__c = exnewVar.primaryAddress.countryId;
            
            
            
            acc.PersonTitle = exnewVar.title;
            acc.Firstname = exnewVar.forename;
            acc.lastname = exnewVar.surname;
            acc.PersonBirthdate = exnewVar.dateOfBirth;
            acc.IsActive__c = exnewVar.active;
            acc.MarketingConsent__c = exnewVar.marketingConsent;
            acc.Identity_Check__c = exnewVar.identityCheck;
            acc.Source_Id__c = exnewVar.source;
            acc.Phone = exnewVar.mobilePhone;
            acc.Email__c = exnewVar.email;
            acc.archivedOn__c = exnewVar.archivedOn;
            acc.fromArchieve__pc = exnewVar.fromArchive;
            acc.officeIds__c = String.valueOf(exnewVar.officeIds);           
            acc.negotiatorId__c = String.valueOf(exnewVar.negotiatorIds);   
            acc.CommunicationPreferenceLetter__pc = exnewVar.communicationPreferenceLetter;
            acc.CommunicationPreferenceEmail__pc = exnewVar.communicationPreferenceEmail;
            acc.CommunicationPreferencePhone__pc = exnewVar.communicationPreferencePhone;
            acc.CommunicationPreferenceSMS__pc = exnewVar.communicationPreferenceSMS;
            //acc.ETag__c = exnewVar
            //acc.Name = exnewVar
            //acc.Branch__c = exnewVar
            //acc.Notes__c = exnewVar
            //acc.Vat_Registered__c = exnewVar
            //acc.TypeId__c = exnewVar
            //acc.Supplier_Type_Id__c = exnewVar
            acc.Line_1__c = exnewVar.primaryAddress.line1;
            acc.Line_2__c = exnewVar.primaryAddress.line2;
            acc.Line_3__c = exnewVar.primaryAddress.line3;
            acc.Line_4__c = exnewVar.primaryAddress.line4;
            acc.Postcode__c = exnewVar.primaryAddress.postcode;
            acc.Country_Id__c = exnewVar.primaryAddress.countryId;
            
            contactList.add(Cont);
            accountList.add(acc); 
         }
        upsert accountList;
        upsert contactList;
        API_Log__c apiLog = new API_Log__c();
            apiLog.Method__c = 'POST';
            apiLog.Object_Name__c = 'Account';        
            apiLog.Request_Body__c = Contactstring;
            //apiLog.Response_Body__c = responseString;
            insert apiLog;
        
        Druce_ReapitResponse.response response = new Druce_ReapitResponse.response();
        Druce_ReapitResponse resWrapper = new Druce_ReapitResponse();
        List<Druce_ReapitResponse.results> resultList = new List<Druce_ReapitResponse.results>();
        Druce_ReapitResponse.results result = new Druce_ReapitResponse.results();
        result.message = 'Account & Contact successfully published into salesforce';
        resultList.add(result);
        response.results = resultList;
        response.Status = 'Success';
        response.status_code = '200';
        
        resWrapper.response = response;
        system.debug('---->');
        
        
    }
}