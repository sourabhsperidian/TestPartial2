public class S3FileController {
    @AuraEnabled
    public static string getFileUrl(string record)
    {
        try
        {
            List<File_Store__c> files=[SELECT  S3ServerUrl__c,FileExtension__c FROM File_Store__c 
                                      where Id=:record];
            File_Store__c file=files[0];
            return file.S3ServerUrl__c;
        }
        catch(Exception ex)
        {
            system.debug('ex:'+ex.getMessage());
            return '';
        }
    }
}