public class OpportunityAssignmentTriggerHandler{
    
    public static void beforeInsert(List<Opportunity> newOpportunities){
     
        Map<Id, List<string>> officeIdMap = new Map<Id, List<string>>();
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c AR : [SELECT Id, Public_Group__c, Public_Group__r.Assigned_User__c, Business_Type__c, OfficeId__c
                                      FROM Assignment_Rule__c 
                                      WHERE Object__c = 'Opportunity' AND Active__c = TRUE])
        {
            groupIds.add(AR.Public_Group__c);
            if(!mapAR.containsKey(AR.OfficeId__c + AR.Business_Type__c)){
                mapAR.put(AR.OfficeId__c + AR.Business_Type__c, new List<Assignment_Rule__c>{AR});
            }
        }
        
        for(Opportunity opp : newOpportunities){
            if(opp.Office_ID__c != null && opp.RecordTypeId  != null){
                
                
                if(mapAR.containsKey(opp.Office_ID__c + opp.recordtype.name ))
                 {
                    
                    for(Assignment_Rule__c rule : mapAR.get(opp.Office_ID__c + opp.recordtype.name )){
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