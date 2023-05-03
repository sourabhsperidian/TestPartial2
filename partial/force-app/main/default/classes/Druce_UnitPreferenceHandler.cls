public class Druce_UnitPreferenceHandler {
    public static void afterInsert(List<Unit_Preference__c> newRecords){
        system.debug('---->');
        Set<String> postalCodes = new Set<String>();
        Set<Id> ids = new Set<Id>();
        Map<String, List<Assignment_Rule__c>> mapAR = new Map<String, List<Assignment_Rule__c>>();
        for(Unit_Preference__c up : newRecords){          
            ids.add(up.Id);
        }
        
        Set<Id> groupIds = new Set<Id>();
        for(Assignment_Rule__c oppAR : [SELECT Id,Postal_Code__c,Public_Group__c,Public_Group__r.Assigned_User__c,Country__c,Business_Type__c FROM Assignment_Rule__c WHERE Object__c = 'Opportunity']){
            groupIds.add(oppAR.Public_Group__c);
            if(mapAR.containsKey(oppAR.Business_Type__c)){
                List<Assignment_Rule__c> lst = new List<Assignment_Rule__c>();
                lst.addAll(mapAR.get(oppAR.Business_Type__c));
                lst.add(oppAR);
                mapAR.put(oppAR.Business_Type__c, lst);     
            }else{
                mapAR.put(oppAR.Business_Type__c, new List<Assignment_Rule__c>{oppAR});
            }
        }
        
       // Map<Id, Public_Group__c> mapGrp = new Map<Id, Public_Group__c>([SELECT Id,Name, Assigned_User__c FROM Public_Group__c WHERE Id IN: groupIds]);
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        
        for(Unit_Preference__c up : [SELECT Id, Unit__c, Opportunity__c, Opportunity__r.RecordType.Name, Unit__r.Unit_Address__PostalCode__s,Unit__r.Unit_Address__CountryCode__s
                                     		FROM Unit_Preference__c WHERE Id IN: Ids]){
                                         system.debug('---->');
                                                if(mapAR.containsKey(up.Opportunity__r.RecordType.Name)){
                                                    system.debug('---->');
                                                    for(Assignment_Rule__c rule : mapAR.get(up.Opportunity__r.RecordType.Name)){
                                                     	system.debug('---->');
                                                        if(rule.Public_Group__r.Assigned_User__c != NULL){
                                                            Opportunity opp = new Opportunity();
                                                            opp.Id = up.Opportunity__c;
                                                            opp.OwnerId = rule.Public_Group__r.Assigned_User__c;
                                                            lstOpportunity.add(opp);
                                                            break;  
                                                   	    }
                                                    }
                                                }
                                           /*     
                                         if(up.Unit__r.Unit_Address__CountryCode__s == 'GB'){
                                             system.debug('---->');
                                             if(mapAR.containsKey(up.Unit__r.Unit_Address__CountryCode__s)){
                                                 system.debug('---->');
                                                 for(Assignment_Rule__c rule : mapAR.get(up.Unit__r.Unit_Address__CountryCode__s)){
                                                     system.debug('---->');
                                                     if(up.Opportunity__r.RecordType.Name == rule.Business_Type__c ){
                                                         system.debug('---->');
                                                         if(rule.Postal_Code__c.contains(up.Unit__r.Unit_Address__PostalCode__s)){
                                                             Opportunity opp = new Opportunity();
                                                             opp.Id = up.Opportunity__c;
                                                             if(mapGrp.containsKey(rule.Public_Group__c)){
                                                                 if(mapGrp.get(rule.Public_Group__c).Assigned_User__c != NULL){
                                                                    opp.OwnerId = mapGrp.get(rule.Public_Group__c).Assigned_User__c;
                                                                 	lstOpportunity.add(opp);
                                                                 	break;  
                                                                 }
                                                             }
                                                         }
                                                     }
                                                 }
                                             }
                                         }else{
                                          
                                         }
*/
                                     }
        
        if(!lstOpportunity.isEmpty()){
            update lstOpportunity;
        }
        
    }
}