public class AmazoS3Controller {
	
    @future(callout=true)
    public static void UploadDocument(string recordId)
    {
        //S3 Key 
        String key = 'AKIAYWUJHWUQR5IVVF75'; 
        //S3 Secret Key 
        String secret = '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';
        String bucket = 's3-euw2-dxfuturetech-poc'; 
        String host = 's3.eu-west-2.amazonaws.com';
        String method = 'PUT';
        AWSService service=new AWSService(key,secret,bucket,method,host);
		    service.UploadDocuments(recordId);
    }
}