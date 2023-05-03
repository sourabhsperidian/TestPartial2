@RestResource(urlMapping='/projects/*')
global class ProjectRestService {
    
    @HttpGet
    global Static List<Project__c> getProject(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String recId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Project__c> projResult;
        List<Project_Unit_Type__c > unitResult;
        system.debug('recId :'+recId);
        
        if(String.isNotBlank(recId) && recId.startsWith('a06')){
            projResult = [SELECT Id, Name, Country__c, City__c, Facilities__c, Planned_Handover_Date__c, 
                      Project_Address__c,Project_Id_DB__c,Project_Stage__c,Project_Summary__c,
                      Property_Area__c,  Sponsor_Bank__c, Tags__c,
                      UnitsAvailability__c, Units_Available__c, Units_Sold__c,
                      (Select Name,Unit_Type__c,No_of_Sold_Units__c,No_of_Available_Units__c,Square_Meter_Min__c,Square_Meter_Max__c,UnitsAvailability__c from Project_Unit_Types__r )
                          FROM Project__c WHERE Id = :recId];
        }else{
            projResult = [SELECT Id, Name, Country__c, City__c, Facilities__c, Planned_Handover_Date__c, 
                      Project_Address__c,Project_Id_DB__c,Project_Stage__c,Project_Summary__c,
                      Property_Area__c, Sponsor_Bank__c, Tags__c,
                      UnitsAvailability__c, Units_Available__c, Units_Sold__c,
                          (Select Name,Unit_Type__c,No_of_Sold_Units__c,No_of_Available_Units__c,Square_Meter_Min__c,Square_Meter_Max__c,UnitsAvailability__c from Project_Unit_Types__r )
                          FROM Project__c];
        }
        
        return projResult;    
    }
    
    @HttpPost
    global Static void createProject(){
        
        String strJSON;
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        system.debug('jsonString : '+jsonString);
        
        boolean successCheck;
        List<responseWrapper> wRespList = (List<responseWrapper>) JSON.deserialize(jsonString,List<responseWrapper>.class);
        
        List<Project__c> prjList = new List<Project__c>();

        for(responseWrapper wResp: wRespList)
        {
          Project__c obj = new Project__c();
          obj.Name = wResp.Project_Name;   
         // obj.Property_Type__c = wResp.Project_Type;    
         // obj.Image_URL__c = wResp.Image_URL;   
          obj.Property_Area__c = wResp.Property_Area;
          obj.Project_Id_DB__c = wResp.Project_Id;
          prjList.add(obj);
       }
    system.debug('prjList : '+prjList);
      try{
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
             system.debug('resultList : '+resultList);
            response.results = resultList;
            response.Status = 'Success';
            response.status_code = '200';
            resWrapper.response = response;
            strJSON = JSON.serialize(resWrapper);
            
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(strJSON);
        }
      }

      catch(Exception e){
        successCheck = false;
      }
    }
    
     @HttpPut
    global Static void updateProject(){
        
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        string jsonString = req.requestBody.tostring();
        system.debug('jsonString : '+jsonString);
        
        boolean successCheck;
        List<responseWrapper> wRespList = (List<responseWrapper>) JSON.deserialize(jsonString,List<responseWrapper>.class);
        
        List<Project__c> prjList = new List<Project__c>();

        for(responseWrapper wResp: wRespList)
        {
        Project__c obj = new Project__c();
          obj.Name = wResp.Project_Name;   
        //  obj.Property_Type__c = wResp.Project_Type;    
         // obj.Image_URL__c = wResp.Image_URL;   
          obj.Property_Area__c = wResp.Property_Area;
          obj.Project_Id_DB__c = wResp.Project_Id;
          obj.Id= wResp.Project_SF_Id;
          prjList.add(obj);
       }

      try{
        if(prjList.size() > 0){
            update prjList;
            successCheck = true;
            String strJSON = '{"status":"Success","Status_code":200,"message":"Project updated successfully"}';
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = Blob.valueOf(strJSON);
           
        }
      }

      catch(Exception e){
        successCheck = false;
      }
    }
    
    @HttpDelete
    global Static void deleteProject(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String recordId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        String recordId = req.params.get('ids');   
        List<String> delIds = recordId.split(',');
        Delete [SELECT Id FROM Project__c WHERE Id IN: delIds];
        String strJSON = '{"status":"Success","Status_code":200,"message":"Project deleted successfully"}';
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(strJSON);
    }

    global class responseWrapper{        
        global string Project_Name;        
        global string Project_Type;        
        global string Image_URL;        
        global String Property_Area;
        global String Project_Id; 
        global string Project_SF_Id = '';
    }

}