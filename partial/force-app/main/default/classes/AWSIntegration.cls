public class AWSIntegration {
    
    public static string ContentType(string fileType)
    {
        switch on fileType.toLowerCase()
        {
            when 'docx'
            {
                return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            }
            when 'csv'
            {
                return 'application/vnd.ms-excel';
            }
            when 'wav'
            {
                return 'audio/wav';
            }
            when 'wmv'
            {
                return 'video/x-ms-wmv';
            }
            when 'mp3'
            {
                return 'audio/mpeg';
            }
            when 'mp4'
            {
                return 'video/mp4';
            }
            when 'png'
            {
                return 'image/png';                
            }
            when 'pdf'
            {
                return 'application/pdf';                
            }
            when 'jpg'{
                return 'image/jpg';  
            }
            when 'txt'{
                return 'text/plain'; 
            }
            when else {
                return 'image/jpeg';
            }
        }
    }
    
    @AuraEnabled
    public static void UploadDocuments(List<Amazon_files__c> amf, String objectName)
    {
        system.debug('objectName' + objectName);
        Map<Id,String> amfMap = new Map<Id,String>();
        Map<Id,String> cnlmap = new Map<Id,String>();
        Map<Id,Id> contentLinkMap = new Map<Id,Id>();
        String pathname;
      
        List<Amazon_files__c> amfiles = [Select Unit__r.Project_Unit_Type__r.Id,Unit__c,Project_Id__c 
                                         FROM Amazon_files__c WHERE Id = :amf[0].Id];
        List<Project_Unit_Type__c> prjct;
        Id projectId;
        Id unitId;
        if(objectName == 'Project__c')  
        {
            projectId = amfiles[0].Project_Id__c;
            pathname = projectId+'/';
        }
        else
        {
            prjct = [select Id,Project__c from Project_Unit_Type__c where Id =:amfiles[0].Unit__r.Project_Unit_Type__r.Id];
            projectId = prjct[0].Project__c;
            unitId = amfiles[0].Unit__c;
            Id punitId = prjct[0].Id;
            pathname = projectId+'/'+punitId+'/'+unitId+'/';
        }
        // String pathname = 'projectId+'/'+punitId+'/'+ unitId +'/'';
        //String pathname = 'https://dxsfapi.speridian.com/api/v1/sf/binaryFiles/'+Projectid+'/'+puitid+'/'+unitId+'/'+fname+ '.'+fileext.toLowerCase();
        for(Amazon_files__c am : amf){
            amfMap.put(am.Id,am.Name);
        }
        
        List<ContentDocumentLink> cnD = [SELECT Id,ContentDocument.Id,ContentDocument.Title, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :amfMap.keyset()];
        for(ContentDocumentLink cn:cnD){
            if(amfMap.containsKey(cn.LinkedEntityId)){
                cnlMap.put(cn.ContentDocument.Id,amfMap.get(cn.LinkedEntityId)); 
                contentLinkMap.put(cn.ContentDocument.Id,cn.LinkedEntityId);
            }
        }
        List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE ContentDocumentId  IN :cnlMap.keyset()];
        
        for(ContentVersion attach:versions)
        {
            try
            {
                //File Content
                String attachmentBody = EncodingUtil.base64Encode(attach.VersionData);
                String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
                String filename = EncodingUtil.urlEncode(attach.Title, 'UTF-8');
                string contentType=ContentType(attach.FileExtension); //No need to render extension
                system.debug('attachmentBody:'+attachmentBody);
                string fname= cnlMap.get(attach.ContentDocumentId); 
                //  system.debug(fname);
                Blob pdfBlob = EncodingUtil.base64Decode(attachmentBody);
                sendresp(fname,projectId,unitId,contentType,pdfBlob,contentLinkMap,attach.ContentDocumentId,attach.VersionData,attach.FileExtension,pathname);   
                //projectId,punitId,unitId,
            }
            catch(Exception ex)
            {
                system.debug('Exception RaisedLine '+ex.getLineNumber());
                system.debug('Exception Raised' + ex.getMessage());
                List<ContentDocumentLink> cndl = [SELECT Id,ContentDocument.Id,ContentDocument.Title, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocument.Id= :attach.ContentDocumentId AND LinkedEntityId=:contentLinkMap.get(attach.ContentDocumentId)];  
                List<ContentDocument> cd = [Select Id from ContentDocument where Id = :cndl[0].ContentDocument.Id];
                delete cd;
            }
        }
    }
    
    @AuraEnabled
    @future(callout=true)
    public static void sendresp(String fname,Id projId, Id unitId,string ContentType,Blob pfbl,Map<Id,Id> cntlinkmap,Id cntdocId, blob attachmentBody, String fileext, String pathname){
        //String Projectid,string puitid,string unitId
        
        try{
        String token = Druce_PortalAuthentication.getToken();// Monika: Get Token Value
        if(token != '' || token != null)
        {
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://dxsfapi.speridian.com/api/v1/sf/binaryFiles');
            req.setHeader('Authorization', 'Bearer ' + token );
            req.setHeader('Content-Type', ContentType);
            req.setHeader('path', pathname);
            if(unitId != null){
                req.setHeader('unitid', unitId);}
                req.setHeader('projectid', projId);
                req.setHeader('filename', fname);
                req.setBodyAsBlob(attachmentBody);
                req.setTimeout(100000);
            
                system.debug('pfbl: ' + pfbl);
                Http http = new Http();
                system.debug('Request: ' + req);
                system.debug('Authorization: ' + req.getHeader('Authorization'));
                system.debug('filename: ' + req.getHeader('filename'));
                system.debug('unitid: ' + req.getHeader('unitid'));
                system.debug('projectid: ' + req.getHeader('projectid'));
                
                HTTPResponse res = http.send(req);
                system.debug('responses1'+ res.getBody());
                
                API_Log__c apiLog = new API_Log__c();
                apiLog.Method__c = 'POST';
                apiLog.Object_Name__c = 'Amazon_files__c';
            	
                if( req.getBody().length() <= 131000){
                    apiLog.Request_Body__c = req.getBody();
                }else{
                    apiLog.Request_Body__c = req.getBody().substring(0, 131000);
                }
                
                apiLog.Response_Body__c = res.getBody();
                insert apiLog;
            
                if (res.getStatusCode() == 200 || res.getStatusCode()==201) 
                {
                    
                    Map<String, Object> resbody = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                    List<Object> responses = (List<Object>)resbody.get('response');
                    system.debug('responses2'+ responses);
                    Map<String, Object> mainresponse = (Map<String, Object>)responses[0];
                    system.debug(mainresponse);
                    String S3imageId = ((object) mainresponse.get('id')).tostring();
                    Map<String, Object> datastruct = (Map<String, Object>)mainresponse.get('data');
                    object path = (object) datastruct.get('path');
                    String url = path.tostring();
                    system.debug(url);
                    //String Url = 'https://dxsfapi.speridian.com/api/v1/sf/binaryFiles/'+Projectid+'/'+puitid+'/'+unitId+'/'+fname+ '.'+fileext.toLowerCase();
                    if(cntlinkmap.containsKey(cntdocId)){
                        //      system.debug(cntlinkmap.get(cntdocId));
                        update new Amazon_files__c(Path_Url__c =Url,Id=cntlinkmap.get(cntdocId),Status__c='Submitted',S3_Response__c=res.getBody(), S3_Response_Id__c = S3imageId);
                        List<ContentDocumentLink> cndl = [SELECT Id,ContentDocument.Id,ContentDocument.Title, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocument.Id= :cntdocId AND LinkedEntityId=:cntlinkmap.get(cntdocId)];  
                        List<ContentDocument> cd = [Select Id from ContentDocument where Id = :cndl[0].ContentDocument.Id]; 
                        delete cd;
                    }                
                }
            else{
                if(cntlinkmap.containsKey(cntdocId)){
                        //      system.debug(cntlinkmap.get(cntdocId));
                        update new Amazon_files__c(Id=cntlinkmap.get(cntdocId),Status__c='Failed',S3_Response__c=res.getBody());
                   //     List<ContentDocumentLink> cndl = [SELECT Id,ContentDocument.Id,ContentDocument.Title, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocument.Id= :cntdocId AND LinkedEntityId=:cntlinkmap.get(cntdocId)];  
                   //     List<ContentDocument> cd = [Select Id from ContentDocument where Id = :cndl[0].ContentDocument.Id]; 
                    //    delete cd;
                    }
            }
            system.debug('Response recieved: ' + res);
        }
        }
        catch(Exception e)
        {
            system.debug('Exception: ' + e.getMessage());
        }
    }
    
    /*
    public static void SyncReapitImages(List<Reapit_Image__c> imagesList){
        Set<String> ids = new Set<String>();
        for(Reapit_Image__c ri : imagesList){
            ids.add(ri.Id);
        }
        
        List<Reapit_Image__c> lstrecords = [SELECT Id,Name,Unit__c,Unit__r.Project_Unit_Type__c,
                                            Unit__r.Project_Unit_Type__r.Project__c,Image_Url__c
                                            FROM Reapit_Image__c WHERE Id IN: ids  ];
        for(Reapit_Image__c rec : lstrecords){
            
            String base64Data = '';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(rec.Image_Url__c);
            req.setMethod('GET');
            Http http = new Http();
            HttpResponse res = http.send(req);
            Blob image = res.getBodyAsBlob();
            base64Data =  EncodingUtil.base64Encode(image);
            
            String pathname = rec.Unit__r.Project_Unit_Type__r.Project__c+'/'+rec.Unit__r.Project_Unit_Type__c+'/'+rec.Unit__c+'/';
            sendImagesToS3(rec.Name, rec.Unit__r.Project_Unit_Type__r.Project__c,rec.Unit__c,'jpg',image,'.jpg',pathname);
        }
        
    }
    
    public static void sendImagesToS3(String fname,String projId, String unitId, string ContentType, blob attachmentBody, String fileext, String pathname){
        //String Projectid,string puitid,string unitId
        String token = Druce_PortalAuthentication.getToken();// Monika: Get Token Value
        if(token != '' || token != null)
        {
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://dxsfapi.speridian.com/api/v1/sf/binaryFiles');
            req.setHeader('Authorization', 'Bearer ' + token );
            req.setHeader('Content-Type', ContentType);
            req.setHeader('path', pathname);
            req.setHeader('unitid', unitId);
            req.setHeader('projectid', projId);
            req.setHeader('filename', fname);
            req.setBodyAsBlob(attachmentBody);
            req.setTimeout(100000);
            
            Http http = new Http();
            system.debug('Request: ' + req);
            system.debug('Request Body : ' + req.getBody());
            system.debug('Authorization: ' + req.getHeader('Authorization'));
            system.debug('filename: ' + req.getHeader('filename'));
            system.debug('unitid: ' + req.getHeader('unitid'));
            system.debug('projectid: ' + req.getHeader('projectid'));
            
            HTTPResponse res = http.send(req);
            system.debug('responses1'+ res.getBody());
            if (res.getStatusCode() == 200 || res.getStatusCode()==201) 
            {
                
                Map<String, Object> resbody = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                List<Object> responses = (List<Object>)resbody.get('response');
                system.debug('responses2'+ responses);
                Map<String, Object> mainresponse = (Map<String, Object>)responses[0];
                system.debug(mainresponse);
                String S3imageId = ((object) mainresponse.get('id')).tostring();
                Map<String, Object> datastruct = (Map<String, Object>)mainresponse.get('data');
                object path = (object) datastruct.get('path');
                String url = path.tostring();
                system.debug(url);
                              
            }
            system.debug('Response recieved: ' + res);
        }
    }*/
}