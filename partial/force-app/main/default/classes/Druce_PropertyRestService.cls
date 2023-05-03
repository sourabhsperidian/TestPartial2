@RestResource(urlMapping='/propertyAPI/')
global class Druce_PropertyRestService {
 
	@HttpPost
    global Static void getLead(){
    	RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
    }
}