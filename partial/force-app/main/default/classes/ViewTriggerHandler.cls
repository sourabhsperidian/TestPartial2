public class ViewTriggerHandler {
  public static void beforeInsert(List<Viewing__c> newViews){
        
        Set<Id> oppids = new Set<Id>();
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        for(Viewing__c view : newViews){
            
            if(view.Opportunity__c != NULL){
                oppIds.add(view.Opportunity__c);
            }
        }
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c AR : [SELECT Id,Public_Group__c, Public_Group__r.Assigned_User__c,Business_Type__c FROM Assignment_Rule__c WHERE Object__c = 'View' AND Active__c = TRUE]){
          groupIds.add(AR.Public_Group__c);
           // groupIds.add(AR.Public_Group__c);
            if(!mapAR.containsKey(AR.Business_Type__c)){                
                mapAR.put(AR.Business_Type__c, new List<Assignment_Rule__c>{AR});
            }
        }
        
        Map<Id, Public_Group__c> mapGrp = new Map<Id, Public_Group__c>([SELECT Id,Name, Assigned_User__c FROM Public_Group__c WHERE Id IN: groupIds]);        
        
        Map<Id, Opportunity> mapOpp = new Map<Id, Opportunity>([SELECT Id,RecordType.Name,(SELECT Id,Unit__c,Unit__r.Unit_Address__CountryCode__s,Unit__r.Unit_Address__PostalCode__s FROM Unit_Preferences__r) FROM Opportunity WHERE Id IN: oppIds]);
        
        for(Viewing__c view : newViews){
            if(mapOpp.containsKey(view.Opportunity__c)){
                Opportunity op = mapOpp.get(view.Opportunity__c);
				if(op.Unit_Preferences__r.size() >0 ){
					if(mapAR.containsKey(op.RecordType.Name))
                    {
                        for(Assignment_Rule__c rule : mapAR.get(op.RecordType.Name)){
							system.debug('---->');
                        	if(op.RecordType.Name == rule.Business_Type__c ){
                            	if(rule.Public_Group__r.Assigned_User__c != NULL){
                                	view.OwnerId = rule.Public_Group__r.Assigned_User__c;
                                	break;
                            	}                            
                        	} 
                    	}
                	}
				}
               /* if(op.Unit_Preferences__r.size() >0 ){
                if(op.Unit_Preferences__r[0].Unit__r.Unit_Address__CountryCode__s == 'GB'){
                    if(mapAR.containsKey(op.Unit_Preferences__r[0].Unit__r.Unit_Address__CountryCode__s)){
                      for(Assignment_Rule__c rule : mapAR.get(op.Unit_Preferences__r[0].Unit__r.Unit_Address__CountryCode__s)){
                          system.debug('---->');
                            if(op.RecordType.Name == rule.Business_Type__c ){
                                if(rule.Postal_Code__c.contains(op.Unit_Preferences__r[0].Unit__r.Unit_Address__PostalCode__s)){                                  
                                    if(mapGrp.containsKey(rule.Public_Group__c)){
                                      if(mapGrp.get(rule.Public_Group__c).Assigned_User__c != NULL){
                                          view.OwnerId = mapGrp.get(rule.Public_Group__c).Assigned_User__c;
                                            break;  
                                         }
                                     }
                                 }
                            }
                         
                        }
                    }
                
                }
            }*/
            }
        }
        
    }
}