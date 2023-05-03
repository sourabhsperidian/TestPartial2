@isTest
public class Druce_opportunityAPITest {
	@testSetup static void setup(){
        
        Account acc = TestDataFactory.createAccount('Test Account', false);        
        insert acc;
        
        Opportunity opp = TestDataFactory.createOpportunity('Test Opportunity',acc.Id,System.Today(), 'Indicated Interest', false);        
        insert opp;
        
        Project__c project = TestDataFactory.createProject('Test Project Secondary', false);
        project.Project_Stage__c = 'Construction';
        project.Secondary_Property__c = TRUE;
        insert project;
        
        Project_Unit_Type__c projectUT = TestDataFactory.createProjectUnitType('Independent Flats',project.Id, false);
        insert projectUT;
        
        Unit__c unit = TestDataFactory.createUnit('Duplex House',projectUT.Id, false);
        unit.Unit_Availability__c = 'Available';
        insert unit;
        
        Unit_Preference__c unitPreference = TestDataFactory.createUnitPreference(unit.Id,opp.Id, false);
        insert unitPreference;
        
        Offer__c offer = new Offer__c();
        offer.Unit__c = unit.Id;
        offer.Opportunity__c = opp.Id;
        offer.Project_Name__c = project.Id;
        insert offer;
        
        Transaction__c trans = new Transaction__c();
        trans.Opportunity__c = opp.Id;
        insert trans;
        
        
    }
    
    @isTest static void testgetOpportunity(){
        Set<String> setOpids = new Set<String>();
        for(Opportunity Opp  : [SELECT Id, Name, Type,RecordType.name FROM Opportunity]){
            setOpids.add(opp.Id);
        }
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        Druce_OpportunityAPI.doGetCallout();
        Druce_OpportunityAPI.doPostCallout(setOpids);
        Test.stopTest();
    }
}