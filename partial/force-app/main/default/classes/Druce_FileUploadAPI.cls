public class Druce_FileUploadAPI {
    
    @AuraEnabled
    public static String calloutFromAura(String recId){
        doDeleteCallout(new Set<String>{recId});
        String returnvalue = 'TestString';
        return returnvalue;
    }
    
    @future(callout=true)
    public static void doDeleteCallout(Set<String> RecId){
        
        List<Amazon_Files__c> amzfileList = [SELECT Id,S3_Response_Id__c, Name FROM Amazon_Files__c WHERE (Id IN:RecId AND Status__c = 'Submitted')];
        String token = Druce_PortalAuthentication.getToken();// Monika: Get Token Value
        String S3fileId;
        if(token != '' || token != null)
        {
            for(Amazon_Files__c amzfile : amzfileList){
                S3fileId = amzfile.S3_Response_Id__c;
            }
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('DELETE');
            request.setHeader('Content-Type', 'application/json');
            request.setEndpoint('https://dxsfapi.speridian.com/api/v1/sf/binaryFiles/'+S3fileId);
            system.debug('requestfileupload: ' + request);
            HttpResponse response = http.send(request);
            system.debug('response : ' + response.getBody());
            if (response.getStatusCode() == 200)
            {
                Map<String, Object> Resbody = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                Object status = (Object)Resbody.get('status');
                if (response.getStatusCode() == 200)
                {
                    Delete amzfileList; // Delete from Salesforce
                }
            }
        }
    }
}