public class Druce_Constants {
    
    public static string SALEUNIT = 'Sale';
    public static string RENTUNIT = 'Rent';
    public static string UNIT_UK = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('UK Units').getRecordTypeId();
    public static string Unit_SG = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('SG Units').getRecordTypeId();
    public static string UNIT_REAPIT_DATA = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('Reapit Data').getRecordTypeId();
    public static string RENTAL_UK = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('Rental UK').getRecordTypeId();
    public static string PRIMARY_UK = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('Primary UK').getRecordTypeId();
	public static string SECONDARY_UK = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('Secondary UK').getRecordTypeId();
    
    public static string AccountIndividual = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual Customer').getRecordTypeId();
    public static string IndAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual Account').getRecordTypeId();
    public static string CorpAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Corporate Customer').getRecordTypeId();
    
    public static string Contactrecords = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Business Contact').getRecordTypeId();
     public static string OppourtnityValuation = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Instant Valuation').getRecordTypeId();
    public static string Oppourtnitybuying = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buying UK').getRecordTypeId();
    public static string Oppourtnityselling = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Primary Sell UK').getRecordTypeId();
	public static string OppourtnitySecselling = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Secondary Sell UK').getRecordTypeId();
    public static string OppourtnityLetting = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Rental UK').getRecordTypeId();
    //public static string OppourtnityValuation = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Valuation').getRecordTypeId();
    public static string Oppourtnitytenancy = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Tenancy UK').getRecordTypeId();
    
    public static string Reapitletting = Schema.SObjectType.Letting__c.getRecordTypeInfosByName().get('REAPIT DATA').getRecordTypeId();
	public static string Reapitselling = Schema.SObjectType.Selling__c.getRecordTypeInfosByName().get('REAPIT DATA').getRecordTypeId();
}