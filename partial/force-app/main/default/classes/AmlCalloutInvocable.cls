global class AmlCalloutInvocable {
    
    @InvocableMethod(label='Call AML Search and PDF API' description='Call AML Search API (/screening/v1.0/search)' category = 'Druce AML')
    public static void doAMLCallout(List<Input> inputParams){
        doSearchCallout(inputParams[0].recordId,inputParams[0].name, inputParams[0].gender, inputParams[0].country, inputParams[0].dateOfBirth );
    }

    @future(callout=true)
    public static void doSearchCallout(String recordId, String name, String gender, String country, Date dateOfBirth){
        AmlCalloutInvocable.Input i =  new AmlCalloutInvocable.Input();
        i.country = country; //'Singapore';
        i.name = name; //'Lee Hsien Loong';
        i.gender = gender; //'Male';
        i.dateOfBirth = dateOfBirth;//Date.newInstance(1952, 2, 10);
        i.recordId = recordId; //'0019D00000P5YJkQAN';
        doSearchCallout(new List<AmlCalloutInvocable.Input>{i});
    }
    
    
    public static List<Results> doSearchCallout(List<Input> inputParams){
        Results result = new Results();
        
        AmlApiClient client = new AmlApiClient();
        HttpResponse response = client.doSearchResultResponse(inputParams[0]); 
        if (response.getStatusCode() == 200){
            List<Object> bodyList = (List<Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> bodyMap = (Map<String, Object>) bodyList[0];
            result.isSuccess = true;
            result.isPEP = ((List<Object>) bodyMap.get('pepPersons') ).size() > 0; 
            result.isSIP = ((List<Object>) bodyMap.get('sipPersons') ).size() > 0;
            result.amlReportId = (String) bodyMap.get('amlReportId');
            system.debug(bodyMap.get('pepPersons'));
            system.debug(bodyMap.get('sipPersons'));

            /*Account acc = new Account();
            acc.id = inputParams[0].recordId;
            acc.PEP_Flagged__pc = result.isPEP;
            acc.SIP_Flagged__pc = result.isSIP;
            acc.Is_AML_Checked__pc = true;*/
            
            Contact ctc = new Contact();
            ctc.id = inputParams[0].recordId;
            ctc.PEP_Flagged__c = result.isPEP;
            ctc.SIP_Flagged__c = result.isSIP;
            ctc.Is_AML_Checked__c = true;
            //update acc; prevent uncommitted work pending
            
            AmlPdfCalloutInvocable.doPdfCallout(result.amlReportId, ctc);

        }else{
            result.isSuccess = false;
            result.errorMessage = response.getBody();
        }       

        return new List<Results> { result };
    }
    
    global class Results{
        @InvocableVariable
        public boolean isSuccess;
        @InvocableVariable
        public String errorMessage;
        
        @InvocableVariable
        public boolean isPEP;
        
        @InvocableVariable
        public boolean isSIP;

        @InvocableVariable
        global string amlReportId;
        
    }
    
    global class Input{
        
        @InvocableVariable
        global string recordId;

        @InvocableVariable
        global string country;
        
        @InvocableVariable
        global string name;
        
        @InvocableVariable
        global string gender;
        
        @InvocableVariable
        global Date dateOfBirth;        
    }

}