public class Druce_PublishOpportunityAPI {
    
    @AuraEnabled
    public static void calloutFromAura(String recId){
        doPostCallout(new Set<String>{recId});
    }
    
    //Create Method start here
    @future(callout=true)
    public static void doPostCallout(Set<String> RecId){
        
        SyncProperties(RecId);

    }
    
    public static void SyncProperties(Set<String> RecId){
        List<Druce_WebPublishRequestWrapper.projectwrapper> projectwrapper = New List<Druce_WebPublishRequestWrapper.projectwrapper>();
        
		List<Unit__c> projUnitList = [Select Id, Address_Line_1__c, Address_Line_2__c, Address_Line_3__c, Address_Line_4__c, Age__c, Reapit_Alternate_Id__c, Archived_On__c, Reapit_Area_Id__c, Available_From__c, Balcony_Direction__c, Bathrooms_Max__c, Bedrooms_Max__c, Block_Name__c, Board_Notes__c, Board_Status__c, Board_Updated__c, Brochure_Id__c, Build_Up_Area_square_ft__c, Build_Up_Area_m_square__c, BuildingName__c, BuildingNumber__c, Carpet_Area_square_ft__c, Carpet_Area_m_square__c, Commercial__c, Council_Tax_Band__c, Country__c, Country_Code__c, CreatedById, CurrencyIsoCode, Reapit_Department_Id__c, Reapit_Disabled_Portal_Ids__c, Embedded__c, EPC_Eer__c, EPC_Eer_Potential__c, EPC_Eir__c, EPC_Eir_Potential__c, EPC_Exempt__c, eTag__c, External_Area_Max__c, External_Area_Min__c, External_Area_Type__c, Extras_Field__c, Featured_Image_Url__c, Floor__c, From_Archive__c, Furnished_Status__c, Garden__c, Ground_Rent__c, Ground_Rent_Comment__c, Ground_Rent_Increase__c, Ground_Rent_Review_Date__c, Home_Insurance__c, Insurance_Company_Id__c, Internal_Area_Max__c, Internal_Area_Min__c, Internal_Area_Type__c, Reapit_Internet_Advertising__c, Is_External__c, KeyFeatureRich__c, LastModifiedById, Links__c, Local_Authority__c, Locality__c, localTimeZone__c, Lost_Instruction_Date__c, Lost_Instruction_Note__c, Maintenance_Fee__c, Maintenance_Fee_Percent__c, Reapit_Marketing_Mode__c, Metadata__c, Reapit_Negotiator_Id__c, No_of_Bedrooms__c, No_of_Washrooms__c, Notes__c, Number_Of_Units__c, Office_Ids__c, Parking__c, Parking_Spaces__c, Patio__c, Postal_Code__c, Price_Per_Square_Feet__c, Price_Per_Square_Metre__c, Reapit_Created_Date__c, Reapit_Id__c, Reapit_Modified_Date__c, Reception__c, Receptions_Max__c, Record_Type_Name__c, Regional__c, Rental_Guarantee__c, Rental_Guarantee_Percent__c, Room_Details_Approved__c, Rural__c, Secondary_Market__c, Service_Charge__c, Service_Charge_Comment__c, Shared_Ownership_Percentage__c, Situation__c, Sold_Date__c, Special_Features__c, Latitude__Latitude__s,Latitude__Longitude__s,Strapline__c, Style__c, Summary__c, Terrace__c, Type__c, Unit_Description__c, Unit_Long_Description__c, Name, Unit_Number__c, Unit_Price__c, Unit_Path__c, Unmapped_Attributes__c, URL_Caption__c, Valuation__c, VAT__c, VAT_Percent__c, Video_Caption__c, Video_Url__c, Video2Caption__c, Video2Url__c, Viewing_Arrangements__c, Unit_Type__c, URL__c FROM Unit__c WHERE Id IN: RecId];                                           
			for(Unit__c projUnit : projUnitList){
				List<Druce_WebPublishRequestWrapper.projectUnit> unitwrapper = New List<Druce_WebPublishRequestWrapper.projectUnit>();
				
				List<Druce_WebPublishRequestWrapper.projectUnitTypewrapper> unitTypewrapper = New List<Druce_WebPublishRequestWrapper.projectUnitTypewrapper>();
				Druce_WebPublishRequestWrapper.projectUnit unit = new Druce_WebPublishRequestWrapper.projectUnit();            
				unit.Reapit_Id = projUnit.Reapit_Id__c;
				unit.Age  = projUnit.Age__c;
				unit.AlternateId = projUnit.Reapit_Alternate_Id__c;
				unit.ArchivedOn    = projUnit.Archived_On__c;
				unit.AreaId  = projUnit.Reapit_Area_Id__c;
			//	unit.AvailableFrom   = projUnit.Available_From__c;
				unit.BalconyDirection = projUnit.Balcony_Direction__c;
				unit.BathroomsMax   = projUnit.Bathrooms_Max__c;
				unit.BedroomsMax = projUnit.Bedrooms_Max__c;
				unit.BlockName  = projUnit.Block_Name__c;
				unit.BoardNotes  = projUnit.Board_Notes__c;
				unit.BoardStatus = projUnit.Board_Status__c;
				unit.BoardUpdated = projUnit.Board_Updated__c;
				//unit. = projUnit.Brochure_Id__c;
				unit.BuildupArea_meter  = projUnit.Build_Up_Area_square_ft__c;
				unit.BuildupArea_ft     = projUnit.Build_Up_Area_m_square__c;
			//	unit.buildingName = projUnit.BuildingName__c;
				//unit.buildingNumber = projUnit.BuildingNumber__c;
				//unit.CarpetAreasquare_ft   = projUnit.Carpet_Area_square_ft__c;
				unit.CarpetAream_square = projUnit.Carpet_Area_m_square__c;
				unit.Commercial = projUnit.Commercial__c;
				unit.CouncilTaxBand = projUnit.Council_Tax_Band__c;
				unit.Country = projUnit.Country__c;
				//unit.CountryCode = projUnit.Country_Code__c;
				unit.CreatedBy = projUnit.CreatedById;
				unit.CurrencyCode = projUnit.CurrencyIsoCode;
				unit.DepartmentId = projUnit.Reapit_Department_Id__c;
				unit.DisabledPortalIds = projUnit.Reapit_Disabled_Portal_Ids__c;
				unit.Embedded = projUnit.Embedded__c;
				unit.EPCEer = projUnit.EPC_Eer__c;
				unit.EPCEerPotential = projUnit.EPC_Eer_Potential__c;
				unit.EPCEir = projUnit.EPC_Eir__c;
				unit.EPCEirPotential = projUnit.EPC_Eir_Potential__c;
				unit.EPCExempt = projUnit.EPC_Exempt__c;
				unit.eTag = projUnit.eTag__c;
				unit.ExternalAreaMax = projUnit.External_Area_Max__c;
				unit.ExternalAreaMin = projUnit.External_Area_Min__c;
				unit.ExternalAreaType = projUnit.External_Area_Type__c;
				unit.ExtrasField = projUnit.Extras_Field__c;
				unit.FeaturedImageUrl = projUnit.Featured_Image_Url__c;
				unit.Floor = projUnit.Floor__c;
				unit.FromArchive = projUnit.From_Archive__c;
				unit.FurnishedStatus = projUnit.Furnished_Status__c;
				unit.Garden = projUnit.Garden__c;
				unit.GroundRent = projUnit.Ground_Rent__c;
				unit.GroundRentComment = projUnit.Ground_Rent_Comment__c;
				unit.GroundRentIncrease = projUnit.Ground_Rent_Increase__c;
				unit.GroundRentReviewDate = projUnit.Ground_Rent_Review_Date__c;
				unit.HomeInsurance = projUnit.Home_Insurance__c;
				unit.InsuranceCompanyId = projUnit.Insurance_Company_Id__c;
				unit.InternalAreaMax = projUnit.Internal_Area_Max__c;
				unit.InternalAreaMin = projUnit.Internal_Area_Min__c;
				unit.InternalAreaType = projUnit.Internal_Area_Type__c;
				unit.InternetAdvertising = projUnit.Reapit_Internet_Advertising__c;
				unit.IsExternal = projUnit.Is_External__c;
				unit.KeyFeatures = projUnit.KeyFeatureRich__c;
				unit.LastModifiedBy = projUnit.LastModifiedById;
				//unit.latitude = projUnit.Latitude__c;
				//unit.longitude = projUnit.Longitude__c;
				unit.Links = projUnit.Links__c;
				unit.LocalAuthority = projUnit.Local_Authority__c;
				unit.Locality = projUnit.Locality__c;
				//unit.localTimeZone = projUnit.localTimeZone__c;
				unit.LostInstructionDate = projUnit.Lost_Instruction_Date__c;
				unit.LostInstructionNote = projUnit.Lost_Instruction_Note__c;
				unit.MaintenanceFee = projUnit.Maintenance_Fee__c;
				unit.MaintenanceFeePrcnt = projUnit.Maintenance_Fee_Percent__c;
				unit.MarketingMode = projUnit.Reapit_Marketing_Mode__c;
				unit.Metadata = projUnit.Metadata__c;
				unit.NegotiatorId = projUnit.Reapit_Negotiator_Id__c;
				unit.NoofBedrooms = projUnit.No_of_Bedrooms__c;
				unit.NoofWashrooms = projUnit.No_of_Washrooms__c;
				unit.Notes = projUnit.Notes__c;
				unit.NumberOfUnits = projUnit.Number_Of_Units__c;
				unit.OfficeIds = projUnit.Office_Ids__c;
				unit.Parking = projUnit.Parking__c;
				unit.ParkingSpaces = projUnit.Parking_Spaces__c;
				unit.Patio = projUnit.Patio__c;
				//unit.postcode = projUnit.Postal_Code__c;
			//	unit.PricePerSquareFeet = projUnit.Price_Per_Square_Feet__c;
			//	unit.PricePerSquareMetre = projUnit.Price_Per_Square_Metre__c;
				unit.ReapitCreatedDate = projUnit.Reapit_Created_Date__c;
				unit.Reapit_Id = projUnit.Reapit_Id__c;
				unit.ReapitModifiedDate = projUnit.Reapit_Modified_Date__c;
				unit.Reception = projUnit.Reception__c;
				unit.ReceptionsMax = projUnit.Receptions_Max__c;
				unit.RecordTypeName = projUnit.Record_Type_Name__c;
				unit.Regional = projUnit.Regional__c;
				//unit. = projUnit.Rental_Guarantee__c;
				//unit. = projUnit.Rental_Guarantee_Percent__c;
				unit.RoomDetailsApproved = projUnit.Room_Details_Approved__c;
				unit.Rural = projUnit.Rural__c;
				unit.SecondaryMarket = projUnit.Secondary_Market__c;
				unit.ServiceCharge = projUnit.Service_Charge__c;
				unit.ServiceChargeComment = projUnit.Service_Charge_Comment__c;
				unit.SharedOwnershipPercentage = projUnit.Shared_Ownership_Percentage__c;
				unit.Situation = projUnit.Situation__c;
				unit.SoldDate = projUnit.Sold_Date__c;
				unit.SpecialFeatures = projUnit.Special_Features__c;
				unit.Strapline = projUnit.Strapline__c;
				unit.Style = projUnit.Style__c;
				unit.Summary = projUnit.Summary__c;
				unit.Terrace = projUnit.Terrace__c;
				unit.Type = projUnit.Type__c;
				unit.UnitDescription = projUnit.Unit_Description__c;
				unit.UnitLongDescription = projUnit.Unit_Long_Description__c;
				unit.UnitName = projUnit.Name;
				unit.UnitNumber = projUnit.Unit_Number__c;
				unit.UnitPrice = projUnit.Unit_Price__c;
				unit.UnitStage = projUnit.Unit_Path__c;
				unit.UnmappedAttributes = projUnit.Unmapped_Attributes__c;
				unit.URLCaption = projUnit.URL_Caption__c;
				unit.Valuation = projUnit.Valuation__c;
				unit.VAT = projUnit.VAT__c;
				unit.VATpercent = projUnit.VAT_Percent__c;
				unit.VideoCaption = projUnit.Video_Caption__c;
				unit.VideoUrl = projUnit.Video_Url__c;
				unit.Video2Caption = projUnit.Video2Caption__c;
				unit.Video2Url = projUnit.Video2Url__c;
				unit.ViewingArrangements = projUnit.Viewing_Arrangements__c;
				unit.UnitType = projUnit.Unit_Type__c;
				unit.URL = projUnit.URL__c;
							
				/******************Unit Address wrapper start here************************/
				
				Druce_WebPublishRequestWrapper.UnitAddress unitAddress = new Druce_WebPublishRequestWrapper.UnitAddress();
				unitAddress.buildingName = projUnit.BuildingName__c;
				unitAddress.buildingNumber = projUnit.BuildingNumber__c;
				unitAddress.line1 = projUnit.Address_Line_1__c;
				unitAddress.line2 = projUnit.Address_Line_2__c;
				unitAddress.line3 = projUnit.Address_Line_3__c;
				unitAddress.line4 = projUnit.Address_Line_4__c;
				unitAddress.postcode = projUnit.Postal_Code__c;
				unitAddress.countryId = projUnit.Country_Code__c;
				unitAddress.localTimeZone = projUnit.localTimeZone__c;
				unitAddress.latitude = projUnit.Latitude__Latitude__s;
				unitAddress.longitude = projUnit.Latitude__Longitude__s;
				unit.UnitAddress = unitAddress;
				/******************Unit Files wrapper start here************************/
				List<Druce_WebPublishRequestWrapper.amazonFiles> amazonFiles = New List<Druce_WebPublishRequestWrapper.amazonFiles>();
				List<Amazon_Files__c> amazonFilesList = [Select Id, Name,CreatedById,Description__c,EPC__c,File_Type__c,Floor_Plan__c,Image_Name__c,Is_Primary__c,LastModifiedById,Path_Url__c,Reapit_Image_Url__c,S3_Response__c,S3_Response_Id__c,Status__c,Website_DB_Id__c from Amazon_Files__c WHERE (Unit__c =: projUnit.Id AND Status__c='Submitted')];
				
				for(Amazon_Files__c amzFiles : amazonFilesList){
					Druce_WebPublishRequestWrapper.amazonFiles fileReq = new Druce_WebPublishRequestWrapper.amazonFiles();
					fileReq.Id = amzFiles.Id;
					fileReq.AmazonFileName = amzFiles.Name;
					fileReq.CreatedBy = amzFiles.CreatedById;
				   // fileReq.CurrencyCode = amzFiles.CurrencyIsoCode;
					fileReq.Description = amzFiles.Description__c;
					fileReq.EPC = amzFiles.EPC__c;
					fileReq.FileType = amzFiles.File_Type__c;
					fileReq.FloorPlan = amzFiles.Floor_Plan__c;
					fileReq.ImageName = amzFiles.Image_Name__c;
					fileReq.IsPrimary = amzFiles.Is_Primary__c;
					fileReq.LastModifiedBy = amzFiles.LastModifiedById;
					fileReq.PathUrl = amzFiles.Path_Url__c;
					fileReq.ReapitImageUrl = amzFiles.Reapit_Image_Url__c;
					fileReq.S3Response = amzFiles.S3_Response__c;
					fileReq.S3_Response_Id = amzFiles.S3_Response_Id__c;
					fileReq.Status = amzFiles.Status__c;
					fileReq.WebsiteDBId = amzFiles.Website_DB_Id__c;
					amazonFiles.add(fileReq);
				}
				unit.amazonFiles = amazonFiles;
				/******************Unit Files wrapper end here************************/
				/****************** Room wrapper start here************************/

				List<Druce_WebPublishRequestWrapper.Rooms> Rooms = New List<Druce_WebPublishRequestWrapper.Rooms>();
				List<Room__c> roomList = [Select Id, CreatedById,CurrencyIsoCode,Description__c,Dimensions__c,Dimensions_Alt__c,LastModifiedById,Reapit_Id__c,Name from Room__c WHERE Unit__c =: projUnit.Id];
				for(Room__c room : roomList){
					Druce_WebPublishRequestWrapper.Rooms rmReq = new Druce_WebPublishRequestWrapper.Rooms();
					rmReq.CreatedById = room.CreatedById;
					rmReq.Id = room.Id;
				//	rmReq.CurrencyCode = room.CurrencyIsoCode;
					rmReq.Description = room.Description__c;
					rmReq.Dimensions = room.Dimensions__c;
					rmReq.DimensionsAlt = room.Dimensions_Alt__c;
					rmReq.LastModifiedById = room.LastModifiedById;
					rmReq.Reapit_Id = room.Reapit_Id__c;
					rmReq.Name = room.Name;
					Rooms.add(rmReq);
				}
				unit.Rooms = Rooms;
				
				
				unitwrapper.add(unit);
				/****************** Project Unit Type wrapper start here************************/
				string projutId = projUnit.project_unit_type__c; //Project Unit type Id
				List<Project_Unit_Type__c> projUnitType = [SELECT Id, Name,Unit_Type__c,Square_Meter_Min__c,Square_Meter_Max__c,
																 No_of_Available_Units__c,No_of_Sold_Units__c, Project__c,Project__r.Name FROM Project_Unit_Type__c where Id =: projutId]; // query project__c as parent value
				for(Project_Unit_Type__c ProjUType : projUnitType){
					Druce_WebPublishRequestWrapper.projectUnitTypewrapper utreq = new Druce_WebPublishRequestWrapper.projectUnitTypewrapper();         
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
						Druce_WebPublishRequestWrapper.projectwrapper req = new Druce_WebPublishRequestWrapper.projectwrapper();         
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
						Druce_WebPublishRequestWrapper.ProjectAddress projAddress = new Druce_WebPublishRequestWrapper.ProjectAddress();
						projAddress.Project_Address_CountryCode = proj.Project_Address__CountryCode__s;
						projAddress.Project_Address_Street = proj.Project_Address__street__s;
						projAddress.Project_Address_City = proj.Project_Address__City__s;
						projAddress.Project_Address_PostalCode = proj.Project_Address__PostalCode__s;
						projAddress.Project_Address_StateCode = proj.project_Address__StateCode__s;
						projAddress.Project_Address_Latitude = proj.Latitude__Latitude__s;
						projAddress.Project_Address_Longitude = proj.Latitude__Longitude__s;
						req.projectAddress = projAddress;
						
						
						List<Druce_WebPublishRequestWrapper.amazonFiles> projAmazonFiles = New List<Druce_WebPublishRequestWrapper.amazonFiles>();
						List<Amazon_Files__c> amazonFileslst = [Select Id, Name,Is_Primary__c,Path_Url__c,Status__c,
																	   Description__c,S3_Response__c,EPC__c,Floor_Plan__c
																	FROM Amazon_Files__c  where (Project_Id__c =: proj.Id AND Status__c='Submitted')];
						for(Amazon_Files__c amzFiles : amazonFileslst){
							Druce_WebPublishRequestWrapper.amazonFiles fileReq = new Druce_WebPublishRequestWrapper.amazonFiles();
							fileReq.Id = amzFiles.Id;
							fileReq.AmazonFileName = amzFiles.Name;
							fileReq.CreatedBy = amzFiles.CreatedById;
							// fileReq.CurrencyCode = amzFiles.CurrencyIsoCode;
							fileReq.Description = amzFiles.Description__c;
							fileReq.EPC = amzFiles.EPC__c;
							fileReq.FileType = amzFiles.File_Type__c;
							fileReq.FloorPlan = amzFiles.Floor_Plan__c;
							fileReq.ImageName = amzFiles.Image_Name__c;
							fileReq.IsPrimary = amzFiles.Is_Primary__c;
							fileReq.LastModifiedBy = amzFiles.LastModifiedById;
							fileReq.PathUrl = amzFiles.Path_Url__c;
							fileReq.ReapitImageUrl = amzFiles.Reapit_Image_Url__c;
							fileReq.S3Response = amzFiles.S3_Response__c;
							fileReq.S3_Response_Id = amzFiles.S3_Response_Id__c;
							fileReq.Status = amzFiles.Status__c;
							fileReq.WebsiteDBId = amzFiles.Website_DB_Id__c;
							amazonFiles.add(fileReq);
							projAmazonFiles.add(fileReq);
						}
						system.debug('amazonFiles'+ amazonFileslst);
					  //  req.Amazon_Files = projAmazonFiles;
						
						projectwrapper.add(req);      
					} // End of Project loop
				} //End of Project Unit Type loop
			}
        String postbody;
        // System.debug('request:' +  projectwrapper);
        postbody = JSON.serialize(projectwrapper);       
        System.debug(postbody);
        
        
        /********************** Get Access Token *************************************************/
     /*   String token  = Druce_PortalAuthentication.getToken();
        
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
        apiLog.Request_Body__c = postBody;
        apiLog.Response_Body__c = response.getBody();*/
     //   insert apiLog;
        
      /*  ProjectAPIResponseWrapper parsedResponse = (ProjectAPIResponseWrapper) JSON.deserialize(response.getBody(), ProjectAPIResponseWrapper.class); 
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
        }*/
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