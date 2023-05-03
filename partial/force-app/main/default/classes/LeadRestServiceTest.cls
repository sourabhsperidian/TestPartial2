@isTest
public class LeadRestServiceTest {
	
    @testSetup static void setup(){
        Lead lead = TestDataFactory.createLead('Test Lead','Last Name','New','test@test.com', false);       
        insert lead;
    }
    
    @isTest static void testLeadCreate(){
        Test.startTest();
        List<DXF_LeadRequestWrapper> lstrestRequest = new List<DXF_LeadRequestWrapper>();
            
        DXF_LeadRequestWrapper requestFake = new DXF_LeadRequestWrapper();
        requestFake.firstName = 'Test Lead';
        requestFake.lastName = 'Dilawar';
        requestFake.email = 'test@dilartest.com';
        requestFake.leadStatus = 'New';
        requestFake.emailOptOut = false;
        requestFake.donotCall = false;
        requestFake.fly_In_Program = true;
        lstrestRequest.add(requestFake);                   
        
        String JsonMsg=JSON.serialize(lstrestRequest);
        system.debug('JsonMsg : ' + JsonMsg);    
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/leads';
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(JsonMsg);
        RestContext.request = req;
        RestContext.response= res;
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        LeadRestService.createLead();                
        Test.stopTest();
    }
    
    @isTest static void testCreateViewInterest(){
        Test.startTest();
        List<DXF_LeadRequestWrapper> lstrestRequest = new List<DXF_LeadRequestWrapper>();
        for(Lead ld : [SELECT Id,FirstName,LastName,Email,Phone,Status,LeadSource,Fly_In_Program__c From Lead]){
            
            DXF_LeadRequestWrapper requestFake = new DXF_LeadRequestWrapper();
            requestFake.firstName = ld.FirstName;
            requestFake.lastName = ld.LastName;
            requestFake.email = ld.Email;
            requestFake.leadStatus = ld.Status;
            requestFake.emailOptOut = false;
            requestFake.donotCall = false;
            requestFake.fly_In_Program = ld.Fly_in_Program__c;
            lstrestRequest.add(requestFake);                   
        }
        
        String JsonMsg=JSON.serialize(lstrestRequest);
        system.debug('JsonMsg : ' + JsonMsg);    
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/leads';
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(JsonMsg);
        RestContext.request = req;
        RestContext.response= res;
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        LeadRestService.createLead();                
        Test.stopTest();
    }
    
    @isTest static void testleadUpdate(){
        Test.startTest();
        List<DXF_LeadRequestWrapper> lstrestRequest = new List<DXF_LeadRequestWrapper>();
        Lead ld = [SELECT Id FROM Lead LIMIT 1];
        DXF_LeadRequestWrapper requestFake = new DXF_LeadRequestWrapper();
        requestFake.Lead_SF_Id = ld.Id;
        requestFake.firstName = 'Test Lead';
        requestFake.lastName = 'Dilawar';
        requestFake.email = 'test@dilartest.com';
        requestFake.leadStatus = 'New';
        requestFake.emailOptOut = false;
        requestFake.donotCall = false;
        requestFake.fly_In_Program = true;
        lstrestRequest.add(requestFake);                   
        
        String JsonMsg=JSON.serialize(lstrestRequest);
        system.debug('JsonMsg : ' + JsonMsg);    
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/leads';
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(JsonMsg);
        RestContext.request = req;
        RestContext.response= res;
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        LeadRestService.updateLead();                
        Test.stopTest();
    }
    
    @isTest static void testLeadCreateException(){
        Test.startTest();
        List<DXF_LeadRequestWrapper> lstrestRequest = new List<DXF_LeadRequestWrapper>();
            
        DXF_LeadRequestWrapper requestFake = new DXF_LeadRequestWrapper();
        requestFake.firstName = 'Test Lead';
        requestFake.lastName = 'Dilawar';
        requestFake.leadStatus = 'New';
        requestFake.emailOptOut = false;
        requestFake.donotCall = false;
        requestFake.fly_In_Program = true;
        lstrestRequest.add(requestFake);                   
        
        String JsonMsg=JSON.serialize(lstrestRequest);
        system.debug('JsonMsg : ' + JsonMsg);    
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/leads';
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(JsonMsg);
        RestContext.request = req;
        RestContext.response= res;
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('Auth'));
        LeadRestService.createLead();                
        Test.stopTest();
    }
    
    @isTest static void testGetLeadSync(){
        Test.startTest();
        
        for(Lead ld : [SELECT Id,FirstName,LastName,Email,Phone,Status,LeadSource,Fly_In_Program__c From Lead]){
            
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/leads/'+ld.Id;
        req.httpMethod = 'GET';//HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        LeadRestService.getLead();                
        Test.stopTest();
        }
    }
    
    
}