global class Druce_ReapitImagesService implements Queueable, Database.AllowsCallouts{
    
    global Set<String> unitIds;
    global String token;
    global Integer ImageNum;
    
    public Druce_ReapitImagesService(Set<String> unitIds, String token){
        this.unitIds = unitIds;
        this.token = token;
    }
    
    public void execute(QueueableContext context) {
    	CreateImages(unitIds, token);
    }
    
    //@future(callout=true)
    public static void CreateImages(Set<String> unitIds, String token) {
        
        List<Reapit_Image__c> lstImages = new List<Reapit_Image__c>();
        List<Unit__c> unitList = New List<Unit__c>();
        Map<Id, Unit__c> UnitImgMap = New Map<Id, Unit__c>();
        try{
            for(Unit__c unit : [SELECT Id,Featured_Image_Url__c,Reapit_Id__c FROM Unit__c WHERE Reapit_Id__c IN : unitIds]){
                UnitImgMap.put(unit.Id, Unit);
                
                Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
                requestnew.setMethod('GET');
                String unitId = unit.Id;
                String propId = unit.Reapit_Id__c;
                String primaryUrl = unit.Featured_Image_Url__c;
                system.debug('propId' + propId + ' ' + unitId);
                String reqpathUrl = '/propertyImages/?propertyId='+propId;
                requestnew.setEndpoint('callout:Reapit_Properties'+reqpathUrl);
                requestnew.setHeader('Content-Type','application/json');
                requestnew.setHeader('Authorization','Bearer '+token);
                requestnew.setHeader('reapit-customer', 'URA');
                requestnew.setHeader('api-version','2023-01-17');
                requestnew.setTimeout(100000);
                
                HttpResponse response = new HttpResponse();
                response = http.send(requestnew);
                system.debug('Response :: '+response);
                system.debug('Response :: '+response.getBody());
                
                string rs = response.getBody();
                //Logs
                /*API_Log__c apiLog = new API_Log__c();
                apiLog.Request_Body__c = 'Endpoint: ' + requestnew.getEndpoint() + 'Body: ' + requestnew.getBody();
                apiLog.Response_Body__c = rs;
                apiLog.Object_Name__c = 'Reapit_Image__c';
                apiLog.Method__c = 'GET';
                insert apiLog; */
                
                rs = rs.replaceAll('_embedded','embedded');
                
                if(rs!=null && response.getStatusCode() == 200){
                    Druce_ReapitImages exnew = (Druce_ReapitImages)JSON.deserialize(rs, Druce_ReapitImages.class);
                    system.debug('Images Wrapper :: '+exnew);
                    if(exnew.embedded!=null){
                        Integer ImageNum = 0;
                        //Add Primary Image
                        if(primaryUrl!= null){
                        	Reapit_Image__c primImg = new Reapit_Image__c();
                            primImg.Name = unitId + ' PimaryImage';
                            primImg.Unit__c = unitId;
                            primImg.Image_Url__c = primaryUrl;
                        	primImg.Type__c = 'Primary';
                            lstImages.add(primImg);
                        	ImageNum = 1;
                        }
                        
                        for(Druce_ReapitImages.embedded exnewVar : exnew.embedded){
                            if(primaryUrl != exnewVar.url){
                                Reapit_Image__c img = new Reapit_Image__c();
                                img.Name = unitId + ' ' +exnewVar.id;
                                img.Unit__c = unitId;
                                img.Image_Url__c = exnewVar.url;
                                img.caption__c = exnewVar.caption;
                                img.Type__c = exnewVar.type;
                                img.Order__c = exnewVar.order;
                                img.eTag__c = exnewVar.eTag;
                                lstImages.add(img);
                            }
                        }
                        
                        ImageNum = ImageNum + exnew.embedded.size();
                        if(ImageNum>0){
                        system.debug(ImageNum);
                        Unit__c unitcount = New Unit__c(Id = unitId, CountOfReapitImages__c = ImageNum);
                        unitList.add(unitcount);
                        }
                      //  update u;
                    }
                }
                else{
                    // Error Log
                }
            }
            if(!unitList.isEmpty()){
                update unitList;}
            
            if(!lstImages.isEmpty()){
                system.debug('check error');
                upsert lstImages Name;
                system.debug('check error1');
                List<Amazon_Files__c> fileLst = new List<Amazon_Files__c>();
                set<String> units = new Set<String>();
                for(Reapit_Image__c img : lstImages){
                    Amazon_Files__c af = new Amazon_Files__c();
                    af.Name = img.Name;
                    af.Status__c = 'New';
                    af.Unit__c = img.Unit__c;
                    af.Reapit_Image_Url__c = img.Image_Url__c;
                    if(img.Type__c == 'floorPlan'){
                       af.Floor_Plan__c = TRUE; 
                    }
                    if(img.Type__c == 'epc'){
                        af.EPC__c = TRUE;
                    }
                    if(img.Type__c == 'Primary'){
                        af.Is_Primary__c = TRUE;
                    }
                    units.add(af.Unit__c);
                    fileLst.add(af);
                }
                if(!fileLst.isEmpty()){
                    upsert fileLst Name;
                    system.debug('totalsize' + unitList.size());
                    system.enqueueJob(new ReapitImagesSync(unitList, unitList.size()));
                  /*  for(String strunit: units){
                      //  ReapitImagesSync.SyncReapitImages(new set<String>{strunit});
                     // system.enqueueJob(new ReapitImagesSync(new set<String>{strunit}));
                   //  Database.executeBatch(new ReapitImagesSync(new set<String>{strunit}), 1);
                   
                    }*/
                    
                }
                //AWSIntegration.SyncReapitImages(lstImages);
            }
        }
        catch(Exception e){
            system.debug('Exception: ' + e.getMessage());
        }
    }    
}