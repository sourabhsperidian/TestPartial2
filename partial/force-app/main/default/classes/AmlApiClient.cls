public class AmlApiClient {
    static final String NAMED_CRED = 'callout:IngeniqueAPI_NC';
    static final String PATH_SEARCH = '/screening/v1.0/search';    
    static final String PATH_PDF = '/report/v1.0/generateReport';
    static final String API_ACCOUNT_ID = '202207184K'; // to be refactored, current API (winter 23) does not seem to support Merge field reference from Named/External Credentials' Custom Header
    
    public HttpResponse doSearchResultResponse(AmlCalloutInvocable.Input input){
        HttpRequest req = new HttpRequest();
        setHttpHeaders(req, PATH_SEARCH);
        req.setBody( constructSearchPayload(input) );        
        return new Http().send(req);
    }

    public HttpResponse doGetPdfBase64(String amlReportId){
        HttpRequest req = new HttpRequest();
        setHttpHeaders(req, PATH_PDF);
        req.setBody( JSON.serialize(new Map<String, String>{'amlReportId'=>amlReportId, 'accountId'=>API_ACCOUNT_ID}) );        
        return new Http().send(req);
    }
    
    private void setHttpHeaders(HttpRequest req, String path){
        req.setEndpoint(NAMED_CRED + path);        
        req.setHeader('Content-Type', 'application/json');        
        req.setMethod('POST');
    }
    
    public String constructSearchPayload(AmlCalloutInvocable.Input input){        
        List<SearchQuery> queries = new List <SearchQuery>();        
        SearchQuery query = new SearchQuery();
        query.country = input.country; //'Singapore';        
        query.name = input.name; //'Name';        
        query.gender = input.gender; //'Male';
        query.dob = input.dateOfBirth; //Date.today();         
        query.fuzzy = false;
        query.searchIndividual = true;
        
        queries.add(query);
        return JSON.serialize(new Map<String, Object>{ 'queries' => queries });
    }
    
    class SearchQuery{
        public String country;
        public boolean fuzzy;
        public String name;
        public boolean searchIndividual = false;
        public boolean searchEntity {
            get{
                return !searchIndividual;
            }
        }
        public String gender;
        public transient Date dob;
        public String dateOfBirth {
            get{
                return (dob == null) ? null : DateTime.newInstance(dob.year(),dob.month(),dob.day()).format('YYYY-MM-dd');
            }
        }
    }
}