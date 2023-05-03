@RestResource(urlMapping='/Cases/*')
global with sharing class ProjectAPI {
   /* @HttpGet
    global static List<Project__c> getProjectById() {
        RestRequest request = RestContext.request;
        Map<String,String> paramMap = RestContext.request.params;
        String recordTypeName = paramMap.get('recordType');
        System.debug('recordTypeName>>' +recordTypeName);
        List<Project__c> result =  [SELECT area__c,RecordType.name,area_guide__c,avaialble_from__c,Bathrooms__c,Bedrooms__c,City__c,Country__c,CreatedById,CurrencyIsoCode,dep__c,description__c,excerpt__c,Facilities__c,File_URL__c,Floorplans__c,furnishings__c,Hot__c,Image_URL__c,LastModifiedById,Lat__c,lng__c,Outdoorarea__c,OwnerId,Ownership__c,Parking__c,Pdf_Details__c,Planned_Handover_Date__c,Price__c,Project_Address__c,Project_Id_DB__c,Name,Project_Stage__c,Project_Summary__c,Property_Type__c,Property_Area__c,Property_Name__c,Property_Proj_Type__c,Reapit_date__c,Reapit_Epcs__c,Reapit_Featured__c,Reapit_internet_adv__c,Reapit_Type__c,Receptions__c,RecordTypeId,Related_Account__c,S3_File_Url__c,Seo_Address__c,Seo_Desc__c,Seo_Prefix__c,Seo_Url__c,Sponsor_Bank__c,Sq_ft__c,Project_Status__c,Status__c,Tags__c,Tenure__c,Tour_Caption__c,Tour_Caption_2__c,UnitsAvailability__c,Units_Available__c,Units_Sold__c,Virtual_Tour__c,Virtual_Tour_2__c
                        FROM Project__c
                        WHERE recordtypeid in (Select Id From RecordType where sobjecttype = 'Project__c' and name =:recordTypeName) ];
       
        system.debug('result  '+result);
       // system.debug('result primary  '+result[0].recordtype.name);
        if(result.size() >0){
        if(result[0].recordtype.name == 'Primary Property'){
            List<Project__c> primaryresult =  [SELECT area__c,RecordType.name,area_guide__c,avaialble_from__c,Bathrooms__c,Bedrooms__c,City__c,Country__c,CreatedById,CurrencyIsoCode,dep__c,description__c,excerpt__c,Facilities__c,File_URL__c,Floorplans__c,furnishings__c,Hot__c,Image_URL__c,LastModifiedById,Lat__c,lng__c,Outdoorarea__c,OwnerId,Ownership__c,Parking__c,Pdf_Details__c,Planned_Handover_Date__c,Price__c,Project_Address__c,Project_Id_DB__c,Name,Project_Stage__c,Project_Summary__c,Property_Type__c,Property_Area__c,Property_Name__c,Property_Proj_Type__c,Reapit_date__c,Reapit_Epcs__c,Reapit_Featured__c,Reapit_internet_adv__c,Reapit_Type__c,Receptions__c,RecordTypeId,Related_Account__c,S3_File_Url__c,Seo_Address__c,Seo_Desc__c,Seo_Prefix__c,Seo_Url__c,Sponsor_Bank__c,Sq_ft__c,Project_Status__c,Status__c,Tags__c,Tenure__c,Tour_Caption__c,Tour_Caption_2__c,UnitsAvailability__c,Units_Available__c,Units_Sold__c,Virtual_Tour__c,Virtual_Tour_2__c, (Select Name,Unit_Type__c,No_of_Sold_Units__c,No_of_Available_Units__c,Square_Meter_Min__c,Square_Meter_Max__c,UnitsAvailability__c from Project_Unit_Types__r ) FROM Project__c WHERE recordtypeid in (Select Id From RecordType where sobjecttype = 'Project__c' and name =:recordTypeName)
];
            system.debug('Inside if Primary property >>');
               return primaryresult;
        }
     
        else{
                        system.debug('Inside else Primary property >>');

               return result;
        }
        }
        else{
            List<Project__c> allresult =  [SELECT area__c,RecordType.name,area_guide__c,avaialble_from__c,Bathrooms__c,Bedrooms__c,City__c,Country__c,CreatedById,CurrencyIsoCode,dep__c,description__c,excerpt__c,Facilities__c,File_URL__c,Floorplans__c,furnishings__c,Hot__c,Image_URL__c,LastModifiedById,Lat__c,lng__c,Outdoorarea__c,OwnerId,Ownership__c,Parking__c,Pdf_Details__c,Planned_Handover_Date__c,Price__c,Project_Address__c,Project_Id_DB__c,Name,Project_Stage__c,Project_Summary__c,Property_Type__c,Property_Area__c,Property_Name__c,Property_Proj_Type__c,Reapit_date__c,Reapit_Epcs__c,Reapit_Featured__c,Reapit_internet_adv__c,Reapit_Type__c,Receptions__c,RecordTypeId,Related_Account__c,S3_File_Url__c,Seo_Address__c,Seo_Desc__c,Seo_Prefix__c,Seo_Url__c,Sponsor_Bank__c,Sq_ft__c,Project_Status__c,Status__c,Tags__c,Tenure__c,Tour_Caption__c,Tour_Caption_2__c,UnitsAvailability__c,Units_Available__c,Units_Sold__c,Virtual_Tour__c,Virtual_Tour_2__c, (Select Name,Unit_Type__c,No_of_Sold_Units__c,No_of_Available_Units__c,Square_Meter_Min__c,Square_Meter_Max__c,UnitsAvailability__c from Project_Unit_Types__r ) FROM Project__c WHERE recordtypeid in (Select Id From RecordType where sobjecttype = 'Project__c')
];
            system.debug('Inside if allS property >>');
               return allresult;
        }
            
    }*/
      
}