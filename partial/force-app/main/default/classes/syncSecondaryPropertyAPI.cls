public class syncSecondaryPropertyAPI {
    
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
        List<webSyncRequestWrapper.projectwrapper> projectwrapper = New List<webSyncRequestWrapper.projectwrapper>();
        
        List<Unit__c> projUnitList = [Select Id, Reapit_Id__c,Project_Unit_Type__c,Special_Features__c,Reapit_Created_Date__c,Reapit_Modified_Date__c,Reapit_Marketing_Mode__c,CurrencyIsoCode,Reapit_Alternate_Id__c,BuildingName__c,BuildingNumber__c,Address_Line_1__c,Address_Line_2__c,Address_Line_3__c,Address_Line_4__c,Postal_Code__c,Country_Code__c,localTimeZone__c,Latitude__Latitude__s,Latitude__Longitude__s,Reapit_Area_Id__c,Strapline__c,Unit_Description__c,Unit_Long_Description__c,Local_Authority__c,KeyFeatureRich__c,Reapit_Department_Id__c,Reapit_Negotiator_Id__c,No_of_Bedrooms__c,Bedrooms_Max__c,Reception__c,Receptions_Max__c,No_of_Washrooms__c,Bathrooms_Max__c,Number_Of_Units__c,Parking_Spaces__c,Council_Tax_Band__c,Reapit_Disabled_Portal_Ids__c,Reapit_Internet_Advertising__c,Is_External__c,Viewing_Arrangements__c,Video_Url__c,Video_Caption__c,Video2Url__c,Video2Caption__c,Notes__c,Board_Status__c,Board_Notes__c,Featured_Image_Url__c,URL__c,URL_Caption__c,Ground_Rent__c,Ground_Rent_Comment__c,Ground_Rent_Review_Date__c,Ground_Rent_Increase__c,Service_Charge__c,Service_Charge_Comment__c,Board_Updated__c,Valuation__c,Archived_On__c,From_Archive__c,Rural__c,External_Area_Type__c,External_Area_Min__c,External_Area_Max__c,Internal_Area_Type__c,Internal_Area_Min__c,Internal_Area_Max__c,EPC_Exempt__c,EPC_Eer__c,EPC_Eer_Potential__c,EPC_Eir__c,EPC_Eir_Potential__c,Commercial__c,Regional__c,Type__c,Style__c,Situation__c,Parking__c,Age__c,Locality__c,Unmapped_Attributes__c,Room_Details_Approved__c,Office_Ids__c,Lost_Instruction_Date__c,Lost_Instruction_Note__c,Keywords__c,Extras_Field__c,eTag__c,Links__c,Embedded__c,Metadata__c,Reapit_Status__c,Name,Unit_Price__c,Balcony_Direction__c,Build_Up_Area_square_ft__c,Build_Up_Area_m_square__c,Carpet_Area_square_ft__c,Carpet_Area_m_square__c,Floor__c,Furnished_Status__c,Garden__c,Maintenance_Fee__c,Maintenance_Fee_Percent__c,Patio__c,Price_Per_Square_Feet__c,Price_Per_Square_Metre__c,Unit_Type__c,RecordTypeId,Record_Type_Name__c,Rent_per_Week__c,Rent_per_Month__c,Rental_Guarantee__c,Rental_Guarantee_Percent__c,Terrace__c,Unit_Availability__c,VAT__c,VAT_Percent__c,Unit_Name_Web__c,Sold_Date__c,EPC_Rating__c,Region__c FROM Unit__c WHERE Id IN: RecId];
                                             
        for(Unit__c projUnit : projUnitList){
            List<webSyncRequestWrapper.projectUnit> unitwrapper = New List<webSyncRequestWrapper.projectUnit>();
            
            List<webSyncRequestWrapper.projectUnitTypewrapper> unitTypewrapper = New List<webSyncRequestWrapper.projectUnitTypewrapper>();
            webSyncRequestWrapper.projectUnit unit = new webSyncRequestWrapper.projectUnit();    
			
			unit.Unit_Id = projUnit.Id;
			unit.Reapit_Id = projUnit.Reapit_Id__c;
			unit.Reapit_Created_Date = projUnit.Reapit_Created_Date__c;
			unit.Reapit_Modified_Date = projUnit.Reapit_Modified_Date__c;
			unit.Marketing_Mode = projUnit.Reapit_Marketing_Mode__c;
			unit.CurrencyISOCode = projUnit.CurrencyIsoCode;
			unit.Alternate_Id = projUnit.Reapit_Alternate_Id__c;
			unit.Area_Id = projUnit.Reapit_Area_Id__c;
			unit.Strapline = projUnit.Strapline__c;
			unit.Description = projUnit.Unit_Description__c;
			unit.Long_Description = projUnit.Unit_Long_Description__c;
			unit.Local_Authority = projUnit.Local_Authority__c;
			unit.Summary = projUnit.KeyFeatureRich__c;
			unit.Department_Id = projUnit.Reapit_Department_Id__c;
			unit.Negotiator_Id = projUnit.Reapit_Negotiator_Id__c;
			unit.No_of_Bed_Rooms = Integer.valueOf(projUnit.No_of_Bedrooms__c);
			unit.Bedrooms_Max = Integer.valueOf(projUnit.Bedrooms_Max__c);
			unit.Reception = Integer.valueOf(projUnit.Reception__c);
			unit.Receptions_Max = Integer.valueOf(projUnit.Receptions_Max__c);
			unit.No_of_Wash_Rooms = Integer.valueOf(projUnit.No_of_Washrooms__c);
			unit.Bathrooms_Max = Integer.valueOf(projUnit.Bathrooms_Max__c);
			unit.Number_Of_Units = projUnit.Number_Of_Units__c;
			unit.Parking_Spaces = projUnit.Parking_Spaces__c;
			unit.Council_Tax_Band = projUnit.Council_Tax_Band__c;
			unit.Disabled_Portal_Ids = projUnit.Reapit_Disabled_Portal_Ids__c;
			unit.Internet_Advertising = projUnit.Reapit_Internet_Advertising__c;
			unit.Is_External = projUnit.Is_External__c;
			unit.Viewing_Arrangements = projUnit.Viewing_Arrangements__c;
			unit.Video_Url = projUnit.Video_Url__c;
			unit.Video_Caption = projUnit.Video_Caption__c;
			unit.Video2_Url = projUnit.Video2Url__c;
			unit.Video2_Caption = projUnit.Video2Caption__c;
			unit.Notes = projUnit.Notes__c;
			unit.Board_Status = projUnit.Board_Status__c;
			unit.Board_Notes = projUnit.Board_Notes__c;
			unit.Featured_Image_Url = projUnit.Featured_Image_Url__c;
			unit.Url = projUnit.URL__c;
			unit.Url_Caption = projUnit.URL_Caption__c;
			unit.Ground_Rent = projUnit.Ground_Rent__c;
			unit.Ground_Rent_Comment = projUnit.Ground_Rent_Comment__c;
			unit.Ground_Rent_Review_Date = projUnit.Ground_Rent_Review_Date__c;
			unit.Ground_Rent_Increase = projUnit.Ground_Rent_Increase__c;
			unit.Service_Charge= projUnit.Service_Charge__c;
			unit.Service_Charge_Comment= projUnit.Service_Charge_Comment__c;
			unit.Board_Updated= projUnit.Board_Updated__c;
			unit.Valuation= projUnit.Valuation__c;
			unit.Archived_On= projUnit.Archived_On__c;
			unit.From_Archive= projUnit.From_Archive__c;
			unit.Rural= projUnit.Rural__c;
			unit.External_Area_Type = projUnit.External_Area_Type__c;
			unit.External_Area_Min = projUnit.External_Area_Min__c;
			unit.External_Area_Max = projUnit.External_Area_Max__c;
			unit.Internal_Area_Type = projUnit.Internal_Area_Type__c;
			unit.Internal_Area_Min = projUnit.Internal_Area_Min__c;
			unit.Internal_Area_Max = projUnit.Internal_Area_Max__c;
			unit.EPC_Exempt= projUnit.EPC_Exempt__c;
			unit.EPC_Eer = Integer.valueOf(projUnit.EPC_Eer__c);
			unit.EPC_EerPotential = Integer.valueOf(projUnit.EPC_Eer_Potential__c);
			unit.EPC_Eir = Integer.valueOf(projUnit.EPC_Eir__c);
			unit.EPC_EirPotential = Integer.valueOf(projUnit.EPC_Eir_Potential__c);
			unit.Commercial = projUnit.Commercial__c;
			unit.Regional = projUnit.Regional__c;
			unit.F_Type = projUnit.Type__c;
			unit.Style = projUnit.Style__c;
			unit.Situation = projUnit.Situation__c;
			unit.Parking = projUnit.Parking__c;
			unit.Age = projUnit.Age__c;
			unit.Locality = projUnit.Locality__c;
			unit.Special_Features = projUnit.Special_Features__c;
			unit.Unmapped_Attributes = projUnit.Unmapped_Attributes__c;
			unit.Room_Details_Approved = projUnit.Room_Details_Approved__c;
			unit.Office_Ids = projUnit.Office_Ids__c;
			unit.Lost_Instruction_Date = projUnit.Lost_Instruction_Date__c;
			unit.Lost_Instruction_Note = projUnit.Lost_Instruction_Note__c;
			unit.Keywords = projUnit.Keywords__c;
			unit.Extras_Field = projUnit.Extras_Field__c;
			unit.E_Tag = projUnit.eTag__c;
			unit.Links = projUnit.Links__c;
			unit.Embedded = projUnit.Embedded__c;
			unit.Metadata = projUnit.Metadata__c;
			unit.Reapit_Status = projUnit.Reapit_Status__c;
		//	unit.Unit_Id = projUnit.Id; 
			unit.Unit_Name = projUnit.Name;
			unit.Unit_Price = projUnit.Unit_Price__c;
			unit.unit_Type = projUnit.Unit_Type__c;
			unit.Balcony_Direction = projUnit.Balcony_Direction__c;
			unit.Build_up_Area_ft = projUnit.Build_Up_Area_square_ft__c;
			unit.Build_up_Area_meter = projUnit.Build_Up_Area_m_square__c;
			unit.Carpet_Area_square_ft = projUnit.Carpet_Area_square_ft__c;
			unit.Carpet_Area_m_square = projUnit.Carpet_Area_m_square__c;
			unit.Floor = projUnit.Floor__c;
			unit.Furnished_Status = projUnit.Furnished_Status__c;
			unit.Garden = projUnit.Garden__c;
			unit.Maintenance_Fee = projUnit.Maintenance_Fee__c;
			unit.Maintenance_Fee_Percent = String.valueOf(projUnit.Maintenance_Fee_Percent__c);
			unit.Patio = projUnit.Patio__c;
			unit.Price_Per_Square_Feet = projUnit.Price_Per_Square_Feet__c;
			unit.Price_Per_Square_Metre = projUnit.Price_Per_Square_Metre__c;
			unit.RecordTypeId = projUnit.RecordTypeId;
			unit.Record_Type_Name = projUnit.Record_Type_Name__c;
			unit.Rent_per_Week = projUnit.Rent_per_Week__c;
			unit.Rent_per_Month = projUnit.Rent_per_Month__c;
			unit.Rental_Guarantee = projUnit.Rental_Guarantee__c;
			unit.Rental_Guarantee_Percent = projUnit.Rental_Guarantee_Percent__c;
			unit.Terrace = projUnit.Terrace__c;
			unit.Unit_Availability = projUnit.Unit_Availability__c;
			unit.VAT = projUnit.VAT__c;
			unit.VAT_Percent = projUnit.VAT_Percent__c;
			unit.Unit_Name_Web = projUnit.Unit_Name_Web__c;
			unit.Sold_Date= projUnit.Sold_Date__c;
			unit.EPC_Rating= projUnit.EPC_Rating__c;
            unit.Region= projUnit.Region__c;

			/**************************Rooms Wrapper class*******************************/
			List<webSyncRequestWrapper.rooms> rooms = New List<webSyncRequestWrapper.rooms>();
				List<Room__c> roomList = [Select Id,CreatedById,Description__c,Dimensions__c,Dimensions_Alt__c,LastModifiedById,Reapit_Id__c,Name from Room__c WHERE Unit__c =: projUnit.Id];
			
			for(Room__c rm : roomList){
				webSyncRequestWrapper.rooms room = new webSyncRequestWrapper.rooms();
				room.Room_id = rm.Id;
			//	room.CreatedById = rm.CreatedById;
				room.Description = rm.Description__c;
				room.Dimensions = rm.Dimensions__c;
				room.Dimensions_Alt = rm.Dimensions_Alt__c;
				room.LastModifiedById = rm.LastModifiedById;
				room.Reapit_Id = rm.Reapit_Id__c;
				room.Name = rm.Name;
                rooms.add(room);
            }
            unit.rooms = rooms;
			
			
			/**************************Opportunity Wrapper class*******************************/
			List<Opportunity> oppList = [Select Id,Decoration__c,Rent_Includes__c,Price_To__c,Reservation_Fee__c,Disposal__c,Completed__c,Exchanged__c,Account_Paid__c,Tenure_Type__c,Tenure_Expiry__c,Vendor_Id__c,Agency__c,Agency_Id__c,Agreement_Expiry__c,Fee__c,Fee_Type__c,Exchanged_Company_Fee__c,Recommended_Price__c,Valuation_Price__c,Exchanged_Price__c,Exchanged_Office_Id__c,Selling_Shared_Percentage__c,Selling_Shared_Rent__c,Selling_Rent_Frequency__c,Instructed__c,Letting_Agreement_Signed__c,Available_From__c,Available_To__c,Price__c,Furnishing__c,Term__c,Status__c,Agent_Role__c,Landlord_Id__c,Works_Order_Note__c,Minimum_Term__c,Property_Manager_Id__c,Management_Company_Ids__c,Brochure_Id__c,Public_Brochure_Url__c,Qualifier__c,Management_Fee_Type__c,Management_Fee_Amount__c,Deposit_Type__c,Deposit__c,Gas__c,Gas_Company_Id__c,Gas_Meter_Point__c,Electricity_Company_Id__c,Electricity_Meter_Point__c,Water_Company_Id__c,Water_Meter_Point__c,Telephone_Company_Id__c,Internet_Company_Id__c,CableTv_Company_Id__c,Letting_Fee_Type__c,Building_Name_New__c,BuildingNumber_New__c,Adr_Line_1__c,Adr_Line_2__c,Adr_Line_3__c,Adr_Line_4__c,Post_Code__c,Country_Cod__c,Local_TimeZone__c,Latitude_Val__c,Longitude_Val__c,Letting_rent_includes__c, Record_Type_Name__c from Opportunity WHERE Unit__c =: projUnit.Id];
			
			for(Opportunity opp : oppList){
				
				if(opp.Record_Type_Name__c =='Primary Sell UK' || opp.Record_Type_Name__c =='Secondary Sell UK' || opp.Record_Type_Name__c =='Buying UK')
				{
					unit.Selling_Instructed = opp.Instructed__c;
					unit.Price = opp.Price__c;
					unit.Price_To = opp.Price_To__c;
					unit.Reservation_Fee = opp.Reservation_Fee__c;
					unit.Selling_Qualifier = opp.Qualifier__c;
					unit.Selling_Status = opp.Status__c;
					unit.Disposal = opp.Disposal__c;
					unit.Completed = opp.Completed__c;
					unit.Exchanged = opp.Exchanged__c;
					unit.Account_Paid = opp.Account_Paid__c;
					unit.Tenure_Type = opp.Tenure_Type__c;
					unit.Tenure_Expiry = opp.Tenure_Expiry__c;
					unit.Vendor_Id = opp.Vendor_Id__c;
					unit.Agency = opp.Agency__c;
					unit.Agency_Id = opp.Agency_Id__c;
					unit.Agreement_Expiry = opp.Agreement_Expiry__c;
					unit.Selling_Fee_Type = opp.Fee_Type__c;
					unit.Selling_Fee_Amount = opp.Fee__c;
					unit.Exchanged_Company_Fee = opp.Exchanged_Company_Fee__c;
					unit.Recommended_Price = opp.Recommended_Price__c;
					unit.Valuation_Price = opp.Valuation_Price__c;
					unit.Selling_Brochure_Id = opp.Brochure_Id__c;
					unit.Selling_Public_Brochure_Url = opp.Public_Brochure_Url__c;
					unit.Exchanged_Price = opp.Exchanged_Price__c;
					unit.Exchanged_Office_Id = opp.Exchanged_Office_Id__c;
					unit.Decoration = opp.Decoration__c ;
					unit.Shared_Percentage = opp.Selling_Shared_Percentage__c;
					unit.Selling_Rent = opp.Selling_Shared_Rent__c;
					unit.Selling_Rent_Frequency = opp.Selling_Rent_Frequency__c;
				}
				if(opp.Record_Type_Name__c =='Rental UK' || opp.Record_Type_Name__c =='Tenancy UK')
				{
					unit.Letting_Instructed = opp.Instructed__c;
					unit.Available_From = opp.Available_From__c;
					unit.Available_To = opp.Available_To__c;
					unit.Agreement_Signed = opp.Letting_Agreement_Signed__c;
					unit.Letting_Rent = opp.Price__c;
					unit.Letting_Rent_Frequency = opp.Selling_Rent_Frequency__c;
					unit.Letting_Rent_Includes = opp.Rent_Includes__c;
					unit.Furnishing = opp.Furnishing__c;
					unit.Term = opp.Term__c;
					unit.Letting_Status = opp.Status__c;
					unit.Agent_Role = opp.Agent_Role__c;
					unit.Landlord_Id = opp.Landlord_Id__c;
					unit.Works_Order_Note = opp.Works_Order_Note__c;
					unit.Minimum_Term = opp.Minimum_Term__c;
					unit.Property_Manager_Id = opp.Property_Manager_Id__c;
					unit.Management_Company_Ids = opp.Management_Company_Ids__c;
					unit.Letting_Brochure_Id = opp.Brochure_Id__c;
					unit.Letting_Public_Brochure_Url = opp.Public_Brochure_Url__c;
					unit.Management_Type = opp.Management_Fee_Type__c;
					unit.Management_Amount = opp.Management_Fee_Amount__c;
					unit.Letting_Fee_Type = opp.Fee_Type__c;
					unit.Letting_Fee_Amount = opp.Fee__c;
					unit.Letting_Qualifier = opp.Qualifier__c;
					unit.Has_Gas = opp.Gas__c;
					unit.Gas_Company_Id = opp.Gas_Company_Id__c;
					unit.Gas_Meter_Point = opp.Gas_Meter_Point__c;
					unit.Electricity_Company_Id = opp.Electricity_Company_Id__c;
					unit.Electricity_Meter_Point = opp.Electricity_Meter_Point__c;
					unit.Water_Company_Id = opp.Water_Company_Id__c;
					unit.Water_Meter_Point = opp.Water_Meter_Point__c;
					unit.Telephone_Company_Id = opp.Telephone_Company_Id__c;
					unit.Internet_Company_Id = opp.Internet_Company_Id__c;
					unit.CableTv_Company_Id = opp.CableTv_Company_Id__c;
					unit.Deposit_Type = opp.Deposit_Type__c;
					unit.Deposit_Amount = opp.Deposit__c;
				}
			
            }
            
            webSyncRequestWrapper.UnitAddress unitAddress = new webSyncRequestWrapper.UnitAddress();
            unitAddress.Block_Name = projUnit.BuildingName__c;
            unitAddress.Unit_Number = projUnit.BuildingNumber__c;
            unitAddress.Unit_Address_Line_1 = projUnit.Address_Line_1__c;
            unitAddress.Unit_Address_Line_2 = projUnit.Address_Line_2__c;
            unitAddress.Unit_Address_Line_3 = projUnit.Address_Line_3__c;
            unitAddress.Unit_Address_Line_4 = projUnit.Address_Line_4__c;
            unitAddress.Unit_Address_PostalCode = projUnit.Postal_Code__c;
            unitAddress.Unit_Address_CountryCode = projUnit.Country_Code__c;
          //  unitAddress.Unit_Address_StateCode = projUnit.Unit_Address__StateCode__s;
            unitAddress.Unit_Address_Latitude = projUnit.Latitude__Latitude__s;
            unitAddress.Unit_Address_Longitude = projUnit.Latitude__Longitude__s;
            unitAddress.Local_Time_Zone = projUnit.localTimeZone__c;
            unit.Address = unitAddress;
            
            //Amazon Files wrapper
            List<webSyncRequestWrapper.amazonFiles> amazonFileList = New List<webSyncRequestWrapper.amazonFiles>();
            List<Amazon_Files__c> amazonFilesList = [Select Id, Name,Is_Primary__c,Path_Url__c,EPC__c,Floor_Plan__c,
                                                     Status__c,Description__c,S3_Response__c from Amazon_Files__c 
                                                     WHERE (Unit__c =: projUnit.Id AND Status__c='Submitted')];
            for(Amazon_Files__c amzFiles : amazonFilesList){
                webSyncRequestWrapper.amazonFiles fileReq = new webSyncRequestWrapper.amazonFiles();
                fileReq.FileName = amzFiles.Name;
                fileReq.Is_Primary = amzFiles.Is_Primary__c;
                fileReq.Path_Url = amzFiles.Path_Url__c;
                fileReq.epc = amzFiles.EPC__c;
                fileReq.Floor_Plan = amzFiles.Floor_Plan__c;
                fileReq.Status = amzFiles.Status__c;
                fileReq.Description = amzFiles.Description__c;
                fileReq.S3_Response = amzFiles.S3_Response__c;
                amazonFileList.add(fileReq);
            }
            system.debug('amazonFiles'+ amazonFileList);
            unit.Amazon_Files = amazonFileList;
            unitwrapper.add(unit);
			
			
			
			
            //Project Unit Type
            string projutId = projUnit.project_unit_type__c; //Project Unit type Id
            List<Project_Unit_Type__c> projUnitType = [SELECT Id, Name,Unit_Type__c,Square_Meter_Min__c,Square_Meter_Max__c,
                                                             No_of_Available_Units__c,No_of_Sold_Units__c, Project__c,Project__r.Name FROM Project_Unit_Type__c where Id =: projutId]; // query project__c as parent value
            for(Project_Unit_Type__c ProjUType : projUnitType){
                webSyncRequestWrapper.projectUnitTypewrapper utreq = new webSyncRequestWrapper.projectUnitTypewrapper();         
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
                    webSyncRequestWrapper.projectwrapper req = new webSyncRequestWrapper.projectwrapper();         
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
                    webSyncRequestWrapper.ProjectAddress projAddress = new webSyncRequestWrapper.ProjectAddress();
                    projAddress.Project_Address_CountryCode = proj.Project_Address__CountryCode__s;
                    projAddress.Project_Address_Street = proj.Project_Address__street__s;
                    projAddress.Project_Address_City = proj.Project_Address__City__s;
                    projAddress.Project_Address_PostalCode = proj.Project_Address__PostalCode__s;
                    projAddress.Project_Address_StateCode = proj.project_Address__StateCode__s;
                    projAddress.Project_Address_Latitude = proj.Latitude__Latitude__s;
                    projAddress.Project_Address_Longitude = proj.Latitude__Longitude__s;
                    req.projectAddress = projAddress;
                    
                    
                    List<webSyncRequestWrapper.amazonFiles> projAmazonFiles = New List<webSyncRequestWrapper.amazonFiles>();
                    List<Amazon_Files__c> amazonFileslst = [Select Id, Name,Is_Primary__c,Path_Url__c,Status__c,
                                                            	   Description__c,S3_Response__c,EPC__c,Floor_Plan__c
                                                            	FROM Amazon_Files__c  where (Project_Id__c =: proj.Id AND Status__c='Submitted')];
                    for(Amazon_Files__c amzFiles : amazonFileslst){
                        webSyncRequestWrapper.amazonFiles fileReq = new webSyncRequestWrapper.amazonFiles();
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
  /*      String token  = Druce_PortalAuthentication.getToken();
        
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