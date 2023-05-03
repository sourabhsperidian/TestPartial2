public class OpportunityAccountMapping {

    public static String SearchAccount(String RecId, String type){
    
        Ownership__c ownerAccount = [Select Id, Account_Id__c from Ownership__c where Vendor_Reapit_Id__c =: RecId];
        return ownerAccount.Account_Id__c;
        
    }
}