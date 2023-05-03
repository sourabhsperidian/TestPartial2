trigger ReapitDataSync on Unit__c (after update) {
    for (Unit__c unit : Trigger.new){
        if(unit.Record_Type_Name__c!='Primary UK' && unit.Unit_Path__c !='Published' && unit.Reapit_Id__c !=null && unit.Reapit_Internet_Advertising__c== true && (System.isBatch()||System.isQueueable())){
           
                if(unit.CountOfReapitImages__c !=null &&  unit.CountAmazonFiles__c !=null){
                    if (unit.CountOfReapitImages__c == unit.CountAmazonFiles__c){
                        
                        Druce_PropertiesSync.SyncPropertiesData(trigger.new);
                    }
                }
            }
        
    }
}