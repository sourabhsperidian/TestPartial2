global class AmlPdfCalloutInvocable {
    
    //@InvocableMethod(label='Call AML PDF API' description='Call AML PDF API (/report/v1.0/generateReport) ' category = 'Druce AML')
    public static void doPdfCallout(String amlReportId, Contact ctc){
        //Results result = new Results();
        
        AmlApiClient client = new AmlApiClient();
        HttpResponse response = client.doGetPdfBase64(amlReportId); 
        if (response.getStatusCode() == 200){

            //Insert ContentVersion
            Blob binary = EncodingUtil.base64Decode('Unit Test Attachment Body'); 
            if(!Test.isRunningTest())
            {
            	binary = EncodingUtil.base64Decode(response.getBody());
            }
            ContentVersion cv = new ContentVersion();
            cv.VersionData = binary;
            cv.Title = 'AML -'+System.now().format('YYYY-MM-dd HH:mm')+'.pdf';
            cv.PathOnClient = 'XX.pdf';
            insert cv;
            system.debug(cv.id);
            ContentDocumentLink cdl =new ContentDocumentLink();
            cdl.ContentDocumentId = [Select ContentDocumentId from ContentVersion Where id =:cv.id].ContentDocumentId;
            cdl.LinkedEntityId = ctc.id; //'0019D00000P5YJkQAN';
            cdl.ShareType = 'V';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cdl.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers                        
            if(!Test.isRunningTest())
            {
                insert cdl;
            	update ctc;
            }
            
        }else{
         //   result.isSuccess = false;
           // result.errorMessage = response.getBody();
        }       

       // return new List<Results> { result };
    }
    /*
    global class Results{
        @InvocableVariable
        public boolean isSuccess;
        @InvocableVariable
        public String errorMessage;
        
        @InvocableVariable
        public Blob pdfBlob;
    }
    
    global class Input{
        
        @InvocableVariable
        global string amlReportId;
    }*/

}