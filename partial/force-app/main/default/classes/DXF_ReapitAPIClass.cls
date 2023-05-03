global class DXF_ReapitAPIClass implements Queueable, Database.AllowsCallouts{
    
    public Integer pageNo = 1;
    public String httpresponse;
    
     public  DXF_ReapitAPIClass(Integer pageNo)
    {
        this.pageNo = pageNo;
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
            //String body = '{"client_id":"3ohfvftvn15aap62di1nksaglu","grant_type":"client_credentials"}';
            //request.setHeader('client_id', '3ohfvftvn15aap62di1nksaglu');
            //request.setHeader('grant_type', 'client_credentials');
            String payLoad = 'client_id=3ohfvftvn15aap62di1nksaglu&grant_type=client_credentials';
			request.setBody(payLoad);
           // request.setBody(body);
            //request.setEndpoint('https://platform.reapit.cloud/properties?pageSize=100&pageNumber=87');
            request.setTimeout(60000);
            HttpResponse response = h.send(request);
    		system.debug('Response ::'+response);
            // Response OK
            if(response.getStatusCode() == 200){
                system.debug('response body :'+response.getBody());
                
                DXF_ReapitAPIClass.wrapperAuth wrap = new DXF_ReapitAPIClass.wrapperAuth();
                
                wrapperAuth ex = (wrapperAuth)JSON.deserialize(response.getBody(), wrapperAuth.class);
                system.debug(':::'+ex.access_token);

                Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
                String reqpathUrl = '?pageSize=100&pageNumber='+pageNo;
                //String reqpathUrl = '/properties?pageSize=30';
                requestnew.setMethod('GET');
                requestnew.setEndpoint('callout:Reapit_Properties'+reqpathUrl);
                requestnew.setHeader('Content-Type','application/json');
                requestnew.setHeader('Authorization','Bearer '+ex.access_token);
                requestnew.setHeader('reapit-customer', 'URA');
                requestnew.setHeader('api-version','2023-01-17');
                requestnew.setTimeout(60000);
                System.HttpResponse responseNew = new System.Http().send(requestnew);
                
                string rs = responseNew.getBody();
                rs = rs.replaceAll('_embedded','embedded');
                rs = rs.replace('currency', 'currencyCode');
                system.debug('Response Body ::'+rs);
                httpresponse = rs;
                DXF_ReapitWrapper exnew = (DXF_ReapitWrapper)JSON.deserialize(rs, DXF_ReapitWrapper.class);
                system.debug('Wrapper :: '+exnew);
                List<Unit__c> lstUnit = new List<Unit__c>();
                
                Map<String, Letting__c> mapLettings = new Map<String, Letting__c>();
                Map<String, Selling__c> mapSellings = new Map<String, Selling__c>();
                
                List<String> unitIds = new List<String>();
                for(DXF_ReapitWrapper.embedded exnewVar : exnew.embedded){
                    system.debug('---->'+exnewVar.Id);
                    unitIds.add(exnewVar.Id);
                    Unit__c unit = new Unit__c();
                    unit.Project_Unit_Type__c = 'a070T000003NSzSQAW';
                    unit.Name = exnewVar.address.buildingName;
                    unit.Reapit_Id__c = exnewVar.Id;
                    unit.Unit_Description__c = exnewVar.description;
                    unit.No_of_Bedrooms__c = exnewVar.bedrooms;
                    unit.No_of_Washrooms__c = exnewVar.bathrooms;
                    unit.Reception__c = exnewVar.receptions;
                    //unit.Unit_Price__c = exnewVar.selling.price;
                    unit.CurrencyIsoCode = exnewVar.currencyCode;
                    unit.Featured_Image_Url__c = exnewVar.featuredImageUrl;
                    unit.Reapit_Response__c = String.valueOf(exnewVar);
                    if(exnewVar.marketingMode == 'letting'){
                        unit.RecordTypeId = Druce_Constants.RENTAL_UK;
                        
                        DXF_ReapitWrapper.letting lettingWrap = new DXF_ReapitWrapper.letting();
                        lettingWrap = exnewVar.letting;
                       
                        Letting__c letting = new Letting__c();
                        letting.Available_From__c = lettingWrap.availableFrom;
                        letting.Available_To__c = lettingWrap.availableTo;
                        letting.Brochure_Id__c = lettingWrap.brochureId;
                        letting.Public_Brochure_Url__c = lettingWrap.publicBrochureUrl;
                        letting.CableTv_Company_Id__c = lettingWrap.utilities.cableTvCompanyId;
                        letting.Electricity_Company_Id__c = lettingWrap.utilities.electricityCompanyId;
                        
                      /*  if( lettingWrap.utilities.electricityMeterPoint == TRUE){
                        	letting.Electricity_Meter_Point__c = lettingWrap.utilities.electricityMeterPoint;    
                        }*/
                        //letting.Furnishing__c = String.valueOf(lettingWrap.furnishing);
                        
                   /*     if(lettingWrap.utilities.hasGas == TRUE){
                            letting.Has_Gas__c = lettingWrap.utilities.hasGas;
                        }*/
                        
              /*          if(lettingWrap.utilities.gasMeterPoint == TRUE){
                            letting.Gas_Meter_Point__c = lettingWrap.utilities.gasMeterPoint;
                        }*/
                        
                        letting.Gas_Company_Id__c = lettingWrap.utilities.gasCompanyId;
                        letting.Internet_Company_Id__c = lettingWrap.utilities.internetCompanyId;
                        letting.Telephone_Company_Id__c = lettingWrap.utilities.telephoneCompanyId;
                        letting.Water_Company_Id__c = lettingWrap.utilities.waterCompanyId;
                  /*      if(lettingWrap.utilities.waterMeterPoint == TRUE){
                        	letting.Water_Meter_Point__c = lettingWrap.utilities.waterMeterPoint;    
                        }*/
                        
                        letting.Landlord_Id__c = lettingWrap.landlordId;
                        //letting.Letting_Fee__c = lettingWrap.lettingFee.;
                        letting.Management_Company_Ids__c = lettingWrap.managementCompanyIds;
                        letting.Management_Fee__c = lettingWrap.managementFee;
                        letting.Minimum_Term__c = lettingWrap.minimumTerm;
                        letting.Property_Manager_Id__c = lettingWrap.propertyManagerId;
                        
                        letting.Qualifier__c = lettingWrap.qualifier;
                        letting.Rent__c = lettingWrap.rent;
                        letting.Rent_Frequency__c = lettingWrap.rentFrequency;
                        letting.Status__c = lettingWrap.Status;
                        
                        letting.Term__c = lettingWrap.term;
                        
                        letting.Works_Order_Note__c = lettingWrap.worksOrderNote;
                        
                        mapLettings.put(unit.Reapit_Id__c,letting );
                    }else if(exnewVar.marketingMode == 'selling'){
                        unit.RecordTypeId = Druce_Constants.SECONDARY_UK;
                        
                        DXF_ReapitWrapper.selling sellingWrap = new DXF_ReapitWrapper.selling();
                        
                        Selling__c selling = new Selling__c();
                        selling.Agency__c = sellingWrap.agency;
                        
                        selling.Agreement_Expiry__c = sellingWrap.agreementExpiry;
                        selling.Brochure_Id__c = sellingWrap.brochureId;
                /*        if(sellingWrap.completed == TRUE){
                            selling.Completed__c = sellingWrap.completed;
                        }
                        if(sellingWrap.accountPaid == TRUE){
                            selling.Account_Paid__c = sellingWrap.accountPaid;
                        }
                        if(sellingWrap.exchanged == TRUE){
                            selling.Exchanged__c = sellingWrap.exchanged;
                        }*/
                        
                        selling.Disposal__c = sellingWrap.disposal;                        
                        selling.Exchanged_Company_Fee__c = sellingWrap.exchangedCompanyFee;
                        selling.Exchanged_Office_Id__c = sellingWrap.exchangedOfficeId;
                        selling.Exchanged_Price__c = sellingWrap.exchangedPrice;
                        //selling.Fee__c = sellingWrap.;
                        selling.Instructed__c = sellingWrap.instructed;
                        selling.Price__c = sellingWrap.price;
                        selling.Price_To__c = sellingWrap.priceTo;
                        selling.Public_Brochure_Url__c = sellingWrap.publicBrochureUrl;
                        selling.Qualifier__c = sellingWrap.qualifier;
                        selling.Recommended_Price__c = sellingWrap.recommendedPrice;
                        selling.Reservation_Fee__c = sellingWrap.reservationFee;
                        selling.Status__c = sellingWrap.status;
                       // selling.Tenure__c = sellingWrap.tenure.type;
                        selling.Valuation_Price__c = sellingWrap.valuationPrice;
                        
                        mapSellings.put(unit.Reapit_Id__c, selling);
                    }
                    
                    //  insert unit;
                    lstUnit.add(unit);
                }
                
                upsert lstUnit Reapit_Id__c;
                //Process Images 
               // Druce_ReapitImagesService.createImages(unitIds, ex.access_token);
                
                List<Selling__c> lstSellings = new List<Selling__c>();
                List<Letting__c> lstLettings = new List<Letting__c>();
                
                for(Unit__c unit :lstUnit){
                    
                    if(mapSellings.containsKey(unit.Reapit_Id__c)){
                        Selling__c sellings = mapSellings.get(unit.Reapit_Id__c);
                        sellings.Unit__c = unit.Id;
                        lstSellings.add(sellings);
                    }
                    
                    if(mapLettings.containsKey(unit.Reapit_Id__c)){
                        Letting__c letting = mapLettings.get(unit.Reapit_Id__c);
                        letting.Unit__c = unit.Id;
                        lstLettings.add(letting);
                    }
                }
                
                
                if(!lstSellings.isEmpty()){
                    insert lstSellings;
                }
                if(!lstLettings.isEmpty()){
                    insert lstLettings;
                }
                
                
                if(exnew.pageCount != 0 && exnew.pageCount != NULL && exnew.pageCount<120){
                    pageNo = pageNo + 1;
                    system.debug('Page No : '+pageNo);
                    system.enqueueJob(new DXF_ReapitAPIClass(pageNo));
                }
            }else{
                system.debug('---->Failed');
            }
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