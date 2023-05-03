public class LeadTriggerHandler {
    
    public static void beforeInsert(List<Lead> newLeads){
        
        //Set<String> postalCodes = new Set<String>();
        //Set<Id> ids = new Set<Id>();
		Map<Id, List<string>> officeIdMap = new Map<Id, List<string>>();
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c AR : [SELECT Id,Public_Group__c,Public_Group__r.Assigned_User__c,Business_Type__c,OfficeId__c 
                                        FROM Assignment_Rule__c WHERE Object__c = 'Lead' AND Active__c = TRUE])
			{
		        groupIds.add(AR.Public_Group__c);
				if(!mapAR.containsKey(AR.OfficeId__c+AR.Business_Type__c)){
                mapAR.put(AR.OfficeId__c+AR.Business_Type__c, new List<Assignment_Rule__c>{AR});
            }
			}
			for(Lead ld : newLeads){
			   if(ld.Office_ID__c != NULL && ld.Lead_Type__c  != NULL){
			      if(mapAR.containsKey(ld.Office_ID__c+ld.Lead_Type__c)){
				    for(Assignment_Rule__c rule : mapAR.get(ld.Office_ID__c+ld.Lead_Type__c)){
					if(rule.Public_Group__r.Assigned_User__c != NULL){
                        ld.OwnerId = rule.Public_Group__r.Assigned_User__c;
                        break;
						}
					}
				}
			}
            }
    }
            }