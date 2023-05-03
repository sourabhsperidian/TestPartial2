@RestResource(urlMapping='/interest/v1/*')
global class ViewInterestRest_API {
	
    @HttpPost
    global static void CreateInterest(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string reqJsonString = req.requestBody.tostring();
        string respJsonString;
        List<DXF_ViewInterestWrapper> wReqList = (List<DXF_ViewInterestWrapper>) JSON.deserialize(reqJsonString, List<DXF_ViewInterestWrapper>.class);
        system.debug('Req : '+wReqList);
        
        DXF_ResponseWrapper resWrapper = new DXF_ResponseWrapper();
        DXF_ResponseWrapper.response response = new DXF_ResponseWrapper.response();
        List<DXF_ResponseWrapper.results> resultList = new List<DXF_ResponseWrapper.results>();
        List<View_Interest__c> interestList = new List<View_Interest__c>();
        
		try{
			for(DXF_ViewInterestWrapper wReq : wReqList)
            {
				View_Interest__c interest = new View_Interest__c();
				Account act = [SELECT Id,Name FROM Account where PersonEmail = :wReq.email AND Phone = :wReq.phone];
				interest.Name__c = act.Id;
				//interest.Email__c = wReq.email;
				interest.Would_you_like_get_Email_Alerts__c = wReq.emailAlertFlag;
				//interest.First_Name__c = wReq.fName;
				//interest.Last_Name__c = wReq.lName;
				interest.No_of_Bedrooms__c = wReq.bedRoom;
				//interest.Phone__c = wReq.phone;
				interest.Price_Range_Min__c = wReq.minPrice;
				interest.Price_Range_Max__c = wReq.maxPrice;
				interest.Location__c = wReq.location;
				interest.Interest_Type__c = wReq.interestType;
				interest.Description__c = wReq.description;
				interest.Expected_Move_in_Date__c = wReq.expectedMovingDate;
				interest.Name = act.Name + ' ' + wReq.location;
				interest.Interest_Source__c = 'Website';
				interest.Interest_Status__c = 'New';
				interest.How_flexible_are_you__c = wReq.matchPreference;
				interest.Tenure_Details__c = wReq.lettingDuration;
				
				interestList.add(interest);
			}
			insert interestList;
        
			for(View_Interest__c i : interestList)
			{
				DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
				result.salesforce_Id = i.Id;
				result.message = 'Interest Created successfully';
				resultList.add(result);
			}
			response.results = resultList;
			response.Status = 'Success';
			response.status_code = '200';
				
			resWrapper.response = response;
			respJsonString = JSON.serialize(resWrapper);
			RestContext.response.addHeader('Content-Type', 'application/json');
			RestContext.response.responseBody = Blob.valueOf(respJsonString);
		}
		catch(DmlException e){
			Integer numOfErrors = e.getNumDml();
			String errMsg = 'Error: ';
			for(Integer i = 0; i < numOfErrors; i++){
				errMsg += e.getDMLMessage(i);
			}
			response.errormessage = errMsg + '; No. of Error: ' + numOfErrors;
			response.Status = 'Error';
            response.status_code = '400';
            resWrapper.response = response;
            respJsonString = JSON.serialize(resWrapper);
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(respJsonString);
		}
		catch(Exception e){
			response.errormessage = e.getMessage();
            response.Status = 'Failed';
            response.status_code = 'Err_Excep';
            resWrapper.response = response;
            respJsonString = JSON.serialize(resWrapper);
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(respJsonString);
		}
    }
}