@isTest
public class TestTestclasses {

    @testSetup public static void TestData()
    {
         Project__c project = new Project__c();
        project.Project_Stage__c = 'Construction';
        project.name = 'New Project';
        project.Secondary_Property__c = TRUE;
        insert project;
        Project_Unit_Type__c projectUT = TestDataFactory.createProjectUnitType('Independent Flats',project.Id, false);
        insert projectUT;
        
        Unit__c unit = TestDataFactory.createUnit('Duplex House',projectUT.Id, false);
        insert unit;
    }
    
    @isTest static void doPostCallouttest(){
        List<Id> UnitIds = new List<Id>();
        for(Unit__c unitId: [Select Id from Unit__c]){
            UnitIds.add(unitId.id);
        }
        Test.startTest();  
       Test.setMock(HttpCalloutMock.class, new TestMockclass());
        Druce_SecondaryPropertyAPI.calloutFromAura(UnitIds[0]);
        Test.stopTest();
    }
}