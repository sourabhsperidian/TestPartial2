public class ViewInterestTriggerHandler {
  public static void beforeInsert(List<View_Interest__c> newRecords){
        
        Set<Id> Ids = new Set<Id>();
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        
        for(View_Interest__c vi : newRecords){
            Ids.add(vi.Name__c);
        }
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c AR : [SELECT Id,Public_Group__c,Business_Type__c FROM Assignment_Rule__c WHERE Object__c = 'View Interest' AND Active__c = TRUE]){
          groupIds.add(AR.Public_Group__c);
            if(!mapAR.containsKey(AR.Business_Type__c)){                  
                mapAR.put(AR.Business_Type__c, new List<Assignment_Rule__c>{AR});
            }
        }
        
        Map<Id, Public_Group__c> mapGrp = new Map<Id, Public_Group__c>([SELECT Id,Name, Assigned_User__c FROM Public_Group__c WHERE Id IN: groupIds]);
        
        Map<Id,Account> mapAcc = new Map<Id, Account>([SELECT Id,ShippingCountry,ShippingPostalCode FROM Account WHERE Id IN: Ids]);
        
		for(View_Interest__c vi : newRecords){
            if(mapAcc.containsKey(vi.Name__c)){
                system.debug('3 ::');
                if(mapAR.containsKey(vi.Interest_Type__c)){
                    for(Assignment_Rule__c rule : mapAR.get(vi.Interest_Type__c)){
                        if(vi.Interest_Type__c == rule.Business_Type__c ){
                            if(rule.Public_Group__r.Assigned_User__c !=  NULL){
                                vi.OwnerId = rule.Public_Group__r.Assigned_User__c;
                                break;
                            }
                        }
                    }
                }
            }
        }
		
        /*for(View_Interest__c vi : newRecords){
            if(mapAcc.containsKey(vi.Name__c)){
                system.debug('1 ::');
              if(mapAcc.get(vi.Name__c).ShippingCountry == 'United Kingdom'){
                    system.debug('2 ::');
                    if(mapAR.containsKey('GB')){
                        system.debug('3 ::');
                        if(String.isNotBlank(mapAcc.get(vi.Name__c).ShippingPostalCode)){
                            system.debug('4 ::');
                          for(Assignment_Rule__c rule : mapAR.get('GB')){
                              if(vi.Interest_Type__c == rule.Business_Type__c ){
                                  if(rule.Postal_Code__c.contains(mapAcc.get(vi.Name__c).ShippingPostalCode)){
                                      if(mapGrp.containsKey(rule.Public_Group__c)){
                                          vi.OwnerId = mapGrp.get(rule.Public_Group__c).Assigned_User__c;
                                          break;
                                        }
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