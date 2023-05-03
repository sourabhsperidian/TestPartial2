global class ReapitImagesBatch implements Database.Batchable<sObject>,  Database.AllowsCallouts {
    
	global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id FROM Reapit_Image__c Limit 1';
       
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Reapit_Image__c> scope)
    {
        //AWSIntegration.SyncReapitImages(scope);
    }
    
    global void finish(Database.BatchableContext BC) {
    }
}