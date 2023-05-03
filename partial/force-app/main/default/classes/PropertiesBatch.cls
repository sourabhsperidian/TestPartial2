global class PropertiesBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    public Database.QueryLocator start(Database.BatchableContext BC){
		string unitPath = 'Published';
        string Reapit_id ='LNH230017';
        String query = 'SELECT Id from Unit__c WHERE Reapit_Id__c != NULL AND  Reapit_Id__c = :Reapit_id AND Unit_Path__c != :unitpath';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Unit__c> unitLst) {
        system.debug('Size : '+unitLst.size());
        for(Unit__c unit : unitLst){
            Druce_SecondaryPropertyAPI.SyncProperties(new Set<String>{unit.Id});
        }
          
    }
    
    public void finish(Database.BatchableContext BC){
    }
    
}