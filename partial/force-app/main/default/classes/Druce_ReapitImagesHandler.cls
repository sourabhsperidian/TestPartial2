public class Druce_ReapitImagesHandler {
    public static void propertyImageSync(string imageString){
        ReapitImagesWrapper requestWrapperImg = (ReapitImagesWrapper)JSON.deserialize(imageString, ReapitImagesWrapper.class); 
        
        if(requestWrapperImg.embedded != NULL){
            system.debug('--->'+requestWrapperImg.embedded);
            reapitImagesWrapper.embedded imageWrapper = requestWrapperImg.embedded;
            
            Reapit_Image__c image = new Reapit_Image__c();
            image.Caption__c = imageWrapper.caption;
            image.eTag__c = imageWrapper.eTag;
            image.Image_Url__c = imageWrapper.url;
            image.Reapit_Id__c = imageWrapper.Id;
            
            Unit__c unit = [SELECT Id, Name FROM Unit__c WHERE Reapit_Id__c =: imageWrapper.propertyId]; 
            
            image.Unit__c = unit.Id;
            system.debug('exnewVar.type ::'+imageWrapper.type);
            image.Type__c = String.valueOf(imageWrapper.type);
            image.Name = imageWrapper.id;
            upsert image Reapit_Id__c;
            
            Amazon_Files__c af = new Amazon_Files__c();
            af.Name = imageWrapper.id;
            af.Status__c = 'New';
            af.Unit__c = unit.Id;
            af.Reapit_Image_Url__c = imageWrapper.url;
            String typeImage = String.valueOf(imageWrapper.type);
            if(typeImage == 'floorPlan'){
                af.Floor_Plan__c = TRUE; 
            }
            if(typeImage == 'epc'){
                af.EPC__c = TRUE;
            }
            if(typeImage == 'Primary'){
                af.Is_Primary__c = TRUE;
            }
            upsert af;
            Druce_PublishUnitwithFiles.publishPropertiesWithFiles(new Set<String>{image.Unit__c});
            //Druce_SecondaryPropertyAPI.SyncProperties();
            API_Log__c apiLog = new API_Log__c();
            apiLog.Method__c = 'POST';
            apiLog.Object_Name__c = 'Reapit_Images__c';        
            apiLog.Request_Body__c = imageString;
           // apiLog.Response_Body__c = responseString;
            
            //insert apiLog;
            
        }        
    }
    
}