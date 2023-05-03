trigger DXFProjectAPICall on Project__c (after insert, after update) {
    if(Trigger.isInsert){
     if(!System.isFuture() && !System.isBatch())
     {
         Set<String> recIds = new Set<String>();
         for(Project__c proj : Trigger.New)
         {
             //   String ProjId = Proj.Id;
             recIds.add(proj.Id);
        
         }
         if(recIds.size()>0)
         {
       // ProjectSync.doPostCallout(recIds);
         }
     }
     }
     if(Trigger.isUpdate){
     if(!System.isFuture() && !System.isBatch())
     {
         Set<String> recIds = new Set<String>();
         for(Project__c proj : Trigger.New)
         {
             //   String ProjId = Proj.Id;
             recIds.add(proj.Id);
        
         }
         if(recIds.size()>0)
         {
       // ProjectSync.doPostCallout(recIds);
         }
     }
     }
}