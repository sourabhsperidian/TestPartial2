public class DXF_AmazonIntegration {
    
    /*
     *    Method :  putFileInS3FromObject
     *    Description : Send Salesforce files to amazon S3 bucket.
     */
    @future(Callout=true)
    public static void getFromAmazon() {
        HttpRequest request = new HttpRequest();
        string path = '2.jpg';
        request.setEndpoint('callout:Connect_to_s3/'+path);
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');        
        Http http = new Http();
        HTTPResponse response = http.send(request);
        System.debug(response.getBody());
        System.debug(response.getStatus());
    }
    /*
     *    Method :  putFileInS3FromObject
     *    Description : Send Salesforce files to amazon S3 bucket.
     */
    @future(Callout=true)
    public static void putFileInS3FromObject(Id oid, Map<String, String> mapProjName, Map<String, String> mapPrjwithContent) {
        /*List<ContentDocumentLink> links=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:oid];
        Set<Id> ids=new Set<Id>();
        for(ContentDocumentLink link:links)
        {
            ids.add(link.ContentDocumentId);
        }*/
        List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension,FileType FROM ContentVersion WHERE ContentDocumentId = :oid AND IsLatest = true];
        if (versions.size() > 0) {
            String attachmentBody = EncodingUtil.base64Encode(versions[0].VersionData);            
            String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
            String filename = versions[0].Title+'.'+versions[0].FileType;
            //Update the content-type based on the file type being attached
            string contentType = contentType(versions[0].FileType);      
            system.debug('Content Doc Id : '+versions[0].ContentDocumentId);
            system.debug('mapPrjwithContent : '+mapPrjwithContent);
            String parentId = mapPrjwithContent.get(versions[0].ContentDocumentId);
            system.debug('Parent Id : '+parentId);
            filename = filename.replaceAll(' ', '_');
            String url = 'callout:Connect_to_s3'+ '/'+ mapProjName.get(parentId)+'/' +filename;
            HttpRequest req  = new HttpRequest();
            HttpResponse res  = new HttpResponse();
            req.setMethod('PUT');
           // String pathUrl = 'https://s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com/TEST12345';
            
            req.setEndpoint(url);
            req.setHeader('Content-type', contentType);
            req.setHeader('Content-Encoding', 'UTF-8');
            /*req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
            
            
            req.setHeader('Connection', 'keep-alive');
            req.setHeader('Date', formattedDateString);
            req.setHeader('ACL', 'public-read');*/
            Blob pdfBlob = EncodingUtil.base64Decode(attachmentBody);
            req.setBodyAsBlob(pdfBlob);
            system.debug('Req Body : '+req.getBody());
            system.debug('Req Body : '+req.getBodyDocument());
            system.debug('Req Body : '+req.getBodyAsBlob());
            Http http = new Http();
            res = http.send(req);
            system.debug(res.getStatusCode());
            system.debug(res.getBody());
            if(res.getStatusCode() == 200){
                Amazon_Files__c file = new Amazon_Files__c();                
                file.Path_Url__c = url;
               // update file;
            }
        }
    }
    
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
            when else {
                return 'image/jpeg';
            }
        }
    }
    
    @future(Callout=true)
    public static void pushFile(){
    	 Xmlstreamwriter xmlW = new Xmlstreamwriter();
         xmlW.writeStartDocument('utf-8','1.0');
         xmlW.writeStartElement(null,'SERVICE', null);
         xmlW.writeAttribute(null,null,'version','1.0');
         xmlW.writeStartElement(null,'CLIENT',null);
         xmlW.writeAttribute(null,null,'email','xx.xx@xx.xx');
         xmlW.writeStartElement(null,'BASIC_FIELDS',null);
         xmlW.writeAttribute(null,null,'id','1');
         xmlW.writeStartElement(null,'ADRESS_LINE_1',null);
         xmlW.writeAttribute(null,null,'id','2');
         xmlW.writeCharacters('4 rue de rocher');
         xmlW.writeEndElement();
        
         xmlW.writeStartElement(null,'CITY',null);
         xmlW.writeAttribute(null,null,'id','3');
         xmlW.writeCharacters('Paris');
         xmlW.writeEndElement();
        
         xmlW.writeEndElement();
         xmlW.writeEndElement();
         xmlW.writeEndElement();
         xmlW.writeEndDocument();
        
         String xmlStringxmlRes = xmlW.getXmlString();
         xmlW.close();
         Blob xmlContentBlob = Blob.valueOf(xmlStringxmlRes);
        
         String attachmentBody = EncodingUtil.base64Encode(xmlContentBlob);
         String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
         String key = 'AKIAYWUJHWUQR5IVVF75'; 
         String secret = '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'; 
         String bucketname = 's3-euw2-dxfuturetech-poc';
         String host = 's3.eu-west-2.amazonaws.com';
         String method = 'PUT';
         String filename = 'Upload-Test-3.xml';
         String fileType = 'text/xml';
        
         HttpRequest req = new HttpRequest();
         req.setMethod(method);
         req.setEndpoint('callout:Connect_to_s3' + '/' + filename);
        /* req.setHeader('Host', bucketname + '.' + host);
         req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
        req.setHeader('Content-type', fileType);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Date', formattedDateString);
        req.setHeader('ACL', 'public-read');
        */
        req.setBodyAsBlob(xmlContentBlob);
        Http http = new Http();
        HttpResponse res  = new HttpResponse();
        res = http.send(req);
        system.debug(res.getStatusCode());
        system.debug(res.getBody());
    }
    
    @future(Callout=true)
    public static void deleteFromAmazon() {
        
       
        
        HttpRequest request = new HttpRequest();
        string path = '';
        request.setEndpoint('callout:Connect_to_s3/'+path);
        request.setMethod('DELETE');
        request.setHeader('Content-Type','application/json');        
        Http http = new Http();
        HTTPResponse response = http.send(request);
        System.debug(response.getBody());
        System.debug(response.getStatus());
    }
}