global class Druce_WebPublishRequestWrapper {
    global List<projectWrapper> project;
    
    global class projectWrapper{
        global String city;
        global String country;
        global String currencyISOCode;
        global String Facilities;
        global String Ownership;
        global String Project_Id;   //98765
        global String Project_Name; //TEST POSTMAN update from Node
        global decimal Project_Area; //12000
        global String Project_Id_DB;
        global String Project_Stage;
        global String Property_Area;                
        global String Project_Summary;
        global String Property_Proj_Type;
        global Date Planned_Handover_Date;
        global String Related_Account;
        global String Sponsor_Bank;
        global String Project_Status;
        global String RecordTypeId;        
        global String Tags;
        global String UnitsAvailability;    //Available
        global Integer Units_Available; //10
        global Integer Units_Sold;  //2
        global Boolean Secondary_Property; 
        global List<projectUnitTypeWrapper> projectUnitType;
        global ProjectAddress ProjectAddress;
        global List<amazonFiles> amazonFiles;
    }
    
    global class projectUnitTypeWrapper {
        global String Unit_Type_Id; //123
        global String Unit_Type_Name;   //Test
        global String Unit_Type;    //1BR
        global Decimal Square_Meter_Min;    //12000
        global Decimal Square_Meter_Max;
        global Decimal No_of_Available_Units;
        global Decimal No_of_Sold_Units;
        global List<projectUnit> Unit;
    }
    
    global class projectUnit {
        global String Reapit_Id;
        global String Id; 
        global String Age;
        global String AlternateId;
        global String ArchivedOn;   
        global String AreaId; 
        global Date AvailableFrom;  
        global String BalconyDirection;
        global Decimal BathroomsMax;  
        //global Integer Bathrooms;cmntd  
        //global Integer Bedrooms;  cmntd
        global Decimal BedroomsMax;
        global String BlockName; 
        global String BoardNotes; 
        global String BoardStatus;
        global String BoardUpdated;
        global Decimal BuildupArea_meter; //
        global Decimal BuildupArea_ft;    //
        global Decimal CarpetAreasquare_ft;  
        global Decimal CarpetAream_square;  
        global String Commercial;
        global String CouncilTaxBand;
        global String Country;
        global String CountryCode;
        global String CreatedBy;
        global String CurrencyCode;
        global String DepartmentId;
        global String DisabledPortalIds;
        global String Embedded;
        global Decimal EPCEer;
        global Decimal EPCEerPotential;
        global Decimal EPCEir;
        global Decimal EPCEirPotential;
        global Boolean EPCExempt;
        global String EPCRating;
        global String eTag;
        global String ExternalArea;
        global Decimal ExternalAreaMax;
        global Decimal ExternalAreaMin;
        global String ExternalAreaType;
        global String ExtrasField;
        global String FeaturedImageUrl;
        global Decimal Floor;
        global Boolean FromArchive;
        global String FurnishedStatus;
        global String Garden;
        global Decimal GroundRent;
        global String GroundRentComment;
        global Decimal GroundRentIncrease;
        global DateTime GroundRentReviewDate;
        global Boolean HomeInsurance;
        global String InsuranceCompanyId;
        global Decimal InternalAreaMax;
        global Decimal InternalAreaMin;
        global String InternalAreaType;
        global Boolean InternetAdvertising;
        global Boolean IsExternal;
        global String KeyFeatures;
        global String LastModifiedBy;
        global String Links;
        global String LocalAuthority;
        global String Locality;
        //global String localTimeZone;cmntd
        global DateTime LostInstructionDate;
        global String LostInstructionNote;
        global Decimal MaintenanceFee;
        global Decimal MaintenanceFeePrcnt;
        global String MarketingMode;
        global String Metadata;
        global String NegotiatorId;
        global Decimal NoofBedrooms;
        global Decimal NoofWashrooms; // Should be Integer
        global String Notes;
        global Decimal NumberOfUnits; // Should be Integer
        global String OfficeIds;
        global String Parking;
        global Decimal ParkingSpaces;// Should be Integer
        global String Patio;
     //   global Decimal PricePerSquareFeet;
     //   global Decimal PricePerSquareMetre;
        global String ProjectName;
        //global String ProjectUnitType;cmntd
        global DateTime ReapitCreatedDate;
        global DateTime ReapitModifiedDate;
        global String ReapitStatus;
        //global String Reapit_Web_Id;cmntd
        global Decimal Reception; // Should be Integer
        global Decimal ReceptionsMax; // Should be Integer
        //global String RecordType;cmntd
        global String RecordTypeName;
        //global String Region;cmntd
        global String Regional;
        //global Decimal RentperMonth;cmntd
        //global Decimal RentperWeek;cmntd
        //global Decimal RentalGuarantee;cmntd
        //global Decimal RentalGuaranteePerecent;cmntd
     //   global String Response;
        global Boolean RoomDetailsApproved;
        global String Rural;
        global Boolean SecondaryMarket;
        global Decimal ServiceCharge;
        global String ServiceChargeComment;
        global Decimal SharedOwnershipPercentage;
        global String Situation;
        global Date SoldDate;
        global String SpecialFeatures;
        global String Strapline;
        global String Style;
        global String Summary;
        //global Date TenureExpiry; cmntd
        //global String TenureType;cmntd
        global String Terrace;
        global String Type;
        //global String UniqueName;cmntd
        //global String UnitAvailability;cmntd
        //global String UnitDBId;cmntd
        global String UnitDescription;
        global String UnitLongDescription;
        global String UnitName;
        //global String UnitNameWeb;cmntd
        global String UnitNumber;
        global Decimal UnitPrice;
        global String UnitStage;
        global String UnitType;
        global String UnmappedAttributes;
        global String URL;
        global String URLCaption;
        global DateTime Valuation;
        global Decimal VAT;
        global Decimal VATpercent;
        global String VideoCaption;
        global String VideoUrl;
        global String Video2Caption;
        global String Video2Url;
        global String ViewingArrangements;
		global List<Opportunities> Opportunities;
		global UnitAddress UnitAddress;
		global List<Rooms> Rooms;
		global List<amazonFiles> amazonFiles;
            }
    
        global class Opportunities {
					global String AccountId; 
					global Date Account_Paid; 

					global String Agency;
					global String Agency_Id;
					global String Agent_Role;
					global Date Agreement_Expiry;
					global String Agreement_Signed;
					global Date Available_From;
					global Date Available_To;
					global Boolean Booking_Fee_Paid;
					global String Brochure_Id;
					global String Budget_Max;
					global String Budget_Min;
					global Boolean Budget_Confirmed;
					global String CableTv_Company;
					global Date CloseDate;
					global Date Completed;
					global String ContractId;

					global String CountryISOCode;
					global String CreatedById;
					global String DB_Competitor;
					global String Decoration;
					global Decimal Deposit;
					global String Deposit_Type;
					global String Description;
					global Boolean Discovery_Completed;
					global String Disposal;
					global String Solicitor_Details;
					global String Electricity_Company_Id;
					global String Electricity_Meter_Point;
					global Date Exchanged;
					global Decimal Exchanged_Company_Fee;
					global String Exchanged_Office_Id;
					global Decimal Exchanged_Price;
					global Decimal ExpectedRevenue;
					global Decimal Fee;
					global String ForecastCategoryName;
					global String Furnishing;
					global boolean Gas;
					global String Gas_Company_Id;
					global String Gas_Meter_Point;
					global String Funding_mode;
					global Integer Seeing_Duration;
					global Integer shifting_time;
					global Date Instructed;
					global String Internet_Company_Id;
					global String Landlord_Id;
					global String LastModifiedById;
					global Decimal Amount;

					global String LeadSource;
					global String Letting_Agreement_Signed;
                    global String OpportunityStatus;
                    global String Fee_Type;
					//global String Letting_Brochure_Id;cmntd
					//global Integer Letting_Fee;cmntd
					//global String Letting_Fee_Type;cmntd
					//global Date Letting_Instructed;cmntd
					//global String Letting_Public_Brochure_Url;cmntd
					//global String Letting_Qualifier;cmntd
					//global String Letting_Rent_Frequency;cmntd
					//global String Letting_rent_includes;cmntd
					//global String Letting_Status;cmntd
					global String Lost_Reason;
					global String Lost_Reason_Remarks;
					global String Management_Company_Ids;
					global Integer Management_Fee_Amount;
					global String Management_Fee_Type;
					global String Minimum_Term;
					global String NextStep;
					global String Office_ID;
					global Decimal CurrencyIsoCode;
					global String Name;
					global String OwnerId;
					global String RecordTypeId;
					global Integer IqScore;

					global Decimal Price;
					global String Pricebook;
					global Decimal Price_To;
					global String CampaignId;
					global String Primary_Contact;
					global Boolean IsPrivate;
					global Decimal Probability;
					global String Project_Id;
					global String Project_Interested_In;
					global String Property_Manager_Id;
					global String  Public_Brochure_Url;
					global String Qualifier;
					global Integer TotalOpportunityQuantity;
					//global String Reapit_ID;cmntd
					global Decimal Recommended_Price;
					//global String Region;cmntd
					global String Rent_Includes;
					global Decimal Reservation_Fee;
					global Boolean ROI_Analysis_Completed;
					//global String Sales_Process;cmntd
					global Boolean SecondaryMarket;
					//global Decimal Selling_Fee_Amount;
					//global String Selling_fee_type;
					global String Selling_Rent_Frequency;
					global Decimal Selling_Shared_Percentage;
					global Decimal Selling_Shared_Rent;
					global String Solicotor_Details;
					global String Square_Meter_Max;
					global String Square_Meter_Min;
					global String StageName;
					global String SyncedQuoteId;
					global String Telephone_Company_Id;
					global Date Tenure_Expiry;
					global String Tenure_Type;
					global String Term;
					global String Type;
					global String Unit;
					global String UnitTypePreferences;
					global Decimal Valuation_Price;
					global String Vendor_Id;
					global Boolean Visit_required;
					global String Water_Company_Id;
					global String Water_Meter_Point;
					global String Works_Order_Note;
					//global Decimal Rent;cmntd
					//global String Building_Name;cmntd
					//global String BuildingNumber;cmntd
					//global String Selling_Status;cmntd
					//global String Address_Line_1;cmntd
					//global String Address_Line_2;cmntd
					//global String Address_Line_3;cmntd
					//global String Address_Line_4;cmntd
					//global String Post_Code;cmntd
					//global String Country_Code;cmntd
					//global String Local_TimeZone;cmntd
					//global Decimal Longitude;cmntd
					//global Decimal Latitude;cmntd
            }
			global class Rooms {
            global String Id;
            global String CreatedById;
         //   global String CurrencyCode;
            global String Description;
            global String Dimensions;
            global String DimensionsAlt;
            global String LastModifiedById;
            global String Reapit_Id;
            global String Name;
        }

            global class UnitAddress {
            global String buildingName;
            global String buildingNumber;
            global String line1;
            global String line2;
            global String line3;
            global String line4;
            global String postcode;
            global String countryId;
            global String localTimeZone; //Date Time
            global Decimal latitude;
            global Decimal longitude;
        }
        
        
        global class ProjectAddress {
            global String Project_Address_CountryCode;
            global String Project_Address_City;
            global String Project_Address_Street;
            global String Project_Address_PostalCode;
            global String Project_Address_StateCode;
            global Decimal Project_Address_Latitude;
            global Decimal Project_Address_Longitude;
        }
        
        global class amazonFiles{
            global String AmazonFileName;
            global String Id;
			global String CreatedBy;
		//	global String CurrencyCode;
			global String Description;
			global Boolean EPC;
			global String FileType;
			global Boolean FloorPlan;
			global String ImageName;
			global Boolean IsPrimary;
			global String LastModifiedBy;
			global String PathUrl;
			global String ReapitImageUrl;
			global String S3Response;
			global String S3_Response_Id;
			global String Status;
			global String WebsiteDBId;
        }
}