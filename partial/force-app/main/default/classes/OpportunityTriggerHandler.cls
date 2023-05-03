public class OpportunityTriggerHandler {
	public static void beforeInsert(List<Opportunity> newOpps){
    	
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c AR : [SELECT Id,Postal_Code__c,Public_Group__c,Public_Group__r.Assigned_User__c,Country__c,Business_Type__c 
                                        FROM Assignment_Rule__c WHERE Object__c = 'View' AND Active__c = TRUE]){
            groupIds.add(AR.Public_Group__c);
            /*
            if(!mapAR.containsKey(oppAR.Country__c)){                
                mapAR.put(oppAR.Country__c, new List<Assignment_Rule__c>());
            }
            mapAR.get(oppAR.Country__c).add(oppAR);*/
            if(!mapAR.containsKey(AR.Business_Type__c)){                
                mapAR.put(AR.Business_Type__c, new List<Assignment_Rule__c>());
            }
            mapAR.get(AR.Business_Type__c).add(AR);
        }
		
        for(Opportunity opp : [SELECT Id,RecordTypeId, RecordType.Name FROM Opportunity]){
            if(mapAR.containskey(opp.RecordType.Name)){
                
            }            
        }        
    }
}