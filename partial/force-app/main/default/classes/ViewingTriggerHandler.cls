public class ViewingTriggerHandler {
         public static void beforeInsert(List<Viewing__c> newViewings){
        
        Map<Id, List<string>> officeIdMap = new Map<Id, List<string>>();
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c AR : [SELECT Id, Public_Group__c, Public_Group__r.Assigned_User__c, Business_Type__c, OfficeId__c 
                                        FROM Assignment_Rule__c WHERE Object__c = 'Viewing__c' AND Active__c = TRUE])
			{
		        groupIds.add(AR.Public_Group__c);
				if(!mapAR.containsKey(AR.OfficeId__c+AR.Business_Type__c)){
                mapAR.put(AR.OfficeId__c+AR.Business_Type__c, new List<Assignment_Rule__c>{AR});
            }
			}
			
			for(Viewing__c view : newViewings){
			   if(view.Office_ID__c != NULL && view.Opportunity__c != NULL){
			      if(mapAR.containsKey(view.Office_ID__c+view.Opportunity__c)){
				    for(Assignment_Rule__c rule : mapAR.get(view.Office_ID__c+view.Opportunity__c)){
					if(rule.Public_Group__r.Assigned_User__c != NULL){
                        view.OwnerId = rule.Public_Group__r.Assigned_User__c;
                        break;
						}
					}
				}
			}
		}
	}

}