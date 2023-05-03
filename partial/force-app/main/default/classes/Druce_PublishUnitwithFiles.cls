public class Druce_PublishUnitwithFiles {
    
    @future(callout=true)
    public static void publishPropertiesWithFiles(Set<String> unitIds){
    	system.debug('---->');
        List<Unit__c> lstUnit = [SELECT Id, Project_Unit_Type__r.Project__c,Project_Unit_Type__c,(SELECT Id,Name,Floor_Plan__c,EPC__C,Reapit_Image_Url__c,Unit__c,
                                          Unit__r.Project_Unit_Type__r.Project__c,Unit__r.Project_Unit_Type__c
                                         FROM Amazon_Files__r WHERE Unit__c IN: unitIds AND Reapit_Image_Url__c != '' AND Status__c = 'New') 
                           FROM Unit__c WHERE Id IN: unitIds];
        
        List<Amazon_Files__c> lstFiles = [SELECT Id,Name,Floor_Plan__c,EPC__C,Reapit_Image_Url__c,Unit__c,
                                          Unit__r.Project_Unit_Type__r.Project__c,Unit__r.Project_Unit_Type__c
                                         FROM Amazon_Files__c WHERE Unit__c IN: unitIds AND Reapit_Image_Url__c != ''];
        
        List<Druce_ReapitImagesWrapper> wrapperLst = new List<Druce_ReapitImagesWrapper>();
        Druce_ReapitImagesWrapper wrap = new Druce_ReapitImagesWrapper();
        List<Druce_ReapitImagesWrapper.data> wrapDataLst = new List<Druce_ReapitImagesWrapper.data>();
        
        /********************** Get Access Token *************************************************/        
        String token  = Druce_PortalAuthentication.getToken();
        for(Unit__c unit : lstUnit){
        for(Amazon_Files__c img : unit.Amazon_Files__r){            
            Druce_ReapitImagesWrapper.data wrapData = new Druce_ReapitImagesWrapper.data();
            wrapData.id = img.Id;
            wrapData.name = img.Name;
            wrapData.fileUrl = img.Reapit_Image_Url__c;            
            wrapDataLst.add(wrapData);
        }
        wrap.data = wrapDataLst;
        
        String postbody = JSON.serialize(wrap);       
        System.debug(postbody);
        
        String pathname = lstUnit[0].Project_Unit_Type__r.Project__c+'/'+lstUnit[0].Project_Unit_Type__c+'/'+lstUnit[0].id+'/';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // request.setHeader('Authorization', 'Bearer ' + token);
        request.setMethod('POST');
        request.setHeader('projectid', lstUnit[0].Project_Unit_Type__r.Project__c);
        request.setHeader('unitid', lstUnit[0].id);
        request.setHeader('path', pathName);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setTimeout(120000);
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setEndpoint('https://dxsfapi.speridian.com/api/v1/sf/fileUrlUpload');
        
        request.setBody(postbody);
        system.debug('RequestBody: ' + postbody);
        system.debug('Request: ' + request);
        
        HttpResponse response = http.send(request);
        system.debug('response: ' + response.getBody());
            if(response.getStatusCode() == 200){
            	Map<String, Object> resbody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                List<Object> responses = (List<Object>)resbody.get('response');
                system.debug('responses2'+ responses);
                List<Amazon_files__c> lstUpdate = new List<Amazon_files__c>();
                Integer CountAmazonFiles = 0;
                for(object objvar : responses){
                    Map<String, Object> mainresponse = (Map<String, Object>)objvar;
                    system.debug(mainresponse.size());
                    system.debug(mainresponse);
                    String S3imageId = ((object) mainresponse.get('id')).tostring();
                    String sfid = ((object) mainresponse.get('sfFileId')).tostring();
                    Map<String, Object> datastruct = (Map<String, Object>)mainresponse.get('data');
                    object path = (object) datastruct.get('path');
                    String url = path.tostring();
                    system.debug(url);
                    Amazon_files__c file = new Amazon_files__c(Path_Url__c = Url,Id=sfid,Status__c='Submitted',S3_Response__c=response.getBody(), S3_Response_Id__c = S3imageId);                   
                	lstUpdate.add(file);
                    if(!lstUpdate.isEmpty()){
                        Druce_SecondaryPropertyAPI.SyncProperties(new Set<String>{lstUnit[0].Id});
                        update lstUpdate;
                        
                    }
                }
            }
    	}
	}

}