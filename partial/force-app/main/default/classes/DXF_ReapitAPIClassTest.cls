@isTest
public class DXF_ReapitAPIClassTest {
    static HttpResponse res;
	
    @testSetup static void setup(){
        Account acc = TestDataFactory.createAccount('Test Account', false);
        acc.BillingCity = 'TEST';
        insert acc;
        
        // 1 DML
    }
    
    @isTest static void testMethod1(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('reqName'));
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        
        Test.startTest();
        
        DXF_ReapitAPIClass cls = new DXF_ReapitAPIClass(1);
        system.enqueueJob(cls);
        
        
        
        Test.stopTest();
    }
    
    
    @isTest static void testMethod2(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
      User u2 = new User(Alias = 'newUser', Email='newuser@testorg.com',
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
         LocaleSidKey='en_US', ProfileId = p.Id,
         TimeZoneSidKey='America/Los_Angeles', UserName='newuser@testorg.com');

      System.runAs(u2) {
         // The following code runs as user u2.
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId());

         // The following code runs as user u3.
         User u3 = [SELECT Id FROM User WHERE UserName='newuser@testorg.com'];
         System.runAs(u3) {
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId());
         }

         // Any additional code here would run as user u2.
      }
    }
    
}