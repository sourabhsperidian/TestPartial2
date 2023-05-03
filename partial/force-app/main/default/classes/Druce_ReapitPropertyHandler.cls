public class Druce_ReapitPropertyHandler {
    public static void propertySync(string propertystring){
        ReapitUnitWrapper requestWrapper = (ReapitUnitWrapper)JSON.deserialize(propertystring, ReapitUnitWrapper.class); 
        List<Unit__c> lstUnit = new List<Unit__c>();
        Opportunity oppLetting = new Opportunity();
        Opportunity oppSelling = new Opportunity();
        Map<String, Opportunity> mapletopp = new Map<String, Opportunity>();
        Map<String, Opportunity> mapsellopp = new Map<String, Opportunity>();
        List<Map<String, Room__c>> maproomLists = new List<Map<String, Room__c>>();
        
        if(requestWrapper.embedded != NULL){
            ReapitUnitWrapper.embedded exnewVar = requestWrapper.embedded;
            System.debug('id :'+requestWrapper.embedded.id);
            Unit__c unit = new Unit__c();
            // Check Reapit Id not exists in System then assign Unit Type
            List<Unit__c> unitList = [SELECT Id FROM Unit__c WHERE Reapit_Id__c =: exnewVar.Id ]; 
            if(unitList.isEmpty() ){
                unit.Project_Unit_Type__c = 'a070T000003NSzSQAW';
            }  
            
            String posString = exnewVar.address.postcode;
            unit.Name = exnewVar.address.line1 + ' ' + exnewVar.address.line2 + ' ' +exnewVar.address.line3 + ' ' +exnewVar.address.line4 + ' ' +
                posString;
            unit.Reapit_Id__c = exnewVar.Id;
            unit.RecordTypeId = Druce_Constants.UNIT_UK;
            unit.Reapit_Created_Date__c = exnewVar.created;
            unit.Reapit_Modified_Date__c = exnewVar.modified;
            unit.Reapit_Marketing_Mode__c = exnewVar.marketingMode;
            unit.CurrencyIsoCode = exnewVar.currencyCode;
            unit.Reapit_Alternate_Id__c = exnewVar.alternateId;
            unit.Reapit_Area_Id__c = exnewVar.areaId;
            unit.Unit_Description__c = exnewVar.description;
            unit.Unit_Long_Description__c = exnewVar.longDescription;
            unit.Local_Authority__c = exnewVar.localAuthorityCompanyId;
            //unit.Summary__c = exnewVar.summary;KeyFeatureRich__c
            unit.Reapit_Department_Id__c = exnewVar.departmentId;
            unit.Reapit_Negotiator_Id__c = exnewVar.negotiatorId;
            unit.No_of_Bedrooms__c = exnewVar.bedrooms;
            unit.Bedrooms_Max__c = exnewVar.bedroomsMax;
            unit.Reception__c = exnewVar.receptions;
            unit.Receptions_Max__c = exnewVar.receptionsMax;
            unit.No_of_Washrooms__c	 = exnewVar.bathrooms;
            unit.Bathrooms_Max__c = exnewVar.bathroomsMax;
            unit.Number_Of_Units__c = exnewVar.numberOfUnits;
            unit.Parking_Spaces__c = exnewVar.parkingSpaces;
            unit.Council_Tax_Band__c = exnewVar.councilTax;
            unit.Reapit_Disabled_Portal_Ids__c = String.valueOf(exnewVar.disabledPortalIds);
            unit.Reapit_Internet_Advertising__c = exnewVar.internetAdvertising;
            unit.Is_External__c = exnewVar.isExternal;
            unit.Viewing_Arrangements__c = exnewVar.viewingArrangements;
            unit.Video_Url__c = exnewVar.videoUrl;
            unit.Video_Caption__c = exnewVar.videoCaption;
            unit.Video2Url__c = exnewVar.video2Url;
            unit.Video2Caption__c = exnewVar.video2Caption;
            unit.Notes__c = exnewVar.notes;
            unit.Board_Status__c = exnewVar.boardStatus;
            unit.Board_Notes__c = exnewVar.boardNotes;
            unit.Featured_Image_Url__c = exnewVar.featuredImageUrl;
            unit.URL__c = exnewVar.url;
            unit.URL_Caption__c = exnewVar.urlCaption;
            unit.Ground_Rent__c = exnewVar.groundRent;
            unit.Ground_Rent_Comment__c = exnewVar.groundRentComment;
            unit.Ground_Rent_Review_Date__c = exnewVar.groundRentReviewDate;
            unit.Ground_Rent_Increase__c = exnewVar.groundRentIncrease;
            unit.Service_Charge__c = exnewVar.serviceCharge;
            unit.Service_Charge_Comment__c = exnewVar.serviceChargeComment;
            unit.Board_Updated__c = exnewVar.boardUpdated;
            unit.Valuation__c = exnewVar.valuation;
            unit.Archived_On__c = exnewVar.archivedOn;
            unit.From_Archive__c = exnewVar.fromArchive;
            unit.Rural__c = String.valueOf(exnewVar.rural);
            if(exnewVar.externalArea !=null){
                unit.External_Area_Type__c = exnewVar.externalArea.type;
                unit.External_Area_Min__c = exnewVar.externalArea.min;
                unit.External_Area_Max__c = exnewVar.externalArea.max;
            }
            if(exnewVar.internalArea !=null){
                unit.Internal_Area_Type__c = exnewVar.internalArea.type;
                unit.Internal_Area_Min__c = exnewVar.internalArea.min;
                unit.Internal_Area_Max__c = exnewVar.internalArea.max;
            }
            if(exnewVar.epc !=null){
                //   unit.EPC__c = String.valueOf(exnewVar.epc);
                unit.EPC_Exempt__c = exnewVar.epc.exempt;
                unit.EPC_Eer__c = exnewVar.epc.eer;
                unit.EPC_Eer_Potential__c = exnewVar.epc.eerPotential;
                unit.EPC_Eir__c = exnewVar.epc.eir;
                unit.EPC_Eir_Potential__c = exnewVar.epc.eirPotential;  
            }
            //unit.Commercial__c = exnewVar.commercial;
            unit.Regional__c = exnewVar.regional;
            for(String type: exnewVar.type){
                unit.Type__c = pickVal(unit.Type__c,type);
            }
            for(String style: exnewVar.style)
            {
                unit.Style__c = pickVal(unit.Style__c ,style);
            }
            for(String situat: exnewVar.situation)
                unit.Situation__c = pickVal(unit.Situation__c ,situat);
            
            for(String park: exnewVar.parking){
                unit.Parking__c = pickVal(unit.Parking__c ,park);
            }
            for(String age: exnewVar.age){
                unit.Age__c = pickVal(unit.Age__c ,age);  
            }                  
            for(String locality: exnewVar.locality)
                unit.Locality__c = pickVal(unit.Locality__c ,locality);
            for(String spcFeatr: exnewVar.specialFeatures)
                unit.Special_Features__c = pickVal(unit.Special_Features__c ,spcFeatr);
            
            unit.KeyFeatureRich__c = exnewVar.summary;
            unit.Unmapped_Attributes__c = String.valueOf(exnewVar.unmappedAttributes);
            unit.Room_Details_Approved__c = exnewVar.roomDetailsApproved;
            
            for(String officeIds: exnewVar.officeIds)
                unit.Office_Ids__c = pickVal(unit.Office_Ids__c ,officeIds);
            
            unit.Lost_Instruction_Date__c = exnewVar.lostInstructionDate;
            unit.Lost_Instruction_Note__c = exnewVar.lostInstructionNote;
            //unit.Extras_Field__c = String.valueOf(exnewVar.extrasField);
            
            unit.eTag__c = String.valueOf(exnewVar.eTag);
            unit.Unit_Number__c = exnewVar.address.buildingNumber;
            unit.Block_Name__c = exnewVar.address.buildingName;
            if(exnewVar.address.line3!= null)
                unit.Unit_Address__City__s = exnewVar.address.line2 + ' ' + exnewVar.address.line3;
            else unit.Unit_Address__City__s = exnewVar.address.line2;
            
            if(exnewVar.address.line4!= null)
                unit.Unit_Address__Street__s = exnewVar.address.line1 + ' ' +exnewVar.address.line4;
            else
                unit.Unit_Address__Street__s = exnewVar.address.line1;
            unit.Unit_Address__PostalCode__s = exnewVar.address.postcode;
            unit.Unit_Address__CountryCode__s = exnewVar.address.countryId;
            /*unit.Unit_Address__Latitude__s = exnewVar.address.geolocation.latitude;
unit.Latitude__Latitude__s = exnewVar.address.geolocation.latitude;
unit.Latitude__Longitude__s = exnewVar.address.geolocation.longitude;
unit.Unit_Address__Longitude__s	 = exnewVar.address.geolocation.longitude;*/
            unit.localTimeZone__c = exnewVar.address.localTimeZone;
            
            if(exnewVar.rooms != NULL){
                for( ReapitUnitWrapper.rooms room : exnewVar.rooms){
                    Room__c rm = new Room__c();
                    Map<String, Room__c> maproom = new Map<String, Room__c>();
                    rm.Reapit_Id__c = unit.Reapit_Id__c;
                    rm.Name = room.name;
                    rm.Dimensions__c = room.dimension;
                    rm.Dimensions_Alt__c = room.dimensionsAlt;
                    rm.Description__c = room.description;
                    maproom.put(unit.Reapit_Id__c,rm);
                    maproomLists.add(maproom);
                }
            }
            /////////////////////////////////////////////////////////////////////
            
            ReapitunitWrapper.letting lettingWrap = new ReapitunitWrapper.letting();
            lettingWrap = exnewVar.letting;
            //Opportunity oppLetting = new Opportunity();
            
            if(lettingWrap != null){
                oppLetting.RecordTypeId = Druce_Constants.OppourtnityLetting;
                oppLetting.Reapit_ID__c = unit.Reapit_Id__c;
                oppLetting.Letting_Instructed__c = lettingWrap.instructed;
                oppLetting.Available_From__c = lettingWrap.availableFrom;
                oppLetting.Available_To__c = lettingWrap.availableTo;
                oppLetting.Rent__c = lettingWrap.rent;
                oppLetting.Letting_Rent_Frequency__c = lettingWrap.rentFrequency;
                if(lettingWrap.rentFrequency == 'monthly'){
                    unit.Rent_per_Month__c = lettingWrap.rent;  
                }
                if(lettingWrap.rentFrequency == 'weekly'){
                    unit.Rent_per_Week__c = lettingWrap.rent;                    
                }
                for(String furnishing: lettingWrap.furnishing){
                    oppLetting.Furnishing__c = pickVal(oppLetting.Furnishing__c ,furnishing);
                }
                
                oppLetting.Term__c = lettingWrap.term;
                oppLetting.Letting_Status__c = lettingWrap.Status;
                unit.Reapit_Status__c = lettingWrap.Status;
                oppLetting.Agent_Role__c = lettingWrap.agentRole;
                oppLetting.Landlord_Id__c = lettingWrap.landlordId;
                oppLetting.Works_Order_Note__c = lettingWrap.worksOrderNote;
                oppLetting.Minimum_Term__c = lettingWrap.minimumTerm;
                oppLetting.Property_Manager_Id__c = lettingWrap.propertyManagerId;
                oppLetting.Letting_Status__c = lettingWrap.Status;
                unit.Unit_Availability__c = lettingWrap.Status;
                if(lettingWrap.managementCompanyIds !=null){
                    for(String mgComp: lettingWrap.managementCompanyIds){
                        oppLetting.Management_Company_Ids__c = pickVal(oppLetting.Management_Company_Ids__c ,mgComp);
                    }
                }
                oppLetting.Brochure_Id__c = lettingWrap.brochureId;
                oppLetting.Public_Brochure_Url__c = lettingWrap.publicBrochureUrl;
                if(lettingWrap.managementFee!=null){
                    oppLetting.Management_Fee_Amount__c = lettingWrap.managementFee.amount;
                }
                if(lettingWrap.lettingFee!=null){
                    oppLetting.Letting_Fee__c = lettingWrap.lettingFee.amount;
                 //   oppLetting.Letting_Fee_Type__c = lettingWrap.lettingFee.type;
                }
                oppLetting.Letting_Qualifier__c = lettingWrap.qualifier;
                if(lettingWrap.deposit!=null){
                    oppLetting.Deposit_Type__c = lettingWrap.deposit.type;
                    oppLetting.Deposit__c = lettingWrap.deposit.amount;
                }
                oppLetting.Gas__c = lettingWrap.utilities.hasGas;
                oppLetting.Gas_Company_Id__c = lettingWrap.utilities.gasCompanyId;
                oppLetting.Gas_Meter_Point__c = lettingWrap.utilities.gasMeterPoint;
                oppLetting.Electricity_Company_Id__c = lettingWrap.utilities.electricityCompanyId;
                oppLetting.Electricity_Meter_Point__c = lettingWrap.utilities.electricityMeterPoint;
                oppLetting.Internet_Company_Id__c = lettingWrap.utilities.internetCompanyId;
                oppLetting.Water_Meter_Point__c = lettingWrap.utilities.waterMeterPoint;
                oppLetting.Water_Company_Id__c = lettingWrap.utilities.waterCompanyId;
                oppLetting.CableTv_Company_Id__c = lettingWrap.utilities.cableTvCompanyId;
                oppLetting.Telephone_Company_Id__c = lettingWrap.utilities.telephoneCompanyId;
                if(lettingWrap.utilities!=null){
                    unit.Gas__c = lettingWrap.utilities.hasGas;
                    unit.Gas_Company_Id__c = lettingWrap.utilities.gasCompanyId;
                    unit.Gas_Meter_Point__c = lettingWrap.utilities.gasMeterPoint;
                    unit.Electricity_Company_Id__c = lettingWrap.utilities.electricityCompanyId;
                    unit.Electricity_Meter_Point__c = lettingWrap.utilities.electricityMeterPoint;
                    unit.Water_Company_Id__c = lettingWrap.utilities.waterCompanyId;
                    unit.Water_Meter_Point__c = lettingWrap.utilities.waterMeterPoint;
                    unit.Telephone_Company_Id__c = lettingWrap.utilities.telephoneCompanyId;
                    unit.Internet_Company_Id__c = lettingWrap.utilities.internetCompanyId;
                    unit.CableTv_Company_Id__c = lettingWrap.utilities.cableTvCompanyId;
                }
                oppLetting.Office_ID__c = exnewVar.officeIds[0];
            }
            
            ReapitunitWrapper.selling sellingWrap = new ReapitunitWrapper.selling();
            sellingWrap = exnewVar.selling;
            
            //Opportunity oppSelling = new Opportunity();
            if(sellingWrap!=null){
                oppSelling.Name = unit.Name;
                oppSelling.StageName = 'Indicated Interest';
                oppSelling.CloseDate = System.today() +180;
                oppSelling.Reapit_Id__c = unit.Reapit_Id__c;
                oppSelling.RecordTypeId = Druce_Constants.OppourtnitySecselling;
                oppSelling.Instructed__c = sellingWrap.instructed;
                unit.Unit_Price__c = sellingWrap.price;
                oppSelling.Price__c = sellingWrap.price;
                oppSelling.Price_To__c = sellingWrap.priceTo;
                oppSelling.Reservation_Fee__c = sellingWrap.reservationFee;
                oppSelling.Qualifier__c = sellingWrap.qualifier;
          //      oppSelling.Selling_Status__c = sellingWrap.status;
                unit.Unit_Availability__c = sellingWrap.Status;
                oppSelling.Disposal__c = sellingWrap.disposal;
                oppSelling.Completed__c = sellingWrap.completed;
                oppSelling.Exchanged__c = sellingWrap.exchanged;
                oppSelling.Account_Paid__c = sellingWrap.accountPaid;
                oppSelling.Vendor_Id__c = sellingWrap.vendorId;
                oppSelling.Agency__c = sellingWrap.agency;
                oppSelling.Agency_Id__c = sellingWrap.agencyId;
                oppSelling.Agreement_Expiry__c = sellingWrap.agreementExpiry;
                if(sellingWrap.fee!=null){
                  //  oppSelling.Fee__c = sellingWrap.fee.amount;
                }
                oppSelling.Exchanged_Company_Fee__c = sellingWrap.exchangedCompanyFee;
                oppSelling.Recommended_Price__c = sellingWrap.recommendedPrice;
                oppSelling.Valuation_Price__c = sellingWrap.valuationPrice;
                oppSelling.Brochure_Id__c = sellingWrap.brochureId;
                oppSelling.Public_Brochure_Url__c = sellingWrap.publicBrochureUrl;
                oppSelling.Exchanged_Price__c = sellingWrap.exchangedPrice;
                oppSelling.Exchanged_Office_Id__c = sellingWrap.exchangedOfficeId;
                oppSelling.Decoration__c = String.valueOf(sellingWrap.decoration);
                oppSelling.Office_ID__c = exnewVar.officeIds[0];
                if(sellingWrap.sharedOwnership!=null){
                    oppSelling.Selling_Shared_Percentage__c = sellingWrap.sharedOwnership.sharedPercentage;
                    oppSelling.Selling_Shared_Rent__c = sellingWrap.sharedOwnership.rent;
                    oppSelling.Selling_Rent_Frequency__c = sellingWrap.sharedOwnership.rentFrequency;
                    
                }
            }
            
            if(exnewVar.marketingMode == 'letting'){
                //unit.RecordTypeId = Druce_Constants.RENTAL_UK;
                mapletopp.put(unit.Reapit_Id__c, oppLetting );
            }
            else if(exnewVar.marketingMode == 'selling' && exnewVar.officeIds[0] == 'LNH'){
                //unit.RecordTypeId = Druce_Constants.PRIMARY_UK;
                unit.Secondary_Market__c = False;
                oppSelling.RecordTypeId = Druce_Constants.Oppourtnityselling;
                mapsellopp.put(unit.Reapit_Id__c, oppselling);
            }
            else if(exnewVar.marketingMode == 'sellingAndLetting'){
                mapsellopp.put(unit.Reapit_Id__c, oppselling);
                mapletopp.put(unit.Reapit_Id__c,oppletting );
            }
            else if(exnewVar.marketingMode == 'selling' && exnewVar.officeIds[0] != 'LNH'){
                //unit.RecordTypeId = Druce_Constants.SECONDARY_UK;
                mapsellopp.put(unit.Reapit_Id__c, oppselling);
            }
            //unitIds.add(exnewVar.Id);
            lstUnit.add(unit);            
        }
        List<Opportunity> oppLists = new List<Opportunity>();
        //List<Selling__c> lstSellings = new List<Selling__c>();
        //List<Letting__c> lstLettings = new List<Letting__c>();
        List<Room__c> lstRooms = new List<Room__c>();
        Set<String> unitids = new Set<String>();
        if(!lstUnit.isEmpty()){
            upsert lstUnit Reapit_Id__c;
            for(Unit__c unit :lstUnit){
                unitids.add(unit.Id);
                if(mapsellopp.containsKey(unit.Reapit_Id__c)){
                    Opportunity oppsellid = mapsellopp.get(unit.Reapit_Id__c);
                    oppSelling.Unit__c = unit.Id;
                    oppLists.add(oppsellid);
                    //Selling__c sellings = mapSellings.get(unit.Reapit_Id__c);
                    //sellings.Unit__c = unit.Id;
                    //lstSellings.add(sellings);
                }
                
                if(mapletopp.containsKey(unit.Reapit_Id__c)){
                    Opportunity oppletid = mapletopp.get(unit.Reapit_Id__c);
                    oppLetting.Unit__c = unit.Id;
                    oppLists.add(oppletid);					
                    //Letting__c letting = mapLettings.get(unit.Reapit_Id__c);
                    //letting.Unit__c = unit.Id;
                    //lstLettings.add(letting);
                } 
                for(Map<String, Room__c> mapRoom: maproomLists){
                    if(mapRoom.containsKey(unit.Reapit_Id__c)){
                        Room__c room = mapRoom.get(unit.Reapit_Id__c);
                        room.Unit__c = unit.Id;
                        lstRooms.add(room);
                    }
                }                    
            }
             if(!lstRooms.isEmpty()){
                upsert lstRooms Reapit_Id__c;
            }
            if(!oppLists.isEmpty()){
                upsert oppLists Reapit_Id__c;
            }
            // if(!lstLettings.isEmpty()){
            //     upsert lstLettings Reapit_Id__c;
            // }
        }
        ///////////////////////////////////////////////////////////////////
        Druce_ReapitResponse.response response = new Druce_ReapitResponse.response();
        Druce_ReapitResponse resWrapper = new Druce_ReapitResponse();
        List<Druce_ReapitResponse.results> resultList = new List<Druce_ReapitResponse.results>();
        Druce_ReapitResponse.results result = new Druce_ReapitResponse.results();
        result.message = 'Unit successfully published into salesforce';
        resultList.add(result);
        response.results = resultList;
        response.Status = 'Success';
        response.status_code = '200';
        
        resWrapper.response = response;
        system.debug('---->');
        Druce_SecondaryPropertyAPI.doPostCallout(unitIds);
        // responseString  = JSON.serialize(resWrapper);
        //res.addHeader('Content-Type', 'application/json'); 
        
        //res.responseBody = Blob.valueOf(responseString);
        
    }
    public static string pickVal(String unitRecord ,String St){
        if(st!=null){
            if(unitRecord !=null)
                unitRecord = unitRecord  + ';' + St; 
            else
                unitRecord = St;}
        return unitRecord;
    }
}