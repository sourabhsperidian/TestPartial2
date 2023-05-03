public class Druce_PropertiesSync {
    
    public static void SyncPropertiesData(List<Unit__c> lstRecords){
        Set<String> Ids = new Set<String>();
        for(Unit__c unit :lstRecords){
            ids.add(unit.Id);
        }        
        Druce_SecondaryPropertyAPI.doPostCallout(ids);
    }

}