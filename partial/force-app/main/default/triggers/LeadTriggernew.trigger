trigger LeadTriggernew on Lead (before insert,after insert, after update) {
    if(trigger.isInsert && trigger.isBefore){
        LeadTriggerHandler.beforeInsert(trigger.new);
    }
    //Send email on assignment start
    Messaging.Email[] emails = new Messaging.Email[] {};
        for(Lead ld: trigger.new){
            if(trigger.isUpdate && trigger.isAfter && ld.OwnerId != trigger.oldMap.get(ld.ID).OwnerId || (trigger.isInsert && trigger.isAfter)){
                Lead ldnew = [SELECT Office_ID__c,Lead_Type__c,name FROM Lead WHERE Id = :ld.ID];
                
                List<Assignment_Rule__c> AR = [SELECT Public_group__r.email__c FROM Assignment_Rule__c WHERE OfficeId__c = :ldnew.Office_ID__c AND Business_Type__c = :ldnew.Lead_Type__c AND Object__c = 'Lead' AND Active__c = TRUE];
                
                if(AR.size() > 0){
                    EmailTemplate template = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Lead_Assignment_Notification'];
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new List<String>{AR[0].Public_group__r.email__c});
                    email.setSubject(template.Subject);
                    string emailMsg = template.Body.replace('{!Lead.Name}', ldnew.Name);
                    emailMsg = emailMsg.replace('{!Lead.Lead_Type__c}', ldnew.Lead_Type__c);
                    email.setPlainTextBody(emailMsg);
                    email.setTemplateId(template.Id);
                    //email.setWhatId(ldnew.Id);
                    emails.add(email);
                    //Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
                }
                
            }
            
        }
    if(emails.size() > 0){
        Messaging.sendEmail(emails);
        //Send email on assignment End
    }    
    //Send email on assignment End
}