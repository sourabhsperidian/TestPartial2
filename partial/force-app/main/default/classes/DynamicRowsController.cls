public class DynamicRowsController {
    
	@AuraEnabled
    public static String updateAccts( List < Amazon_Files__c > listAccts ) {
        
        try {
            
            insert listAccts;
            return 'Successful';
            
        } catch ( Exception e ) {
            
            throw new AuraHandledException( e.getMessage() );            
        }
    }
    
}