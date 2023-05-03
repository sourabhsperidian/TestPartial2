@isTest
public class DXF_AmazonIntegrationTest {
	
    @testSetup static void setup(){
        Account acc = TestDataFactory.createAccount('Test Account', true);
        
    }
    
    @isTest static void testMethod1(){
        DXF_AmazonIntegration.ContentType('docx');
    }
        

}