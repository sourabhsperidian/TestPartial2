trigger OpportunityTrigger on Opportunity (before insert, after insert, after update) {
    if(trigger.isInsert && trigger.isBefore){
        OpportunityAssignmentTriggerClass.beforeInsert(trigger.new);
    }
    //Send email on assignment start
    Messaging.Email[] emails = new Messaging.Email[] {};
        for(Opportunity opp: trigger.new){
            if((trigger.isUpdate && trigger.isAfter && opp.OwnerId != trigger.oldMap.get(opp.ID).OwnerId) || trigger.isInsert && trigger.isAfter){
                
                Opportunity op = [SELECT Office_ID__c,recordtype.name,name FROM Opportunity WHERE Id = :opp.ID];
                
                List<Assignment_Rule__c> lstAR = [SELECT Public_group__r.email__c FROM Assignment_Rule__c WHERE officeid__c = :op.Office_ID__c AND business_type__c = :op.recordtype.name AND Object__c = 'Opportunity' AND Active__c = TRUE];
                if(lstAR.size() > 0){
                    EmailTemplate template = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Opportunity_Assignment_Notification'];
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new List<String>{lstAR[0].Public_group__r.email__c});
                    email.setSubject(template.Subject);
                    string emailMsg = template.Body.replace('{!Opportunity.Name}', op.Name);
                    emailMsg = emailMsg.replace('{!Opportunity.RecordType}', op.RecordType.Name);
                    email.setPlainTextBody(emailMsg);
                    email.setTemplateId(template.Id);
                    email.setWhatId(op.Id);
                    emails.add(email);
                    //Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
                }
            }   
        }
    if(emails.size() > 0){
        Messaging.sendEmail(emails);
        //Send email on assignment End
    } 
}