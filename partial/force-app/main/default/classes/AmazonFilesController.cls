public class AmazonFilesController {
    @AuraEnabled
    public static String getProjectId(String recordid){
        List<Unit__c> unit=[select Project_Unit_Type__r.Id,Project_Unit_Type__r.project__r.Id from Unit__c where Id=:recordid];
        system.debug(unit[0].Project_Unit_Type__c);
        string punitid= unit[0].Project_Unit_Type__c;
        List<Project_Unit_Type__c> putype = [select Project__r.Id from Project_Unit_Type__c where Id =:punitid];
        system.debug(putype[0].Project__c);
        return putype[0].Project__c;
    }
    @AuraEnabled
    public static List<Amazon_Files__c> getAmazoneFiles(String unitId, String objectName){
        system.debug('objectName');
                     system.debug('unitId');
        if(objectName=='Project__c')
             return [select Id,Name,Description__c,Status__c,Is_Primary__c,EPC__c, Floor_Plan__c from Amazon_Files__c where (Status__C='New' OR Status__C='Error')AND Project_Id__c =:unitId AND Reapit_image_url__c = ''];
            else
        return [select Id,Name,Description__c,Status__c,Is_Primary__c,EPC__c, Floor_Plan__c from Amazon_Files__c where (Status__C='New' OR Status__C='Error')AND Unit__c =:unitId AND Reapit_image_url__c = ''];
        
    }
    @AuraEnabled
    public static void deletefile(Amazon_Files__c objfiles){
        try {
            String objId = ((object) objfiles.get('id')).tostring();
          //  ID objId = objfiles.Id;
       		system.debug('objId'+ objId);
            
            List <ContentDocumentLink> cnD = [SELECT Id,ContentDocument.Id,ContentDocument.Title, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId= :objfiles.Id];
            system.debug('cnD'+ cnD.size());
            if(cnD.size() != 0)
            {
             system.debug('loop enterd');   
            List<ContentDocument> cd = [Select Id from ContentDocument where Id = :cnD[0].ContentDocument.Id];
            delete objfiles;
            system.debug('objfiles' + objfiles);
            delete cd;
            }
            else 
               delete objfiles; 
            
        }
        catch(Exception ex) {
            
            system.debug(ex.getMessage());
        }
    }
     @AuraEnabled
    public static string getPrimaryImgURL(String unitId){
        Amazon_Files__c amzFile  = [Select Path_Url__c from Amazon_Files__c where Unit__c=:unitId and Is_Primary__c = true];
        return amzFile.Path_Url__c;
    }
    @AuraEnabled
    public static List<Amazon_Files__c> createemptyfile(string unitId, string objectName,String FileNameVal, String DescriptionVal, Boolean isPrimary, Boolean EPC, Boolean FloorPlan){
        
        try{
   		If(objectName == 'Project__c')// Monika: For Project File upload
        {
            List<Amazon_Files__c> priFile = [Select Id, Name, Is_Primary__c from Amazon_Files__c where (Project_Id__c =:unitId AND Is_Primary__c = true)];
            List<Amazon_Files__c> epcFile = [Select Id, Name, EPC__c from Amazon_Files__c where (Project_Id__c =:unitId AND EPC__c = true)];
            
            system.debug('prifiles' +priFile);
            if((priFile.size() > 0 && isPrimary ==true) || (epcFile.size() > 0 && EPC ==true))
            return null;
            else
            {
                Insert new Amazon_Files__c(Name= FileNameVal ,Status__c='New',Project_Id__c= unitId, Description__c = DescriptionVal,
                                           Is_Primary__c = isPrimary, EPC__c = EPC, Floor_Plan__c = FloorPlan);
                return [select Id,Name,Description__c,Is_Primary__c,Status__c,EPC__c, Floor_Plan__c from Amazon_Files__c  where (Status__C='New'OR Status__C='Error')AND Project_Id__c =:unitId order by createdDate desc];
            }
           
        }
        else 
        {
            List<Amazon_Files__c> priFile = [Select Id, Name, Is_Primary__c from Amazon_Files__c where (Unit__c =:unitId AND Is_Primary__c = true)];
            List<Amazon_Files__c> epcFile = [Select Id, Name, EPC__c from Amazon_Files__c where (Unit__c =:unitId AND EPC__c = true)];
            if((priFile.size() > 0 && isPrimary == true) || (epcFile.size() > 0 && EPC ==true))
                return null;
            
            else
              {
       			 Insert new Amazon_Files__c(Name= FileNameVal ,Status__c='New',unit__c= unitId, Description__c = DescriptionVal,
                  Is_Primary__c	= isPrimary, EPC__c = EPC, Floor_Plan__c = FloorPlan );
         			return [select Id,Name,Description__c,Is_Primary__c,Status__c,EPC__c, Floor_Plan__c from Amazon_Files__c  where (Status__C='New'OR Status__C='Error')AND Unit__c =:unitId order by createdDate desc];
            }	
            
            } 
        }
        catch(Exception e){
            return null;
        }
    }
    
}