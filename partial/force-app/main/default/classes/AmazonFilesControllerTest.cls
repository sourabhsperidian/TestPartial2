@isTest
public class AmazonFilesControllerTest {
	@testSetup static void setup(){
        //Test Class
        Project__c project = TestDataFactory.createProject('Test Project Secondary', false);
        project.Project_Stage__c = 'Construction';
        project.Secondary_Property__c = TRUE;
        insert project;
        
        Project_Unit_Type__c projectUT = TestDataFactory.createProjectUnitType('Independent Flats',project.Id, false);
        insert projectUT;
        
        Unit__c unit = TestDataFactory.createUnit('Duplex House',projectUT.Id, false);
        insert unit;
        
        Amazon_files__c amzonFile = new Amazon_files__c(Name= 'Test File', Status__c = 'New',Description__c='Test',File_Type__c= 'jpeg', Unit__c = unit.Id );       
        insert amzonFile;
        
        ContentVersion content = new ContentVersion(); 
        content.Title='Main Entrance'; 
        content.PathOnClient='/' + content.Title + '.jpg'; 
        Blob bodyBlob = Blob.valueOf('Unit Test ContentVersion Body'); 
        content.VersionData = bodyBlob; 
       // content.LinkedEntityId = amzonFile.id;
        content.origin = 'H';
        insert content;
        
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId = amzonFile.id;
        contentlink.contentdocumentid=[select contentdocumentid from contentversion where id =: content.id].contentdocumentid;
        contentlink.ShareType = 'I';
        contentlink.Visibility = 'AllUsers';
        insert contentlink;
    }
    
    @isTest static void testgetProject(){
        List<Unit__c> unitlst = [SELECT Id FROM Unit__c];
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        AmazonFilesController.getProjectId(unitlst[0].Id);
        AmazonFilesController.getAmazoneFiles(unitlst[0].Id,'Unit__c');
        AmazonFilesController.createemptyfile(unitlst[0].Id,'Unit__c','Test File Name','Test Description',false,false,false);
        
        List<Amazon_files__c> lstFiles = [SELECT Id FROM Amazon_files__c];
        AmazonFilesController.deletefile(lstFiles[0]);
        Test.stopTest();
        
    }
}