global class WebsiteDataIntegration implements Queueable, Database.AllowsCallouts {
    
    public Integer pageNo = 1;
    public  WebsiteDataIntegration(Integer pageNo)
    {
        this.pageNo = pageNo;
    }
    
    public void execute(QueueableContext context) {
        try{
            
            Http http = new Http();
                HttpRequest requestnew = new HttpRequest();
                String reqpathUrl = 'https://www.druce.com/api/?page=1';
                requestnew.setMethod('GET');
                requestnew.setEndpoint(reqpathUrl);
                requestnew.setHeader('Content-Type','application/json');
                System.HttpResponse responseNew = new System.Http().send(requestnew);
                
                string rs = responseNew.getBody();
                rs = rs.replaceAll('_','');
                rs = rs.replace('currency', 'currencyCode');
                system.debug('::'+rs);
                DXF_ReapitWrapper exnew = (DXF_ReapitWrapper)JSON.deserialize(rs, DXF_ReapitWrapper.class);
                system.debug('::'+exnew);
                List<Unit__c> lstUnit = new List<Unit__c>();
                for(DXF_ReapitWrapper.embedded exnewVar : exnew.embedded){
                    Unit__c unit = new Unit__c();
                    unit.Project_Unit_Type__c = 'a070T0000027LwrQAE';
                    unit.Name = exnewVar.address.buildingName;
                    unit.Reapit_Id__c = exnewVar.Id;
                    unit.Unit_Description__c = exnewVar.description;
                    unit.No_of_Bedrooms__c = exnewVar.bedrooms;
                    unit.No_of_Washrooms__c = exnewVar.bathrooms;
                    unit.Reception__c = exnewVar.receptions;
                    unit.Unit_Price__c = exnewVar.selling.price;
                    unit.CurrencyIsoCode = exnewVar.currencyCode;
                    unit.RecordTypeId = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('Secondary UK').getRecordTypeId();//'0120T000000NwEaQAK';
                  //  insert unit;
                    lstUnit.add(unit);
                }
                
                upsert lstUnit Reapit_Id__c;
                
                if(exnew.pageCount != 0 && exnew.pageCount != NULL){
                    pageNo = pageNo + 1;
                    system.debug('Page No : '+pageNo);
                   // system.enqueueJob(new DXF_ReapitAPIClass(pageNo));
                }
            
        }catch(Exception e){
           system.debug('Exception '+e.getMessage()); 
           system.debug('Trace '+e.getStackTraceString()); 
        }
    }

}