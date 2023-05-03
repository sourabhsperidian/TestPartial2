global class DXF_MasterProjectAPI {

  /*   @future(callout=true)
    public static void doPostCallout(Set<String> RecId){
        
		List<Project__c> projList = [SELECT RecordType.name, Id FROM Project__c WHERE Id IN:RecId];
        List<Project__c> result = new List<Project__c>();
        if(projList.size()>0){
            if(projList[0].RecordType.name == 'Primary Property'){
                result =  [SELECT area__c,RecordType.name,area_guide__c,avaialble_from__c,Bathrooms__c,Bedrooms__c,City__c,Country__c,CreatedById,CurrencyIsoCode,dep__c,description__c,excerpt__c,Facilities__c,File_URL__c,Floorplans__c,furnishings__c,Hot__c,Image_URL__c,LastModifiedById,Lat__c,lng__c,Outdoorarea__c,OwnerId,Ownership__c,Parking__c,Pdf_Details__c,Planned_Handover_Date__c,Price__c,Project_Address__c,Project_Id_DB__c,Name,Project_Stage__c,Project_Summary__c,Property_Type__c,Property_Area__c,Property_Name__c,Property_Proj_Type__c,Reapit_date__c,Reapit_Epcs__c,Reapit_Featured__c,Reapit_internet_adv__c,Reapit_Type__c,Receptions__c,RecordTypeId,Related_Account__c,S3_File_Url__c,Seo_Address__c,Seo_Desc__c,Seo_Prefix__c,Seo_Url__c,Sponsor_Bank__c,Sq_ft__c,Project_Status__c,Status__c,Tags__c,Tenure__c,Tour_Caption__c,Tour_Caption_2__c,UnitsAvailability__c,Units_Available__c,Units_Sold__c,Virtual_Tour__c,Virtual_Tour_2__c, (Select Name,Unit_Type__c,No_of_Sold_Units__c,No_of_Available_Units__c,Square_Meter_Min__c,Square_Meter_Max__c,UnitsAvailability__c from Project_Unit_Types__r ) FROM Project__c WHERE recordtypeid in (Select Id From RecordType where sobjecttype = 'Project__c' and name =: projList[0].RecordType.name ) and id=:RecId];
            system.debug('Inside if Primary property >>');
            }
            if(projList[0].RecordType.name == 'Secondary Property'){
               result =  [SELECT area__c,RecordType.name,area_guide__c,avaialble_from__c,Bathrooms__c,Bedrooms__c,City__c,Country__c,CreatedById,CurrencyIsoCode,dep__c,description__c,excerpt__c,Facilities__c,File_URL__c,Floorplans__c,furnishings__c,Hot__c,Image_URL__c,LastModifiedById,Lat__c,lng__c,Outdoorarea__c,OwnerId,Ownership__c,Parking__c,Pdf_Details__c,Planned_Handover_Date__c,Price__c,Project_Address__c,Project_Id_DB__c,Name,Project_Stage__c,Project_Summary__c,Property_Type__c,Property_Area__c,Property_Name__c,Property_Proj_Type__c,Reapit_date__c,Reapit_Epcs__c,Reapit_Featured__c,Reapit_internet_adv__c,Reapit_Type__c,Receptions__c,RecordTypeId,Related_Account__c,S3_File_Url__c,Seo_Address__c,Seo_Desc__c,Seo_Prefix__c,Seo_Url__c,Sponsor_Bank__c,Sq_ft__c,Project_Status__c,Status__c,Tags__c,Tenure__c,Tour_Caption__c,Tour_Caption_2__c,UnitsAvailability__c,Units_Available__c,Units_Sold__c,Virtual_Tour__c,Virtual_Tour_2__c
                        FROM Project__c
                        WHERE recordtypeid in (Select Id From RecordType where sobjecttype = 'Project__c' and name =:projList[0].RecordType.name) and id=:RecId];
       
            system.debug('Inside if Secondary property >>');
            }
            
        }																																																																							
        DXF_ProjectRequestWrapper reqList = New DXF_ProjectRequestWrapper();
        String postbody;
        
        
       // reqList.data = datawrapper;
        System.debug('request:' +  reqList);
        postbody = JSON.serialize(result);       
        System.debug( postbody);
		Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint('https://dxapi.speridian.com/api/projects');
		request.setBody(postbody);
        system.debug('RequestBody: ' + postbody);
        system.debug('Request: ' + request);
        
        HttpResponse response = http.send(request);
        system.debug('response: ' + response.getBody());
		
     //   update resultList;  
    }
    */
  
    
}