public class Druce_OpportunityAPI {

      @future(callout=true)
    public static void doGetCallout(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint('https://dxapi.speridian.com/api/opportunity');
        
        HttpResponse response = http.send(request);
        system.debug('response: ' + response);
        system.debug('response: ' + response.getBody());
    }
    
 /**************************************Monika: Create Method for Oppotunity Listing, START, 20/01/2023 **************************/
    
    @future(callout=true)
    public static void doPostCallout(Set<String> RecId){
        
        List<Opportunity> oppList = [SELECT Id, Name, Type,RecordType.name 
                           FROM Opportunity WHERE Id IN:RecId];
        DXF_OppRequestWrapper reqList = New DXF_OppRequestWrapper();
        List<DXF_OppRequestWrapper.oppwrapper> datawrapper = New List<DXF_OppRequestWrapper.oppwrapper>();
  		List<DXF_OppRequestWrapper.unitpreferences> unitwrapList= New List<DXF_OppRequestWrapper.unitpreferences>();
        List<DXF_OppRequestWrapper.offers> offerwrapList= New List<DXF_OppRequestWrapper.offers>();
        List<DXF_OppRequestWrapper.transactions> txnwrapList= New List<DXF_OppRequestWrapper.transactions>();
        String postbody;
        for(Opportunity opp : oppList){
              DXF_OppRequestWrapper.oppwrapper req = new DXF_OppRequestWrapper.oppwrapper();
              req.Opp_Id = opp.Id;
              req.Oppt_Name = opp.Name;
            
            // Add Unit prefrences to Opportunity 
            List<Unit_Preference__c> unitList = [select name, Unit__r.name, Unit__r.Unit_Number__c, Unit_Type__c from Unit_Preference__c where Opportunity__c =: opp.Id];
            for(Unit_Preference__c units : unitList){
              DXF_OppRequestWrapper.unitpreferences upreq = new DXF_OppRequestWrapper.unitpreferences();
              upreq.UnitPrefNum = units.name;
              upreq.UnitName = units.Unit__r.name;
              upreq.Unit_Type = units.Unit_Type__c;
              unitwrapList.add(upreq);
            }
            // Add Offer to Opppotunity
              List<Offer__c > offerList = [select name, Unit__r.name, Unit__r.Unit_Number__c, Offer_Date__c, Offer_Price__c, Offer_Status__c  from Offer__c  where Opportunity__c =: opp.Id];
            for(Offer__c offers : offerList){
              DXF_OppRequestWrapper.offers offerreq = new DXF_OppRequestWrapper.offers();
              offerreq.OfferNum = offers.name;
              offerreq.UnitName = offers.Unit__r.name;
              offerreq.Offer_date = offers.Offer_Date__c;
              offerreq.Offer_price = offers.Offer_Price__c;
              offerreq.Offer_status = offers.Offer_Status__c;
              offerwrapList.add(offerreq);
            }
            // Add Transaction
            
            List<Transaction__c > txnList = [select name  from Transaction__c  where Opportunity__c =: opp.Id];
            for(Transaction__c txn : txnList){
                DXF_OppRequestWrapper.transactions txnreq = new DXF_OppRequestWrapper.transactions();
              txnreq.Name = txn.name;
              txnwrapList.add(txnreq);  
            }
            req.transactions = txnwrapList;
            req.offers = offerwrapList;
            req.unitprefs =unitwrapList;
            datawrapper.add(req);
        }   
     //   reqList.data = datawrapper;
        System.debug('request:' +  datawrapper);
        postbody = JSON.serialize(datawrapper);       
        System.debug( postbody);
       /* Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint('https://dxapi.speridian.com/api/opportunity');
        request.setBody(postbody);
        system.debug('RequestBody: ' + postbody);
        system.debug('Request: ' + request);
        
        HttpResponse response = http.send(request);
        system.debug('response: ' + response.getBody());
        ProjectAPIResParser parsedResponse = (ProjectAPIResParser) JSON.deserialize(response.getBody(), ProjectAPIResParser.class); 
        system.debug('responseparse: ' + parsedResponse); 
        List<Project__c> resultList = new List<Project__c>();

        for( Integer i = 0; i< parsedResponse.data.size(); i++){
            Project__c obj = new Project__c();
            obj.Id = parsedResponse.data[i].Project_Id;             
            obj.Project_Id_DB__c = parsedResponse.data[i].Id;
            resultList.add(obj);
        }
        update resultList;  */
    }
    
    
}