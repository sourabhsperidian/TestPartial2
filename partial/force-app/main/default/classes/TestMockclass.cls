@isTest
global class TestMockclass implements HttpCalloutMock {
 String Mock_Auth_Response = '{"status": 200, "message": "login successful", "response": { "token": { "accessToken": "test","idToken": "test", "refreshToken": "test"},"email": "anjisfdc@yopmail.com", "exp": 1676971820, "uid": "9c78476e-0ba2-40c2-b9b8-496fd766f09a", "auth_time": 1676968220, "token_use": "id" }}';

    
    global HttpResponse respond(HttpRequest req)
    {
        String endpoint = req.getEndpoint();
        String body = '{"status":200,"message":"success","response":[{"message":"Created","projectId":"4d408eef-25dd-4bdf-b7ef-d1f6e55546","sfProjectId":"a060T000002R0YmQAK","projectUnitType":[{"message":"Created","projectUnitId":"0a602815-1e74-4947-b591-1bd4c4d6effe","sfProjectUnitId":"a070T000002bdmEQAQ","unit":[{"message":"Created","unitId":"9f2974de-8bff-4279-941c-a9b92dbe46b6","sfUnitId":"a080T0000039zDTQAY"},{"message":"Created","unitId":"98827a4e-5697-4bce-bb62-3e6dd04c2b37","sfUnitId":"a080T0000039zDiQAI"}]},{"message":"Created","projectUnitId":"9ca27d01-5620-44ed-8a44-d776a11483c2","sfProjectUnitId":"a070T000002bdm9QAA","unit":[{"message":"Created","unitId":"270a64c1-1978-4db4-8cdc-5b1ca7f688ed","sfUnitId":"a080T0000039zDOQAY"},{"message":"Created","unitId":"17b1d5dc-c2eb-421d-a4ab-b466e285c9ae","sfUnitId":"a080T0000039zDdQAI"}]},{"message":"Created","projectUnitId":"3fcf71a5-fc38-46c0-95fc-4db366229bba","sfProjectUnitId":"a070T000002bdlpQAA","unit":[{"message":"Created","unitId":"dd35a71f-0845-435b-b846-c755e40f9698","sfUnitId":"a080T0000039zDJQAY"},{"message":"Created","unitId":"d65f3853-7ad9-4a32-a4df-dca066303e3b","sfUnitId":"a080T0000039zDYQAY"}]}]}]}';
        String status = 'Success';
        Integer statusCode = 200;
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        //res.setBody(body);
        res.setStatusCode(statusCode);
        res.setStatus(status);
        if(endpoint.containsIgnoreCase('/auth/signin')){
           res.setBody(Mock_Auth_Response); 
        }
        if(endpoint.containsIgnoreCase('sf/projects')){
            res.setBody(body); 
        }
        return res;
    }
}