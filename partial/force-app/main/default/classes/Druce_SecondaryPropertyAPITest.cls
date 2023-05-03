@isTest
public class Druce_SecondaryPropertyAPITest {

    @testSetup static void setup(){
        Account acc = TestDataFactory.createAccount('Test Account', true);
        
        Project__c project = TestDataFactory.createProject('Test Project Secondary', false);
        project.Project_Stage__c = 'Construction';
        project.Secondary_Property__c = TRUE;
        insert project;
        
        Project_Unit_Type__c projectUT = TestDataFactory.createProjectUnitType('Independent Flats',project.Id, false);
        insert projectUT;
        
        Unit__c unit = TestDataFactory.createUnit('Duplex House',projectUT.Id, false);
        insert unit;
    }
    
    @isTest static void testSecondarySync(){
        List<Id> unitIds = new List<Id>(); 
        for(Unit__c unit : [SELECT Id From Unit__c]){
            unitIds.add(unit.Id);
        }
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        Druce_SecondaryPropertyAPI.calloutFromAura(unitIds[0]);
        Test.stopTest();
    }
}