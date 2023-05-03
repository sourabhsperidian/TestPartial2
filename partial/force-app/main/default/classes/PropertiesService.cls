@RestResource(urlMapping='/properties/*')
global class PropertiesService {
	
    @HttpPost
    global Static void createProperty(){
                
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        
        jsonString = jsonString.replaceAll('new','embedded');
        String responseString;
        try{
            ReapitDataWrapper wrapper = (ReapitDataWrapper)JSON.deserialize(jsonString, ReapitDataWrapper.class);            
            List<Unit__c> lstUnit = new List<Unit__c>();
            Opportunity oppLetting = new Opportunity();
            Opportunity oppSelling = new Opportunity();
            Map<String, Opportunity> mapletopp = new Map<String, Opportunity>();
            Map<String, Opportunity> mapsellopp = new Map<String, Opportunity>();
            List<Map<String, Room__c>> maproomLists = new List<Map<String, Room__c>>();
        	System.debug('Visit Id :'+wrapper.eventId);
        	
            if(wrapper.topicId == 'properties.modified' || wrapper.topicId == 'properties.created'){
                Druce_ReapitPropertyHandler.propertySync(jsonString);
            }
            else if(wrapper.topicId == 'propertyimages.created' || wrapper.topicId == 'propertyimages.modified'){
                Druce_ReapitImagesHandler.propertyImageSync(jsonString);
            }
           else if(wrapper.topicId == 'contacts.modified' || wrapper.topicId == 'contacts.created'){
                Druce_ReapitContactHandler.contactSync(jsonString);
            }
            else if(wrapper.topicId == 'vendors.modified' || wrapper.topicId == 'vendors.created'){
                Druce_ReapitVendorHandler.vendorSync(jsonString);
            }
    	}
        catch(Exception ex){
            /*system.debug('Exception : '+ex.getMessage());
            API_Log__c apiLog = new API_Log__c();
            apiLog.Method__c = 'POST';
            apiLog.Object_Name__c = 'Unit__c';        
            apiLog.Request_Body__c = jsonString;
            apiLog.Response_Body__c = responseString;
            insert apiLog; */
        }
    }
}