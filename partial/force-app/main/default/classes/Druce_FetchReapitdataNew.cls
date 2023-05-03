global class Druce_FetchReapitdataNew implements Queueable, Database.AllowsCallouts{
    
    public Integer pageNo = 1;
    public String httpresponse;
    public String reqpathUrl;
    public String url;
    
    
     public  Druce_FetchReapitdataNew(Integer pageNo, String url)
    {
        this.pageNo = pageNo;
        this.url = url;
    }
       //Method for MultiPicklist
    public static string pickVal(String unitRecord ,String St){
        if(st!=null){
         if(unitRecord !=null)
           unitRecord = unitRecord  + ';' + St; 
                         else
                             unitRecord = St;}
        	return unitRecord;
        }
    
    public void execute(QueueableContext context) {
    	// tries to make the REST call
    	try{
            Http h = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            //String path = '/properties?pageSize=100&pageNumber=87';
            String path = '?client_id=3ohfvftvn15aap62di1nksaglu&grant_type=client_credentials';
            request.setEndpoint('callout:Reapit_API');
            String payLoad = 'client_id=3ohfvftvn15aap62di1nksaglu&grant_type=client_credentials';
			request.setBody(payLoad);
           // request.setBody(body);
            //request.setEndpoint('https://platform.reapit.cloud/properties?pageSize=100&pageNumber=87');
            request.setTimeout(60000);
            HttpResponse response = h.send(request);
    		system.debug('Response Auth ::'+response);

            if(response.getStatusCode() == 200){
                system.debug('response body :'+response.getBody());
                
                DXF_ReapitAPIClass.wrapperAuth wrap = new DXF_ReapitAPIClass.wrapperAuth();
                
                wrapperAuth ex = (wrapperAuth)JSON.deserialize(response.getBody(), wrapperAuth.class);
                system.debug(':::'+ex.access_token);

                Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
               // String reqpathUrl = '?pageSize=100&pageNumber='+pageNo;&sellingstatus=forSale&pageNumber='+pageNo;
               // String reqpathUrl = '/properties?pageSize=10';
             // 	String sellUrl = '/properties?Id=LNH230009';
                String lettingUrl = '/properties?Id=BGO230041';
              	String sellUrl = '/properties?pageSize=25&internetAdvertising=false&marketingMode=selling&pageNumber='+pageNo; //&pageNumber='+pageNo;
              //  String lettingUrl = '/properties?pageSize=12&internetAdvertising=true&marketingMode=letting&lettingstatus=tenancycurrent&pageNumber='+pageNo;//&pageNumber='+pageNo;
                String sellLetUrl = '/properties?pageSize=19&internetAdvertising=true&marketingMode=selling&sellingstatus=underoffer&pageNumber='+pageNo;
                if(url == 'selling'){
                    reqpathUrl =sellUrl;
                }else 
                if(url == 'letting') reqpathUrl = lettingUrl;
                 else reqpathUrl = sellLetUrl;
               
                requestnew.setMethod('GET');
                requestnew.setEndpoint('callout:Reapit_Properties'+reqpathUrl);
                requestnew.setHeader('Content-Type','application/json');
                requestnew.setHeader('Authorization','Bearer '+ex.access_token);
                requestnew.setHeader('reapit-customer', 'URA');
                requestnew.setHeader('api-version','2023-01-17');
                requestnew.setTimeout(100000);
                HttpResponse responseNew = http.send(requestnew);
                httpresponse = responseNew.getBody();
                
                API_Log__c apiLogAuth = new API_Log__c();
                apiLogAuth.Request_Body__c = 'Endpoint: ' + requestnew.getEndpoint() + 'Body: ' + requestnew.getBody();
                apiLogAuth.Response_Body__c = httpresponse;
                apiLogAuth.Object_Name__c = 'Unit__c';
                apiLogAuth.Method__c = 'GET';
              //  insert apiLogAuth;
                
				if(responseNew.getStatusCode() == 200){
                string rs = responseNew.getBody();
                rs = rs.replaceAll('_embedded','embedded');
                rs = rs.replace('currency', 'currencyCode');
             	rs = rs.replace('_eTag', 'eTag');
             	rs = rs.replace('_links', 'links');

                system.debug('Response Body ::'+rs);
               
                Druce_FetchReapitDataWrapper exnew = (Druce_FetchReapitDataWrapper)JSON.deserialize(rs, Druce_FetchReapitDataWrapper.class);
                system.debug('Wrapper :: '+exnew);
                List<Unit__c> lstUnit = new List<Unit__c>();
                
            //    Map<String, Letting__c> mapLettings = new Map<String, Letting__c>();
           //     Map<String, Selling__c> mapSellings = new Map<String, Selling__c>();
                    Map<String, Opportunity> mapSellOpportunities = new Map<String, Opportunity>();
                    Map<String, Opportunity> mapLetOpportunities = new Map<String, Opportunity>();
                List<Map<String, Room__c>> maproomLists = new List<Map<String, Room__c>>();
                
                Set<String> unitIds = new Set<String>();
                
                /******************Unit Details******************************/
                
               for(Druce_FetchReapitDataWrapper.embedded exnewVar : exnew.embedded){
                    system.debug('---->'+exnewVar.Id);
                   
                  //  unitIds.add(exnewVar.Id);
                    Unit__c unit = new Unit__c();
                    unit.Project_Unit_Type__c = 'a070T000003NSzSQAW';
                    List<String> posString = exnewVar.address.postcode.split(' ');
                
                    unit.Name = exnewVar.address.line1 + ' ' + exnewVar.address.line2 + ' ' +exnewVar.address.line3 + ' ' +exnewVar.address.line4 + ' ' +
                        		posString[0];
                    unit.Reapit_Id__c = exnewVar.Id;
                   unit.Reapit_Web_Id__c = exnewVar.Id;
                   
                   	unit.Secondary_Market__c = True;
                   	unit.RecordTypeId = Druce_Constants.UNIT_UK;
                    unit.Reapit_Created_Date__c = exnewVar.created;
                    unit.Reapit_Modified_Date__c = exnewVar.modified;
                    unit.Reapit_Marketing_Mode__c = exnewVar.marketingMode;
                    unit.CurrencyIsoCode = exnewVar.currencyCode;
                    unit.Reapit_Alternate_Id__c = exnewVar.alternateId;
                    unit.Reapit_Area_Id__c = exnewVar.areaId;
                    unit.Strapline__c = exnewVar.strapline;
                    unit.Unit_Description__c = exnewVar.description;
                    unit.Unit_Long_Description__c = exnewVar.longDescription;
                    unit.Local_Authority__c = exnewVar.localAuthorityCompanyId;
                 	//unit.Summary__c = exnewVar.summary;KeyFeatureRich__c
                    unit.Reapit_Department_Id__c = exnewVar.departmentId;
                    unit.Reapit_Negotiator_Id__c = exnewVar.negotiatorId;
                    unit.No_of_Bedrooms__c	 = exnewVar.bedrooms;
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
                   /****************************************Area*******************************/
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
                    unit.Commercial__c = exnewVar.commercial;
                    unit.Regional__c = exnewVar.regional;
                     for(String type: exnewVar.type)
                         unit.Type__c = pickVal(unit.Type__c ,type);
                   
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
                     
                   // unit.KeyFeatureRich__c = String.valueOf(exnewVar.specialFeatures);Special_Features__c
                    unit.KeyFeatureRich__c = exnewVar.summary;
                    unit.Unmapped_Attributes__c = String.valueOf(exnewVar.unmappedAttributes);
                    unit.Room_Details_Approved__c = exnewVar.roomDetailsApproved;
                    unit.Embedded__c = exnewVar.embedded;
                    
                     
                     for(String officeIds: exnewVar.officeIds)
                   unit.Office_Ids__c = pickVal(unit.Office_Ids__c ,officeIds);

                    unit.Lost_Instruction_Date__c = exnewVar.lostInstructionDate;
                    unit.Lost_Instruction_Note__c = exnewVar.lostInstructionNote;
                    unit.Extras_Field__c = String.valueOf(exnewVar.extrasField);
                 
                    unit.Links__c = String.valueOf(exnewVar.links);
                    unit.eTag__c = exnewVar.eTag;
                   if(exnewVar.metadata!= null){
                       unit.metadata__c = String.valueOf(exnewVar.metadata);}
                    unit.Unit_Number__c = exnewVar.address.buildingNumber;
                  	unit.Block_Name__c = exnewVar.address.buildingName;
                   
                   if(exnewVar.address!= null){
                    unit.Unit_Number__c = exnewVar.address.buildingNumber;
                  	unit.Block_Name__c = exnewVar.address.buildingName;
                   	unit.BuildingNumber__c = exnewVar.address.buildingNumber;
                  	unit.BuildingName__c = exnewVar.address.buildingName;
					unit.Address_Line_1__c = exnewVar.address.line1;
					unit.Address_Line_2__c = exnewVar.address.line2;
					unit.Address_Line_3__c = exnewVar.address.line3;
					unit.Address_Line_4__c = exnewVar.address.line4;
					unit.Postal_Code__c = exnewVar.address.postcode;
					unit.Country_Code__c = exnewVar.address.countryId;
					unit.localTimeZone__c = exnewVar.address.localTimeZone;
					unit.Latitude__Latitude__s = exnewVar.address.geolocation.latitude;
                       unit.Latitude__Longitude__s = exnewVar.address.geolocation.longitude;}

                     if(exnewVar.rooms !=null){
                                    for( Druce_FetchReapitDataWrapper.rooms room : exnewVar.rooms){
                                        Room__c rm = new Room__c();
                                        Map<String, Room__c> maproom = new Map<String, Room__c>();
                                        rm.Reapit_Id__c = unit.Reapit_Id__c;
                                        rm.Name = room.name;
                                        rm.Dimensions__c = room.dimension;
                                        rm.Dimensions_Alt__c = room.dimensionsAlt;
                                        rm.Description__c = room.description;
                                        maproom.put(unit.Reapit_Id__c,rm);
                                   //     roomList.add(rm);
                                        maproomLists.add(maproom);
                                    }
                            }                 
                 //   unit.Reapit_Response__c = String.valueOf(exnewVar);
                                        /******************Letting Details******************************/
                        
                        Druce_FetchReapitDataWrapper.letting lettingWrap = new Druce_FetchReapitDataWrapper.letting();
                        lettingWrap = exnewVar.letting;
                       	
                       Opportunity oppSelling = new Opportunity();
					   Opportunity oppLetting = new Opportunity();
                       DateTime dt = exnewVar.created;
					   String dateTimeStr = dt.format('yyyy-dd-mm');
                   		system.debug('oppLetting.CloseDate'+ dateTimeStr);
                  		if(lettingWrap!=null){
                        oppLetting.Unique_Identifier__c = unit.Reapit_Id__c + 'Letting';   
                        oppLetting.Reapit_ID__c = unit.Reapit_Id__c;
                      //  oppLetting.Unique_Identifier__c = unit.Reapit_Id__c + 'Letting';
						oppLetting.AccountId = '0010T00000UEKhvQAH';
						oppLetting.StageName = 'Indicated Interest';
                       //     system.debug('oppLetting.CloseDate' + date.valueOf(dateTimeStr) + 200);
						//oppLetting.CloseDate = date.valueOf(dateTimeStr) + 200;
						oppLetting.CloseDate = System.today() +180;
						oppLetting.CurrencyIsoCode = unit.CurrencyIsoCode;
						oppLetting.Name = unit.Name;
						oppLetting.RecordTypeId = Druce_Constants.OppourtnityLetting;
										
                        //opp.Instructed__c = lettingWrap.instructed;
                        oppLetting.Instructed__c = lettingWrap.instructed;
                        oppLetting.Available_From__c = lettingWrap.availableFrom;
                        oppLetting.Available_To__c = lettingWrap.availableTo;
                        oppLetting.Price__c = lettingWrap.rent;
                     //   opp.Rent_Frequency__c = lettingWrap.rentFrequency;
						 oppLetting.Selling_Rent_Frequency__c = lettingWrap.rentFrequency;
                            if(lettingWrap.rentFrequency == 'monthly'){
                              unit.Rent_per_Month__c = lettingWrap.rent;  
                            }
                            if(lettingWrap.rentFrequency == 'weekly'){
                              unit.Rent_per_Week__c = lettingWrap.rent;
                              /*  if(lettingWrap.rentFrequency== null){
                                    unit.Rent_per_Month__c = lettingWrap.rent*2;
                                }*/
                            }
                            
                        for(String furnishing: lettingWrap.furnishing){
                            oppLetting.Furnishing__c = pickVal(oppLetting.Furnishing__c ,furnishing);
                     	}
                        oppLetting.Term__c = lettingWrap.term;
                        oppLetting.Status__c = lettingWrap.Status;
                        //unit.Reapit_Status__c = lettingWrap.Status;
                        oppLetting.Agent_Role__c = lettingWrap.agentRole;
                        oppLetting.Landlord_Id__c = lettingWrap.landlordId;
                        oppLetting.Works_Order_Note__c = lettingWrap.worksOrderNote;
                        oppLetting.Minimum_Term__c = lettingWrap.minimumTerm;
                        oppLetting.Property_Manager_Id__c = lettingWrap.propertyManagerId;
                       //opp.Status__c = lettingWrap.Status;
                            //unit.Unit_Availability__c = lettingWrap.Status;
                     if(lettingWrap.managementCompanyIds !=null){
                        for(String mgComp: lettingWrap.managementCompanyIds){
                        oppLetting.Management_Company_Ids__c = pickVal(oppLetting.Management_Company_Ids__c ,mgComp);
                        }}
                        //opp.Brochure_Id__c = lettingWrap.brochureId;
                        //opp.Public_Brochure_Url__c = lettingWrap.publicBrochureUrl;
                         oppLetting.Brochure_Id__c = lettingWrap.brochureId;    
                         oppLetting.Public_Brochure_Url__c = lettingWrap.publicBrochureUrl;
							if(lettingWrap.managementFee!=null){
                         oppLetting.Management_Fee_Amount__c = lettingWrap.managementFee.amount;
                     	oppLetting.Management_Fee_Type__c = lettingWrap.managementFee.type;}
                    // 	letting.Management_Fee__c = lettingWrap.managementFee;
							if(lettingWrap.lettingFee!=null){
                     	oppLetting.Fee__c = lettingWrap.lettingFee.amount;
                         oppLetting.Fee_Type__c = lettingWrap.lettingFee.type;}
                    // 	letting.Letting_Fee_Percentage__c = lettingWrap.managementFee;
                    	//opp.Qualifier__c = lettingWrap.qualifier;
                        oppLetting.Qualifier__c = lettingWrap.qualifier;
                        oppLetting.Letting_rent_includes__c = lettingWrap.Lettingrentincludes;
                        //opp.Agreement_Signed__c = lettingWrap.AgreementSigned;
                        oppLetting.Letting_Agreement_Signed__c = lettingWrap.AgreementSigned;
                       // opp.Management_Fee_Type__c= lettingWrap.Managementfeetype;
                     if(lettingWrap.deposit!=null){
                        oppLetting.Deposit_Type__c = lettingWrap.deposit.type;
                        oppLetting.Deposit__c = lettingWrap.deposit.amount;}
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
                        //Oppurtnity wrap end here
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
                        unit.CableTv_Company_Id__c = lettingWrap.utilities.cableTvCompanyId;}
                        
                //        mapLettings.put(unit.Reapit_Id__c,letting );
                        }
                    
                    /******************Selling Details******************************/
                     Druce_FetchReapitDataWrapper.selling sellingWrap = new Druce_FetchReapitDataWrapper.selling();
                     sellingWrap = exnewVar.selling;
                     
                     
                     if(sellingWrap!=null){
                         
                     oppSelling.Unique_Identifier__c = unit.Reapit_Id__c+ 'Selling';
                     oppSelling.Reapit_Id__c = unit.Reapit_Id__c;
					 oppSelling.AccountId = '0010T00000UEKhvQAH';
					 oppSelling.StageName = 'Indicated Interest';
					 oppSelling.CloseDate = System.today() +180;
                     
					 oppSelling.CurrencyIsoCode = unit.CurrencyIsoCode;
					 oppSelling.Name = unit.Name;
                 	 oppSelling.RecordTypeId = Druce_Constants.OppourtnitySecselling;
											
                     oppSelling.Instructed__c = sellingWrap.instructed;
                     unit.Unit_Price__c = sellingWrap.price;
                     oppSelling.Price__c = sellingWrap.price;
                     oppSelling.Price_To__c = sellingWrap.priceTo;
                     oppSelling.Reservation_Fee__c = sellingWrap.reservationFee;
                     oppSelling.Qualifier__c = sellingWrap.qualifier;
                     oppSelling.Status__c = sellingWrap.status;
                     //unit.Unit_Availability__c = sellingWrap.Status;
                     oppSelling.Disposal__c = sellingWrap.disposal;
                     oppSelling.Completed__c = sellingWrap.completed;
                     oppSelling.Exchanged__c = sellingWrap.exchanged;
                     oppSelling.Account_Paid__c = sellingWrap.accountPaid;
                     oppSelling.Vendor_Id__c = sellingWrap.vendorId;
                         if(sellingWrap.tenure!=null){
                     oppSelling.Tenure_Type__c = sellingWrap.tenure.type;
                             oppSelling.Tenure_Expiry__c = sellingWrap.tenure.expiry;}
                     oppSelling.Vendor_Id__c = sellingWrap.vendorId;
                     oppSelling.Agency__c = sellingWrap.agency;
                     oppSelling.Agency_Id__c = sellingWrap.agencyId;
                     oppSelling.Agreement_Expiry__c = sellingWrap.agreementExpiry;
                         
                //  	 selling.Fee__c = sellingWrap.fee.type;
                	  	 if(sellingWrap.fee!=null){
                         //opp.Fee__c = sellingWrap.fee.amount;
                         oppSelling.Fee__c = sellingWrap.fee.amount;
                      //   oppSelling.Fee_Type__c = sellingWrap.fee.type;
                         }
                         
                     oppSelling.Exchanged_Company_Fee__c = sellingWrap.exchangedCompanyFee;
                     oppSelling.Recommended_Price__c = sellingWrap.recommendedPrice;
                     oppSelling.Valuation_Price__c = sellingWrap.valuationPrice;
                     oppSelling.Brochure_Id__c = sellingWrap.brochureId;
                     oppSelling.Public_Brochure_Url__c = sellingWrap.publicBrochureUrl;
                     oppSelling.Exchanged_Price__c = sellingWrap.exchangedPrice;
                     oppSelling.Exchanged_Office_Id__c = sellingWrap.exchangedOfficeId;
                     oppSelling.Decoration__c = String.valueOf(sellingWrap.decoration);
                         if(sellingWrap.sharedOwnership!=null){
                     oppSelling.Selling_Shared_Percentage__c = sellingWrap.sharedOwnership.sharedPercentage;
                     oppSelling.Selling_Shared_Rent__c = sellingWrap.sharedOwnership.rent;
                //     oppSelling.Selling_Rent_Frequency__c = sellingWrap.sharedOwnership.rentFrequency;
                  	}
                     }//Selling wrap end here

                     if(exnewVar.marketingMode == 'letting'){
                         mapLetOpportunities.put(unit.Reapit_Id__c, oppLetting);  
                     }else
                     if(exnewVar.marketingMode == 'selling' && exnewVar.officeIds[0] == 'LNH'){
                         unit.Secondary_Market__c = False;
                         oppSelling.RecordTypeId = Druce_Constants.Oppourtnityselling;
                         mapSellOpportunities.put(unit.Reapit_Id__c, oppSelling);
                     }
                   	else
                     if(exnewVar.marketingMode == 'sellingAndLetting'){
						 mapSellOpportunities.put(unit.Reapit_Id__c, oppSelling);
						 mapLetOpportunities.put(unit.Reapit_Id__c, oppLetting);
                         
                         system.debug('mapSellOpportunities'+mapSellOpportunities);
                         system.debug('mapLetOpportunities'+mapLetOpportunities);
                     }else
                         if(exnewVar.marketingMode == 'selling' && exnewVar.officeIds[0] != 'LNH'){
                             mapSellOpportunities.put(unit.Reapit_Id__c, oppSelling);
                     }
                    //  insert unit;
                    unitIds.add(exnewVar.Id);
                    lstUnit.add(unit);
                }
                
                upsert lstUnit Reapit_Id__c;
              //  insert lstUnit;
                    
                List<Opportunity> oppLists = new List<Opportunity>();
            //    List<Letting__c> lstLettings = new List<Letting__c>();
                List<Room__c> lstRooms = new List<Room__c>();
                
                for(Unit__c unit :lstUnit){
                    if(mapSellOpportunities.containsKey(unit.Reapit_Id__c)){
                        Opportunity oppSelling = mapSellOpportunities.get(unit.Reapit_Id__c);
                      //  Opportunity oppLetting = mapOpportunities.get(unit.Reapit_Id__c);
                        oppSelling.Unit_Id__c = unit.Id;
                        oppSelling.Unit__c = unit.Id;
                        oppLists.add(oppSelling);
                    }
                    if(mapLetOpportunities.containsKey(unit.Reapit_Id__c)){
                     //   Opportunity oppSelling = mapOpportunities.get(unit.Reapit_Id__c);
                        Opportunity oppLetting = mapLetOpportunities.get(unit.Reapit_Id__c);
                     //   oppSelling.Unit_Id__c = unit.Id;
                        oppLetting.Unit_Id__c = unit.Id;
                        oppLetting.Unit__c = unit.Id;
                        oppLists.add(oppLetting);
                      //  oppLists.add(oppSelling);
                    }
                  
                    for(Map<String, Room__c> mapRoom: maproomLists){
                        if(mapRoom.containsKey(unit.Reapit_Id__c)){
                            Room__c room = mapRoom.get(unit.Reapit_Id__c);
                            room.Unit__c = unit.Id;
                            lstRooms.add(room);
                        }
                    }                    
                }
                 if(!oppLists.isEmpty()){
                     system.debug('oppLists' + oppLists);
                   upsert oppLists Unique_Identifier__c;
                }
                    List<Unit_Preference__c> unitPrefList = new List<Unit_Preference__c>();
                    for(Opportunity opps :oppLists){
                        Unit_Preference__c unitPref = new Unit_Preference__c();
                        unitPref.Opportunity__c = opps.Id;
                        unitPref.Unique_Identifier__c = opps.Id+opps.Unit_Id__c;
                        unitPref.Unit__c = opps.Unit_Id__c;
                      //  unitPref.CurrencyIsoCode = exnewVar.currencyCode;
                        unitPrefList.add(unitPref);  
                    } 
                    system.debug('unitPrefList' +unitPrefList);
                    upsert unitPrefList Unique_Identifier__c;
  
                if(pageNo < exnew.totalPageCount){
                    pageNo = pageNo + 1;
                    system.debug('Page No : '+pageNo);
                   // system.enqueueJob(new Druce_FetchReapitdataNew(pageNo));
                }
                system.enqueueJob(new Druce_ReapitImagesService(unitIds, ex.access_token));   
                //Druce_ReapitImagesService.createImages(unitIds, ex.access_token);    
			}
                else{system.debug('---->Failed');}
				
            }else{
                system.debug('---->Failed');
               
            }
			
			//Auth log
			API_Log__c apiLog = new API_Log__c();
        //    apiLog.Request_Body__c = 'Endpoint: ' + request.getEndpoint() + 'Body: ' + request.getBody();
            apiLog.Response_Body__c = response.getBody();
            apiLog.Object_Name__c = 'Authorization';
            apiLog.Method__c = 'GET';
           // insert apiLog;
			
        }catch(Exception e){
           system.debug('Exception '+e.getMessage()); 
           system.debug('Line Number '+e.getLineNumber()); 
        }
	}

    
    public class wrapperAuth {
        public String access_token;
        public Integer expire_in;
        public string token_type;
    }
}