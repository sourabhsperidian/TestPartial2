global class Druce_ProjectRequestWrapper {
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
        global String Reapit_Id; 
        global String Reapit_Status;
        global String Unit_Id;  //12
        global String Unit_Name;    //Test
        global String Unit_Availability;    //Available,Sold
        global String Unit_Type;    //Available,Sold
        global String CurrencyISOCode;
        global Decimal Unit_Price;  //12000
        global String Block_Name;   //Block A
        global Decimal Floor;   //1st
        global String Unit_Number;  //101
        global Integer No_of_Bed_Rooms; //2
        global Integer No_of_Wash_Rooms;    //2
        global String Balcony_Direction;    //South,East
        global Decimal Build_up_Area_meter; //
        global Decimal Build_up_Area_ft;    //
        global Decimal Carpet_Area_square_ft;   //
        global Decimal Carpet_Area_m_square;    //
        global Decimal VAT; //
        global Decimal VAT_Percent; //
        global Decimal Maintenance_Fee; //1
        global Decimal Rental_Guarantee;    //2
        global Decimal Rental_Guarantee_Percent;
        global String Council_Tax_Band;
        global String EPC_Rating;
        global String Furnished_Status;
        global String Garden;
        global String KeyFeatureRich;
        global String Local_Authority;
        global String Maintenance_Fee_Percent;
        global String Parking;
        global String Patio;
        global Decimal Price_Per_Square_Feet;
        global Decimal Price_Per_Square_Metre;
        global String Project_Name;
        global Integer Reception;
        global String Record_Type;
        global String Record_Type_Name;
        global String RecordTypeId;
        global Decimal Rent_per_Month;
        global Decimal Rent_per_Week;    
        global String Tenure_Type;
        global String Terrace;
        global String Term;        
        global String Description;
        global String Long_Description;
        global String Summary;
        global String Unit_Name_Web;
        global String F_Type;
        global String Style;
        global String Situation;
        global String Locality;
        global String Special_Features;
        global String Office_Ids;
        global Decimal Service_Charge;
        global String Service_Charge_Comment;
        global String Age;
        global Date Available_From;
        global Date Sold_Date;
        global Boolean Internet_Advertising;
        global String External_Area;
		global String External_Area_Type;
        global Decimal External_Area_Min;
        global Decimal External_Area_Max;
        global String Internal_Area;
        global String Internal_Area_Type;
        global Decimal Internal_Area_Min;
        global Decimal Internal_Area_Max;
        global Integer EPC_Eer;

        // global String KeyFeatureRich;
        global List<amazonFiles> Amazon_Files;
        global UnitAddress Address;
    }    
    global class UnitAddress {
        global String Unit_Address_CountryCode;
        global String Unit_Address_City;
        global String Unit_Address_Street;
        global String Unit_Address_PostalCode;
        global String Unit_Address_StateCode;
        global Decimal Unit_Address_Latitude;
        global Decimal Unit_Address_Longitude;
        global String Unit_Address_Line_1;
        global String Unit_Address_Line_2;
        global String Unit_Address_Line_3;
        global String Unit_Address_Line_4;
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