@isTest
public class Druce_PrimaryPropertyAPITest {
	
    @testSetup static void setup(){
        Account acc = TestDataFactory.createAccount('Test Account', true);
        Project__c project = TestDataFactory.createProject('Test Project Secondary', false);
        project.Project_Stage__c = 'Construction';
        project.Secondary_Property__c = False;
        insert project;
        
        Project_Unit_Type__c projectUT = TestDataFactory.createProjectUnitType('Independent Flats',project.Id, false);
        insert projectUT;
        
        Unit__c unit = TestDataFactory.createUnit('Test Unit 1',projectUT.Id, false);
        Unit__c unit2 = TestDataFactory.createUnit('Test Unit 2',projectUT.Id, false);
        Unit__c unit3 = TestDataFactory.createUnit('Test Unit 3',projectUT.Id, false);
        List<Unit__c> unitLst = new List<Unit__c>();
        unitLst.add(unit);unitLst.add(unit2);unitLst.add(unit3);
        insert unitLst;
        
    }
    
    @isTest static void testPrimaryProjectSync(){
        List<Id> prjLst = new List<Id>(); 
        for(Project__c prj : [SELECT Id From Project__c]){
            prjLst.add(prj.Id);
        }
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        Druce_PrimaryPropertyAPI.calloutPrimaryProject(prjLst[0]);
        Test.stopTest();
    }
    
}