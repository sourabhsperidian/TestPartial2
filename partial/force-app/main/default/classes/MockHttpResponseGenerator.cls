@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    static String Mock_Auth_Response = '{"status": 200, "message": "login successful", "response": { "token": { "accessToken": "test","idToken": "test", "refreshToken": "test"},"email": "anjisfdc@yopmail.com", "exp": 1676971820, "uid": "9c78476e-0ba2-40c2-b9b8-496fd766f09a", "auth_time": 1676968220, "token_use": "id" }}';
    public String reqName;    
    public MockHttpResponseGenerator(String reqName){
        this.reqName = reqName;
    }
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
       
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        system.debug('End Point URL : '+req.getEndpoint());
        string endpoint = req.getEndpoint();
        if(endpoint.containsIgnoreCase('/auth/signin')){
            res.setBody(Mock_Auth_Response);
        }
        else if(endpoint.containsIgnoreCase('sf/projects')){
        	res.setBody('{"status":200,"message":"success","response":[{"message":"Created","projectId":"4d408eef-25dd-4bdf-b7ef-d5f1f6e55546","sfProjectId":"a060T000002R0YmQAK","projectUnitType":[{"message":"Created","projectUnitId":"0a602815-1e74-4947-b591-1bd4c4d6effe","sfProjectUnitId":"a070T000002bdmEQAQ","unit":[{"message":"Created","unitId":"9f2974de-8bff-4279-941c-a9b92dbe46b6","sfUnitId":"a080T0000039zDTQAY"},{"message":"Created","unitId":"98827a4e-5697-4bce-bb62-3e6dd04c2b37","sfUnitId":"a080T0000039zDiQAI"}]},{"message":"Created","projectUnitId":"9ca27d01-5620-44ed-8a44-d776a11483c2","sfProjectUnitId":"a070T000002bdm9QAA","unit":[{"message":"Created","unitId":"270a64c1-1978-4db4-8cdc-5b1ca7f688ed","sfUnitId":"a080T0000039zDOQAY"},{"message":"Created","unitId":"17b1d5dc-c2eb-421d-a4ab-b466e285c9ae","sfUnitId":"a080T0000039zDdQAI"}]},{"message":"Created","projectUnitId":"3fcf71a5-fc38-46c0-95fc-4db366229bba","sfProjectUnitId":"a070T000002bdlpQAA","unit":[{"message":"Created","unitId":"dd35a71f-0845-435b-b846-c755e40f9698","sfUnitId":"a080T0000039zDJQAY"},{"message":"Created","unitId":"d65f3853-7ad9-4a32-a4df-dca066303e3b","sfUnitId":"a080T0000039zDYQAY"}]}]}]}');
            //res.setBody('{"_embedded" :[{"id":"XO18393"}],"pageNumber":1, "pageSize":100, "pageCount":100, "totalpageCount" : 10, "totalCount" : 100}');    
        }else if (endpoint.containsIgnoreCase('sf/binaryFiles')){
            String resbody  = '{"status":200,"message":"Success","response":[{"id":"a5d2e1ff-eda5-4aca-bd84-332afae3995c","deleted":false,"projectId":null,"unitId":null,"data":{"key":"a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg.jpeg","name":"TestFile67.jpg.jpeg","path":"https://s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com/a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg.jpeg","format":{"large":{"key":"a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_large.jpeg","name":"TestFile67.jpg_large.jpeg","path":"https://s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com/a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_large.jpeg","size":87523,"width":1000,"format":"jpeg","height":666,"channels":3,"premultiplied":false},"small":{"key":"a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_small.jpeg","name":"TestFile67.jpg_small.jpeg","path":"https://s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com/a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_small.jpeg","size":32593,"width":500,"format":"jpeg","height":333,"channels":3,"premultiplied":false},"medium":{"key":"a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_medium.jpeg","name":"TestFile67.jpg_medium.jpeg","path":"https://s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com/a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_medium.jpeg","size":58462,"width":750,"format":"jpeg","height":499,"channels":3,"premultiplied":false},"thumbnail":{"key":"a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_thumbnail.jpeg","name":"TestFile67.jpg_thumbnail.jpeg","path":"https://s3-euw2-dxfuturetech-poc.s3.eu-west-2.amazonaws.com/a060T000002QrNaQAK/a070T0000027MBIQA2/a080T000002j2OtQAI/TestFile67.jpg_thumbnail.jpeg","size":9652,"width":236,"format":"jpeg","height":156,"channels":3,"premultiplied":false}}},"createdAt":"2023-02-23T05:14:29.769Z","updatedAt":"2023-02-23T05:14:29.769Z"}]}';
            res.setBody(resbody);
        }
        else if(endpoint.contains('api/opportunity')){
            
        }
        res.setStatusCode(200);
        return res;
    }
}