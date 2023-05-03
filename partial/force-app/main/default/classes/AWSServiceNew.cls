public class AWSServiceNew {
	public static void submitDocument()
    {
        //AWSInfo__mdt meta=MetadataHelper.getAWSInfo();
        AWSSignature aws=new AWSSignature();
        //aws.setAWS('eu-west-2','ec2','AddAYLS6VP5R5UI7D356I','ADE#9IcbnSSxcC5bsextZ1qqtkgS7elFz2IwZDA2KT');
        aws.setAWS('eu-west-2','s3','AKIAYWUJHWUQR5IVVF75','W2wlQUKomFgcq0uTMIsn4c4IlsJNT72hlZtsJncZ');
        //aws.setUrl('patient.sysinfo.com','api/patient');
        aws.setUrl('s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com','');
        aws.setMethod('POST');
        
        HttpRequest req = aws.createSigntaureRequest();
        req.setHeader('Content-Type','multipart/form-data');
        Http http = new Http();
        Attachment attach = [select Body,ContentType,Name from Attachment where id = '00P0T000001xDJB' limit 1];
        Blob attachmentBody = attach.Body;
        req.setBodyAsBlob(attachmentBody);
        HTTPResponse res = http.send(req);
        
        system.debug('res:'+res.getBody());
        if (res.getStatusCode() == 200 || res.getStatusCode()==201) 
        {
            //Code to handle Response 
        }
    }
        
}