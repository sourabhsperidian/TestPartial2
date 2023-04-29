@isTest 
private class AmlClientTest {
    
    static String Mock_PEP_Response = '[{ "amlReportId": "3", "monitorEnabled": true, "name": "Lee Hsien Loong", "country": "Singapore", "gender": "Male", "dateOfBirth": "1952-02-10", "searchEntity": false, "searchIndividual": true, "fuzzyValue": false, "orderType": "ACURIS", "legacy": false, "fatfCountries": [], "sipPersons": [], "pepPersons": [{"uniqueID":"I385180","title":""}], "sieEntities": [] }]';    
    static String Mock_SIP_Response = '[{ "amlReportId": "4", "monitorEnabled": true, "name": "Lee Hsien Loong", "country": "Singapore", "gender": "Male", "dateOfBirth": "1952-02-10", "searchEntity": false, "searchIndividual": true, "fuzzyValue": false, "orderType": "ACURIS", "legacy": false, "fatfCountries": [], "sipPersons": [{"uniqueID":"I385180","title":""}], "pepPersons": [], "sieEntities": [] }]';    
    static String Mock_PEP_SIP_Response = '[{ "amlReportId": "5", "monitorEnabled": true, "name": "Lee Hsien Loong", "country": "Singapore", "gender": "Male", "dateOfBirth": "1952-02-10", "searchEntity": false, "searchIndividual": true, "fuzzyValue": false, "orderType": "ACURIS", "legacy": false, "fatfCountries": [], "sipPersons": [{"uniqueID":"I385180","title":""}], "pepPersons": [{"uniqueID":"I385180","title":""}], "sieEntities": [] }]';    

    
    @isTest static void testDoSearchResultResponse(){
        Test.setMock(HttpCalloutMock.class, new AmlClientMockImpl(true,true));
        //AmlApiClient client = new AmlApiClient();
        //client.doSearchResultResponse(new AmlCalloutInvocable.Input());
        List<AmlCalloutInvocable.Results> results;
        results = AmlCalloutInvocable.doSearchCallout(new List<AmlCalloutInvocable.Input>{new AmlCalloutInvocable.Input()});
        System.assert(results[0].isPEP, 'PEP Should be true');
        System.assert(results[0].isSIP, 'SIP Should be true');
        System.assertEquals('5', results[0].amlReportId, 'Incorrect amlReportId');
        Test.setMock(HttpCalloutMock.class, new AmlClientMockImpl(true,false));
        //results = AmlCalloutInvocable.doSearchCallout(new List<AmlCalloutInvocable.Input>{new AmlCalloutInvocable.Input()});
        //System.assert(results[0].isPEP, 'PEP Should be true');
        //System.assert(!results[0].isSIP, 'SIP Should be false');
        //Test.setMock(HttpCalloutMock.class, new AmlClientMockImpl(false,true));
        //results = AmlCalloutInvocable.doSearchCallout(new List<AmlCalloutInvocable.Input>{new AmlCalloutInvocable.Input()});
        //System.assert(!results[0].isPEP, 'PEP Should be false');
        //System.assert(results[0].isSIP, 'SIP Should be true');
    
        AmlCalloutInvocable.Input i = new AmlCalloutInvocable.input();
        i.country = 'A';
        i.dateOfBirth = date.today();
        i.gender = 'male';
        i.name = 'name';
        i.recordId = null;
        
        list<AmlCalloutInvocable.Input> ListII = new list<AmlCalloutInvocable.input>();
       	listII.add(i);
    	AmlCalloutInvocable.doAMLCallout(listII);
    }
    

    public class AmlClientMockImpl implements HttpCalloutMock {
        boolean isPEP = true;
        boolean isSIP = true;
        
        public AmlClientMockImpl(boolean isPEP, boolean isSIP){
            this.isPEP = isPEP;
            this.isSIP = isSIP;
        }
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            if (isPEP && isSIP)
                res.setBody(Mock_PEP_SIP_Response);
            else if (isPEP)
                res.setBody(Mock_PEP_Response);
            else if (isSIP)
                res.setBody(Mock_SIP_Response);
           
            return res;    
        }
    }

}