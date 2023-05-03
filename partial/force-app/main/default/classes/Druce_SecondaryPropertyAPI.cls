public class Druce_SecondaryPropertyAPI {
    
    @AuraEnabled
    public static void calloutFromAura(String recId){
        doPostCallout(new Set<String>{recId});
    }
    
    //Create Method start here
    @future(callout=true)
    public static void doPostCallout(Set<String> RecId){
        
        SyncProperties(RecId);
        
        /*
        for( Integer i = 0; i< parsedResponse.data.size(); i++){
            Project__c obj = new Project__c();
            obj.Id = parsedResponse.data[i].Project_Id;             
            obj.Project_Id_DB__c = parsedResponse.data[i].Id;
            resultList.add(obj);
        }
        update resultList;
*/
    }
    
    public static void SyncProperties(Set<String> RecId){
        List<Druce_ProjectRequestWrapper.projectwrapper> projectwrapper = New List<Druce_ProjectRequestWrapper.projectwrapper>();
        
        List<Unit__c> projUnitList = [Select Id, Reapit_Id__c,Reapit_Status__c,Name,Unit_Number__c,Unit_Price__c,Unit_Type__c,Balcony_Direction__c,
                                             Block_Name__c,Build_Up_Area_square_ft__c,Build_Up_Area_m_square__c,
                                             Carpet_Area_square_ft__c,Carpet_Area_m_square__c,Council_Tax_Band__c,CurrencyIsoCode,
                                             EPC_Rating__c,Floor__c,Furnished_Status__c,Garden__c,KeyFeatureRich__c,Local_Authority__c,
                                             Maintenance_Fee__c,Maintenance_Fee_Percent__c,No_of_Bedrooms__c,No_of_Washrooms__c,Parking__c,
                                             Patio__c,Price_Per_Square_Feet__c,Project_Unit_Type__c,Price_Per_Square_Metre__c,
                                             Reception__c,RecordTypeId,Record_Type_Name__c,Rent_per_Week__c,Rent_per_Month__c,
                                             Rental_Guarantee__c,Rental_Guarantee_Percent__c,Secondary_Market__c,Tenure_Type__c,Terrace__c,
                                             Unit_Availability__c,VAT__c,VAT_Percent__c,Address_Line_1__c,Address_Line_2__c,Address_Line_3__c,Address_Line_4__c,
                                             Postal_Code__c,Country_Code__c,Unit_Address__StateCode__s,Latitude__Latitude__s,Latitude__Longitude__s,
                                      		 Unit_Description__c, Unit_Long_Description__c,Summary__c,Locality__c,Office_Ids__c,Service_Charge__c,
                                             Service_Charge_Comment__c,Situation__c,Special_Features__c,Style__c,Type__c,Unit_Name_Web__c,Age__c,
                                             Sold_Date__c,Available_From__c,Reapit_Internet_Advertising__c,External_Area__c,
                                      		 External_Area_Type__c,External_Area_Min__c,External_Area_Max__c,Internal_Area__c,
                                      		 Internal_Area_Type__c,Internal_Area_Min__c,Internal_Area_Max__c,EPC_Eer__c,BuildingNumber__c,BuildingName__c,
                                      		 (SELECT Id,Name,Term__c FROM Lettings__r)	
                                      FROM Unit__c WHERE Id IN: RecId];
                                             
        for(Unit__c projUnit : projUnitList){
            List<Druce_ProjectRequestWrapper.projectUnit> unitwrapper = New List<Druce_ProjectRequestWrapper.projectUnit>();
            
            List<Druce_ProjectRequestWrapper.projectUnitTypewrapper> unitTypewrapper = New List<Druce_ProjectRequestWrapper.projectUnitTypewrapper>();
            Druce_ProjectRequestWrapper.projectUnit unit = new Druce_ProjectRequestWrapper.projectUnit();            
            unit.Reapit_Id = projUnit.Reapit_Id__c;
            unit.Reapit_Status = projUnit.Reapit_Status__c;
            unit.Unit_Id = projUnit.Id; 
            unit.Unit_Name = projUnit.Name;
            unit.Unit_Number = projUnit.BuildingNumber__c;
            unit.Unit_Price = projUnit.Unit_Price__c;
            unit.unit_Type = projUnit.Unit_Type__c;
            unit.Balcony_Direction = projUnit.Balcony_Direction__c;
            unit.Block_Name = projUnit.BuildingName__c;
            unit.Build_up_Area_ft = projUnit.Build_Up_Area_square_ft__c;
            unit.Build_up_Area_meter = projUnit.Build_Up_Area_m_square__c;
            unit.Carpet_Area_square_ft = projUnit.Carpet_Area_square_ft__c;
            unit.Carpet_Area_m_square = projUnit.Carpet_Area_m_square__c;
            unit.Council_Tax_Band = projUnit.Council_Tax_Band__c;
            unit.CurrencyISOCode = projUnit.CurrencyIsoCode;
            unit.EPC_Rating = projUnit.EPC_Rating__c;
            unit.Floor = projUnit.Floor__c;
            unit.Furnished_Status = projUnit.Furnished_Status__c;
            unit.KeyFeatureRich = projUnit.Garden__c;
            unit.KeyFeatureRich = projUnit.KeyFeatureRich__c;
            unit.Local_Authority = projUnit.Local_Authority__c;
            unit.Maintenance_Fee = projUnit.Maintenance_Fee__c;
            unit.Maintenance_Fee_Percent = String.valueOf(projUnit.Maintenance_Fee_Percent__c);
            unit.No_of_Bed_Rooms = Integer.valueOf(projUnit.No_of_Bedrooms__c);
            unit.No_of_Wash_Rooms = Integer.valueOf(projUnit.No_of_Washrooms__c);
            unit.Parking = projUnit.Parking__c;
            unit.Patio = projUnit.Patio__c;
            unit.Price_Per_Square_Feet = projUnit.Price_Per_Square_Feet__c;
            unit.Price_Per_Square_Metre = projUnit.Price_Per_Square_Metre__c;
            unit.Unit_Type = projUnit.Project_Unit_Type__c;
            unit.Reception = Integer.valueOf(projUnit.Reception__c);
            unit.RecordTypeId = projUnit.RecordTypeId;
            unit.Record_Type_Name = projUnit.Record_Type_Name__c;
            unit.Rent_per_Week = projUnit.Rent_per_Week__c;
            unit.Rent_per_Month = projUnit.Rent_per_Month__c;
            unit.Rental_Guarantee = projUnit.Rental_Guarantee__c;
            unit.Rental_Guarantee_Percent = projUnit.Rental_Guarantee_Percent__c;
            unit.Tenure_Type = projUnit.Tenure_Type__c;
            unit.Terrace = projUnit.Terrace__c;
            unit.Unit_Availability = projUnit.Unit_Availability__c;
            unit.VAT = projUnit.VAT__c;
            unit.VAT_Percent = projUnit.VAT_Percent__c;
            unit.Description = projUnit.Unit_Description__c;
            unit.Long_Description = projUnit.Unit_Long_Description__c;
            unit.Summary = projUnit.Summary__c;
            unit.Unit_Name_Web = projUnit.Unit_Name_Web__c;
            unit.F_Type= projUnit.Type__c;
            unit.Style= projUnit.Style__c;
            unit.Situation= projUnit.Situation__c;
            unit.Locality= projUnit.Locality__c;
            unit.Special_Features= projUnit.Special_Features__c;
            unit.Office_Ids= projUnit.Office_Ids__c;
            unit.Service_Charge= projUnit.Service_Charge__c;
            unit.Service_Charge_Comment= projUnit.Service_Charge_Comment__c;
            unit.Age= projUnit.Age__c;
            unit.Sold_Date= projUnit.Sold_Date__c;
            unit.Available_From= projUnit.Available_From__c;
            unit.Internet_Advertising= projUnit.Reapit_Internet_Advertising__c;
			unit.External_Area = projUnit.External_Area__c;
            unit.External_Area_Type = projUnit.External_Area_Type__c;
            unit.External_Area_Min = projUnit.External_Area_Min__c;
            unit.External_Area_Max = projUnit.External_Area_Max__c;
            unit.Internal_Area = projUnit.Internal_Area__c;
            unit.Internal_Area_Type = projUnit.Internal_Area_Type__c;
            unit.Internal_Area_Min = projUnit.Internal_Area_Min__c;
            unit.Internal_Area_Max = projUnit.Internal_Area_Max__c;
            unit.EPC_Eer = Integer.valueOf(projUnit.EPC_Eer__c);
            
            
            if(unit.Record_Type_Name == 'Primary UK' || unit.Record_Type_Name == 'Secondary UK'){
                unit.Record_Type = Druce_Constants.SALEUNIT; 
            }else if(unit.Record_Type_Name == 'Rental UK') {
                unit.Record_Type = Druce_Constants.RENTUNIT;
            }
            
            if(projUnit.Lettings__r.size() > 0){
                unit.Term = projUnit.Lettings__r[0].Term__c;
            }
            
            
            Druce_ProjectRequestWrapper.UnitAddress unitAddress = new Druce_ProjectRequestWrapper.UnitAddress();
            unitAddress.Unit_Address_CountryCode = projUnit.Country_Code__c;
            unitAddress.Unit_Address_Line_1 = projUnit.Address_Line_1__c;
            unitAddress.Unit_Address_Line_2 = projUnit.Address_Line_2__c;
            unitAddress.Unit_Address_Line_3 = projUnit.Address_Line_3__c;
            unitAddress.Unit_Address_Line_4 = projUnit.Address_Line_4__c;
            unitAddress.Unit_Address_PostalCode = projUnit.Postal_Code__c;
            unitAddress.Unit_Address_StateCode = projUnit.Unit_Address__StateCode__s;
            unitAddress.Unit_Address_Latitude = projUnit.Latitude__Latitude__s;
            unitAddress.Unit_Address_Longitude = projUnit.Latitude__Longitude__s;
            unit.Address = unitAddress;
            
            //Amazon Files wrapper
            List<Druce_ProjectRequestWrapper.amazonFiles> amazonFiles = New List<Druce_ProjectRequestWrapper.amazonFiles>();
            List<Amazon_Files__c> amazonFilesList = [Select Id, Name,Is_Primary__c,Path_Url__c,EPC__c,Floor_Plan__c,
                                                     Status__c,Description__c,S3_Response__c from Amazon_Files__c 
                                                     WHERE (Unit__c =: projUnit.Id AND Status__c='Submitted')];
            for(Amazon_Files__c amzFiles : amazonFilesList){
                Druce_ProjectRequestWrapper.amazonFiles fileReq = new Druce_ProjectRequestWrapper.amazonFiles();
                fileReq.FileName = amzFiles.Name;
                fileReq.Is_Primary = amzFiles.Is_Primary__c;
                fileReq.Path_Url = amzFiles.Path_Url__c;
                fileReq.epc = amzFiles.EPC__c;
                fileReq.Floor_Plan = amzFiles.Floor_Plan__c;
                fileReq.Status = amzFiles.Status__c;
                fileReq.Description = amzFiles.Description__c;
                fileReq.S3_Response = amzFiles.S3_Response__c;
                amazonFiles.add(fileReq);
            }
            system.debug('amazonFiles'+ amazonFiles);
            unit.Amazon_Files = amazonFiles;
            unitwrapper.add(unit);
            //Project Unit Type
            string projutId = projUnit.project_unit_type__c; //Project Unit type Id
            List<Project_Unit_Type__c> projUnitType = [SELECT Id, Name,Unit_Type__c,Square_Meter_Min__c,Square_Meter_Max__c,
                                                             No_of_Available_Units__c,No_of_Sold_Units__c, Project__c,Project__r.Name FROM Project_Unit_Type__c where Id =: projutId]; // query project__c as parent value
            for(Project_Unit_Type__c ProjUType : projUnitType){
                Druce_ProjectRequestWrapper.projectUnitTypewrapper utreq = new Druce_ProjectRequestWrapper.projectUnitTypewrapper();         
                utreq.Unit_Type_Id = ProjUType.Id;
                utreq.Unit_Type_Name = ProjUType.Name;
                utreq.Unit_Type = ProjUType.Unit_Type__c;
                utreq.Square_Meter_Min = ProjUType.Square_Meter_Min__c;
                utreq.Square_Meter_Max = ProjUType.Square_Meter_Max__c;
                utreq.No_of_Available_Units = ProjUType.No_of_Available_Units__c;
                utreq.No_of_Sold_Units = ProjUType.No_of_Sold_Units__c;
                utreq.Unit = unitwrapper; //wrap unit to unit type
                unitTypewrapper.add(utreq);
                
                //Project Details
                
                string projId = ProjUType.project__c;   //Project Id          
                List<Project__c> projList = [SELECT Id,Name,City__c,Country__c,CurrencyIsoCode,Facilities__c,Ownership__c,
                                                    Planned_Handover_Date__c,Project_Id_DB__c,Project_Stage__c,Project_Summary__c,
                                                    Property_Area__c,Property_Proj_Type__c,RecordTypeId,Related_Account__c,
                                                    Sponsor_Bank__c,Project_Status__c,Tags__c,UnitsAvailability__c,Units_Available__c,
                                                    Units_Sold__c,Secondary_Property__c, Project_Address__street__s,Project_Address__city__s,  
                                                    Project_Address__countrycode__s, Project_Address__postalcode__s,Project_Address__StateCode__s,
                                                    Project_Address__Latitude__s,Project_Address__Longitude__s,Latitude__Latitude__s,Latitude__Longitude__s
                                             FROM Project__c WHERE Id =:projId];
                for(Project__c Proj : projList){
                    Druce_ProjectRequestWrapper.projectwrapper req = new Druce_ProjectRequestWrapper.projectwrapper();         
                    req.Project_Id = proj.Id;
                    req.Project_Name = proj.Name;                    
                    req.City = proj.City__c;
                    req.Country = proj.Country__c;
                    req.CurrencyIsoCode = proj.CurrencyIsoCode;
                    req.Facilities = proj.Facilities__c;
                    req.Ownership = proj.Ownership__c;
                    req.Planned_Handover_Date = proj.Planned_Handover_Date__c;
                    req.Project_Id_DB = proj.Project_Id_DB__c;
                    req.Project_Stage = proj.Project_Stage__c;
                    req.Project_Summary = proj.Project_Summary__c;
                    req.Property_Area = proj.Property_Area__c;
                    req.Property_Proj_Type = proj.Property_Proj_Type__c;
                    req.RecordTypeId = proj.RecordTypeId;
                    req.Related_Account = proj.Related_Account__c;
                    req.Sponsor_Bank = proj.Sponsor_Bank__c;
                    req.Project_Status = proj.Project_Status__c;
                    req.Tags = proj.Tags__c;
                    req.UnitsAvailability = proj.UnitsAvailability__c;
                    req.Units_Available = Integer.valueOf(proj.Units_Available__c);
                    req.Units_Sold = Integer.valueOf(proj.Units_Sold__c);
                    req.Secondary_Property = proj.Secondary_Property__c;
                    
                    req.projectUnitType = unitTypewrapper; //  wrap unit type with Project
                    
                    //wrap Address
                    Druce_ProjectRequestWrapper.ProjectAddress projAddress = new Druce_ProjectRequestWrapper.ProjectAddress();
                    projAddress.Project_Address_CountryCode = proj.Project_Address__CountryCode__s;
                    projAddress.Project_Address_Street = proj.Project_Address__street__s;
                    projAddress.Project_Address_City = proj.Project_Address__City__s;
                    projAddress.Project_Address_PostalCode = proj.Project_Address__PostalCode__s;
                    projAddress.Project_Address_StateCode = proj.project_Address__StateCode__s;
                    projAddress.Project_Address_Latitude = proj.Latitude__Latitude__s;
                    projAddress.Project_Address_Longitude = proj.Latitude__Longitude__s;
                    req.projectAddress = projAddress;
                    
                    
                    List<Druce_ProjectRequestWrapper.amazonFiles> projAmazonFiles = New List<Druce_ProjectRequestWrapper.amazonFiles>();
                    List<Amazon_Files__c> amazonFileslst = [Select Id, Name,Is_Primary__c,Path_Url__c,Status__c,
                                                            	   Description__c,S3_Response__c,EPC__c,Floor_Plan__c
                                                            	FROM Amazon_Files__c  where (Project_Id__c =: proj.Id AND Status__c='Submitted')];
                    for(Amazon_Files__c amzFiles : amazonFileslst){
                        Druce_ProjectRequestWrapper.amazonFiles fileReq = new Druce_ProjectRequestWrapper.amazonFiles();
                        fileReq.FileName = amzFiles.Name;
                        fileReq.Is_Primary = amzFiles.Is_Primary__c;
                        fileReq.epc = amzFiles.EPC__c;
                        fileReq.Floor_Plan = amzFiles.Floor_Plan__c;
                        fileReq.Path_Url = amzFiles.Path_Url__c;
                        fileReq.Status = amzFiles.Status__c;
                        fileReq.Description = amzFiles.Description__c;
                        fileReq.S3_Response = amzFiles.S3_Response__c;
                        projAmazonFiles.add(fileReq);
                    }
                    system.debug('amazonFiles'+ amazonFileslst);
                    req.Amazon_Files = projAmazonFiles;
                    
                    projectwrapper.add(req);      
                } // End of Project loop
            } //End of Project Unit Type loop
        }
        String postbody;
        // System.debug('request:' +  projectwrapper);
        postbody = JSON.serialize(projectwrapper);       
        System.debug(postbody);
        
        
        /********************** Get Access Token *************************************************/
        String token  = Druce_PortalAuthentication.getToken();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // request.setHeader('Authorization', 'Bearer ' + token);
        request.setMethod('POST');
        request.setHeader('project', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setHeader('Authorization', 'Bearer ' + token);
        //   request.setEndpoint('https://dxapi.speridian.com/api/projects');
        request.setEndpoint('https://dxsfapi.speridian.com/api/v1/sf/projects');
        
        request.setBody(postbody);
        system.debug('RequestBody: ' + postbody);
        system.debug('Request: ' + request);
        
        
        HttpResponse response = http.send(request);
        system.debug('response: ' + response.getBody());
                
        API_Log__c apiLog = new API_Log__c();
        apiLog.Method__c = 'POST';
        apiLog.Object_Name__c = 'Unit__c';
        if(postBody.length() <= 131000 ){
		    apiLog.Request_Body__c = postBody;
        }else{
            apiLog.Request_Body__c = postBody.substring(0, 131000);
        }
        apiLog.Response_Body__c = response.getBody();
        insert apiLog;
        
        ProjectAPIResponseWrapper parsedResponse = (ProjectAPIResponseWrapper) JSON.deserialize(response.getBody(), ProjectAPIResponseWrapper.class); 
        system.debug('responseparse: ' + parsedResponse); 
        List<Project__c> projectLst = new List<Project__c>();
        Set<Project__c> SetprojectLst = new Set<Project__c>();
        List<Project_Unit_Type__c> unitTypeLst = new List<Project_Unit_Type__c>();
        Set<Project_Unit_Type__c> SetunitTypeLst = new Set<Project_Unit_Type__c>();
        List<Unit__c> unitLst = new List<Unit__c>();
        Set<Unit__c> unitSet = new Set<Unit__c>();
        Map<Id, Project__c> mapProject = new Map<Id,Project__c>();
        
        Map<String, String> projectMap = new Map<String, String>();
        
        List<ProjectAPIResponseWrapper.response> responseLst = parsedResponse.response;
        for(ProjectAPIResponseWrapper.response res :responseLst){  
            system.debug('--->'+res.sfProjectId);
            system.debug('--->'+res.projectId);
            
            SetprojectLst.add(new Project__c(Id = res.sfProjectId, Project_Id_DB__c = res.projectId, Project_Stage__c = 'Published'));
            for(ProjectAPIResponseWrapper.ProjectUnitType unitTypeRes : res.ProjectUnitType){
                SetunitTypeLst.add(new Project_Unit_Type__c(Id = unitTypeRes.sfprojectUnitId, Project_Unity_Type_DB_Id__c = unitTypeRes.projectUnitId));
                
                for(ProjectAPIResponseWrapper.Unit unit : unitTypeRes.unit){
                   unitSet.add(new Unit__c(Id = unit.sfUnitId, Unit_DB_Id__c = unit.unitId, Unit_Path__c = 'Published')); 
                }
            }
        }
        
        system.debug('unitSet :'+unitSet);
        if(!SetprojectLst.isEmpty()){
            projectLst.addAll(SetprojectLst);
            update projectLst;
        }
        
        if(!SetunitTypeLst.isEmpty()){
            unitTypeLst.addAll(SetunitTypeLst);
            update unitTypeLst;
        }
        
        if(!unitSet.isEmpty()){
            unitLst.addAll(unitSet);
            update unitLst;
        }
    }
    /*************doPostCallout End here ******************************/
    
    /*************Wrapper Class ******************************/
    public class resWrapper{
        public Integer status;  //200
        public String message;  //login successful
        public cls_response response;
    }
    class cls_response {
        public String token;
        public String Status; 
        public String ExtId;
        public String SFId;
        public String refreshToken; 
    }
}