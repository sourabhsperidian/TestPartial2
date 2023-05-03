@RestResource(urlMapping='/projectstest/*')
global class testProjectRestService {

  @HttpPost
    global Static void createProject(){
        
        String strJSON;
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        system.debug('jsonString : '+jsonString);
        boolean successCheck;
        List<requestWrapperclass> wRespList = (List<requestWrapperclass>) JSON.deserialize(jsonString,List<requestWrapperclass>.class);
        system.debug('Wrapper class : '+wRespList);
        Project__c obj = new Project__c();
        List<Project__c> prjList = new List<Project__c>();

        for(requestWrapperclass wResp: wRespList){
          obj.Name = wResp.Project_Name;   
         // obj.Property_Type__c = wResp.Project_Type;    
        //  obj.Image_URL__c = wResp.Image_URL;   
          obj.Property_Area__c = wResp.Property_Area;
          obj.Project_Id_DB__c = wResp.Project_Id;
          prjList.add(obj);
      }
      

     /* try{
        if(prjList.size() > 0){
            Insert prjList;
            successCheck = true;
            
            DXF_ResponseWrapper resWrapper = new DXF_ResponseWrapper();
            DXF_ResponseWrapper.response response = new DXF_ResponseWrapper.response();
            List<DXF_ResponseWrapper.results> resultList = new List<DXF_ResponseWrapper.results>();
            
            
            for(Project__c prj :prjList){
                DXF_ResponseWrapper.results result = new DXF_ResponseWrapper.results();
                result.extDB_Id = prj.Project_Id_DB__c;
                result.salesforce_Id = prj.Id;
                resultList.add(result);
            }
            response.results = resultList;
            response.Status = 'Success';
            response.status_code = '200';
            resWrapper.response = response;
            strJSON = JSON.serialize(resWrapper);
            
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(strJSON);
        
      }

      catch(Exception e){
        successCheck = false;
      }*/
      
    }

      global class requestWrapperclass{        
        global string Project_Name;        
        global string Project_Type;        
        global string Image_URL;        
        global String Property_Area;
        global String Project_Id;        
    }

}