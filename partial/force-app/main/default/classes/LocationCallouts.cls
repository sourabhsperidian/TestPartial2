public class LocationCallouts {

	@future(callout=true)
	public static void newAccmethod(set<id> li){

		for(Account a : [SELECT BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet FROM Account WHERE id =: li]){
			String address = '';
            if (a.BillingStreet != null)

				address += a.BillingStreet +',';

			if (a.BillingCity != null)

			address += a.BillingCity +',';

			if (a.BillingState != null)

			address += a.BillingState +'';

			if (a.BillingPostalCode != null)

			address += a.BillingPostalCode +',';

			if (a.BillingCountry != null)

			address += a.BillingCountry;

			address = EncodingUtil.urlEncode(address, 'UTF-8');

			// build callout

			Http h = new Http();
            HttpRequest req = new HttpRequest();            
            req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address='+address+'&sensor=false');            
            req.setMethod('GET');
            req.setTimeout(5000);
            try{
            	// callout            
            	HttpResponse res = h.send(req);  
                system.debug('Response : '+req.getEndpoint());
                system.debug('Response : '+res.getBody());
            	// parse coordinates from response            
                JSONParser parser = JSON.createParser(res.getBody());
                double lat = null;            
            	double lon = null;            
            	while (parser.nextToken() != null) {
            
            		if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'location')){            
            			parser.nextToken(); // object start            
            			
                        while (parser.nextToken() != JSONToken.END_OBJECT){
            
            				String txt = parser.getText();            
            				parser.nextToken();            
            				if (txt == 'lat')            
            					lat = parser.getDoubleValue();

            				else if (txt == 'lng')
            
            				lon = parser.getDoubleValue();
            
            		}            
            	}            
            }

            // update coordinates if we get back
            
           		if (lat != null){            
                    system.debug(lat+''+lon);                    
                    a.Geo__Latitude__s = lat;
                    system.debug(a.Geo__Latitude__s+'a.Geo__Latitude__s');                    
                    a.Geo__Longitude__s = lon;
                    system.debug(a.Geo__Longitude__s +'a.Geo__Longitude__s');
                    update a;                
                }
            }           
            catch (Exception e) {           
            	system.debug(e);            
            }
    
        }

	}

}