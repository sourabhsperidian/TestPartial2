@RestResource(urlMapping='/reapitFiles/*')
global class Druce_ReapitFilesSync {
	@HttpPost
    global Static void createProperty(){
                
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        system.debug('jsonString : '+jsonString);
        String responseString;
        try{
            ReapitDataWrapper requestWrapper = (ReapitDataWrapper)JSON.deserialize(jsonString, ReapitDataWrapper.class);
            /*
            Druce_ReapitResponse.response response = new Druce_ReapitResponse.response();
            Druce_ReapitResponse resWrapper = new Druce_ReapitResponse();
            List<Druce_ReapitResponse.results> resultList = new List<Druce_ReapitResponse.results>();
            Druce_ReapitResponse.results result = new Druce_ReapitResponse.results();
            result.message = 'Unit successfully published into salesforce';
            resultList.add(result);
            response.results = resultList;
            response.Status = 'Success';
            response.status_code = '200';
              
        	resWrapper.response = response;
            responseString  = JSON.serialize(resWrapper);
            res.addHeader('Content-Type', 'application/json'); 
            
            res.responseBody = Blob.valueOf(responseString);*/
            
            API_Log__c apiLog = new API_Log__c();
            apiLog.Method__c = 'POST';
            apiLog.Object_Name__c = 'Unit__c';        
            apiLog.Request_Body__c = jsonString;
            apiLog.Response_Body__c = responseString;
            
            insert apiLog;
    	}
        catch(Exception ex){
            API_Log__c apiLog = new API_Log__c();
            apiLog.Method__c = 'POST';
            apiLog.Object_Name__c = 'Unit__c';        
            apiLog.Request_Body__c = jsonString;
            apiLog.Response_Body__c = responseString;
            
            insert apiLog;
        }
        
    }
    
}