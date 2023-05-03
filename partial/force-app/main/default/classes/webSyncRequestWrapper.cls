global class webSyncRequestWrapper {
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
        global List<amazonFiles> Amazon_Files;
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
      //  global string id;
        global String Reapit_Id;
		global DateTime Reapit_Created_Date;
		global DateTime Reapit_Modified_Date;
		global String Marketing_Mode;
        global String CurrencyISOCode;
		global String Alternate_Id;
        global String Area_Id;
		global String Strapline;
		global String Description;
        global String Long_Description;
		global String Local_Authority;
		global String Summary;
		global String Department_Id;
		global String Negotiator_Id;
		global Integer No_of_Bed_Rooms; //2
		global Integer Bedrooms_Max;
		global Integer Reception;
		global Integer Receptions_Max;
		global Integer No_of_Wash_Rooms;    //2
		global Integer Bathrooms_Max;
		global Decimal Number_Of_Units;
		global Decimal Parking_Spaces;
		global String Council_Tax_Band;
		global String Disabled_Portal_Ids;
		global Boolean Internet_Advertising;
		global Boolean Is_External;
		global String Viewing_Arrangements;
		global String Video_Url;
		global String Video_Caption;
		global String Video2_Url;
		global String Video2_Caption;
		global String Notes;
		global String Board_Status;
		global String Board_Notes;
		global String Featured_Image_Url;
		global String Url;
		global String Url_Caption;
		global Decimal Ground_Rent;
		global String Ground_Rent_Comment;
		global DateTime Ground_Rent_Review_Date;
		global Decimal Ground_Rent_Increase;
		global Decimal Service_Charge;
        global String Service_Charge_Comment;
		global String Board_Updated;
		global DateTime Valuation;
		global String Archived_On;
		global Boolean From_Archive;
		global String Rural;
		global String External_Area_Type;
        global Decimal External_Area_Min;
        global Decimal External_Area_Max;
        global String Internal_Area_Type;
        global Decimal Internal_Area_Min;
        global Decimal Internal_Area_Max;
		global Boolean EPC_Exempt;
		global Integer EPC_Eer;
		global Integer EPC_EerPotential;
		global Integer EPC_Eir;
		global Integer EPC_EirPotential;
		global Date Selling_Instructed;
		global Decimal Price;
		global Decimal Price_To;
		global Decimal Reservation_Fee;
		global String Selling_Qualifier;
		global String Selling_Status;
		global String Disposal;
		global DateTime Completed;
		global Date Exchanged;
		global Date Account_Paid;
		global String Tenure_Type;
		global DateTime Tenure_Expiry;
		global String Vendor_Id;
		global String Agency;
		global String Agency_Id;
		global Date Agreement_Expiry;
		global String Selling_Fee_Type;
		global Decimal Selling_Fee_Amount;
		global Decimal Exchanged_Company_Fee;
		global Decimal Recommended_Price;
		global Decimal Valuation_Price;
		global String Selling_Brochure_Id;
		global String Selling_Public_Brochure_Url;
		global Decimal Exchanged_Price;
		global String Exchanged_Office_Id;
		global String Decoration;
		global Decimal Shared_Percentage;
		global Decimal Selling_Rent;
		global String Selling_Rent_Frequency;
		global Date Letting_Instructed;
		global Date Available_From;
		global Date Available_To;
		global String Agreement_Signed;
		global Decimal Letting_Rent;
		global String Letting_Rent_Frequency;
		global String Letting_Rent_Includes;
		global String Furnishing;
		global String Term;
		global String Letting_Status;
		global String Agent_Role;
		global String Landlord_Id;
		global String Works_Order_Note;
		global Decimal Minimum_Term;
		global String Property_Manager_Id;
		global String Management_Company_Ids;
		global String Letting_Brochure_Id;
		global String Letting_Public_Brochure_Url;
		global String Management_Type;
		global Decimal Management_Amount;
		global String Letting_Fee_Type;
		global Decimal Letting_Fee_Amount;
		global String Letting_Qualifier;
		global Boolean Has_Gas;
		global String Gas_Company_Id;
		global String Gas_Meter_Point;
		global String Electricity_Company_Id;
		global String Electricity_Meter_Point;
		global String Water_Company_Id;
		global String Water_Meter_Point;
		global String Telephone_Company_Id;
		global String Internet_Company_Id;
		global String CableTv_Company_Id;
		global String Deposit_Type;
		global Decimal Deposit_Amount;
		global String Commercial;
		global String Regional;
		global String F_Type;
        global String Style;
        global String Situation;
		global String Parking;
		global String Age;
		global String Locality;
        global String Special_Features;
		global String Unmapped_Attributes;
		global Boolean Room_Details_Approved;
		global String Office_Ids;
		global DateTime Lost_Instruction_Date;
		global String Lost_Instruction_Note;
		global String Keywords;
		global String Extras_Field;
		global String E_Tag;
		global String Links;
		global String Embedded;
		global String Metadata;
		global String Reapit_Status;
        global String Unit_Id;  //12
        global String Unit_Name;    //Test
		global Decimal Unit_Price;  //12000
		global String Unit_Type;    //Available,Sold
		global String Balcony_Direction;    //South,East
		global Decimal Build_up_Area_ft;    //
		global Decimal Build_up_Area_meter; //
        global Decimal Carpet_Area_square_ft;   //
        global Decimal Carpet_Area_m_square;    //
        global Decimal Floor;   //1st
        global String Furnished_Status;
        global String Garden;
        //global String Summary;
        global Decimal Maintenance_Fee; //1
		global String Maintenance_Fee_Percent;
		global String Patio;
        global Decimal Price_Per_Square_Feet;
        global Decimal Price_Per_Square_Metre;
		global String RecordTypeId;
		global String Record_Type_Name;
		global Decimal Rent_per_Week;
		global Decimal Rent_per_Month;
        global Decimal Rental_Guarantee;    //2
        global Decimal Rental_Guarantee_Percent;
		global String Terrace;
		global String Unit_Availability;    //Available,Sold
		global Decimal VAT; //
        global Decimal VAT_Percent; //
        global String Unit_Name_Web;
        global Date Sold_Date;
		global String EPC_Rating;
        global String Project_Name;
        global String Record_Type;
        global String KeyFeatureRich;
        global String Region;

        global List<amazonFiles> Amazon_Files;
        global UnitAddress Address;
        global List<rooms> rooms;
    }   
    
    global class rooms{
        global String Room_id;
        global String CreatedById;
    //    global String CurrencyIsoCode;
        global String Description;
        global String Dimensions;
        global String Dimensions_Alt;
        global String LastModifiedById;
        global String Reapit_Id;
        global String Name;
    }
    global class UnitAddress {
        //    global String Unit_Address_City;
        global String Block_Name;
        global String Unit_Number;
        global String Unit_Address_Line_1;
        global String Unit_Address_Line_2;
        global String Unit_Address_Line_3;
        global String Unit_Address_Line_4;
        //   global String Unit_Address_Street;
        global String Unit_Address_PostalCode;
        global String Unit_Address_CountryCode;
        // global String Unit_Address_StateCode;
        global String Local_Time_Zone;
        global Decimal Unit_Address_Latitude;
        global Decimal Unit_Address_Longitude;
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
        global String FileName;
        global Boolean Is_Primary ;
        global String Path_Url;
        global Boolean epc;
        global Boolean Floor_Plan;
        global String Status;
        global String Description;
        global String S3_Response;
    }
}