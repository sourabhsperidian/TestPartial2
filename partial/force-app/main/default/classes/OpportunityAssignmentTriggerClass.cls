public class OpportunityAssignmentTriggerClass {
    public static void beforeInsert(List<Opportunity> newOpportunities){  
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        for(Assignment_Rule__c AR : [SELECT Id, Public_Group__c, Public_Group__r.Assigned_User__c, Business_Type__c, OfficeId__c
                                     FROM Assignment_Rule__c WHERE Object__c = 'Opportunity' AND Active__c = TRUE]){
                                         if(!mapAR.containsKey(AR.OfficeId__c + AR.Business_Type__c)){
                                             mapAR.put(AR.OfficeId__c + AR.Business_Type__c, new List<Assignment_Rule__c>{AR});
                                         }
                                     }
        
        for(Opportunity opp : newOpportunities){
            if(opp.Office_ID__c != null && opp.recordtypeID != null){
                string opRecType = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(opp.recordtypeID).getName();
                if(mapAR.containsKey(opp.Office_ID__c + opRecType)){
                    for(Assignment_Rule__c rule : mapAR.get(opp.Office_ID__c + opRecType)){
                        if(rule.Public_Group__r.Assigned_User__c != null){
                            opp.OwnerId = rule.Public_Group__r.Assigned_User__c;
                            break;
                        }
                    }
                }
            }
        }
    }
}