public class Druce_WebsiteDataWrapper {
	
    public Integer total_results {get;set;} 
	public Integer pages {get;set;} 
	public List<Properties> properties {get;set;}
    
    public class Properties {
		public String id {get;set;} 
		public Integer bedrooms {get;set;} 
		public Integer bathrooms {get;set;} 
		public Integer receptions {get;set;} 
		public String outdoorarea {get;set;} 
		public String parking {get;set;} 
		public String status {get;set;} 
		public String tenure {get;set;} 
		public String furnishings {get;set;} 
		public String dep {get;set;} 
		public Integer squarefeet {get;set;} 
		public String price {get;set;} 
		public String description {get;set;} 
		public String excerpt {get;set;} 
		public Double lat {get;set;} 
		public Double lng {get;set;} 
		public String type {get;set;} 
		public Integer hot {get;set;} 
		public Integer featured {get;set;} 
		public String seo_url {get;set;} 
		public String seo_address {get;set;} 
		public String seo_desc {get;set;} 
		public String seo_prefix {get;set;} 
		public List<String> key_features {get;set;} 
		public String pdf_details {get;set;} 
		public String virtual_tour {get;set;} 
		public String tour_caption {get;set;} 
		public String virtual_tour_2 {get;set;} 
		public String tour_caption_2 {get;set;}  
		public String area {get;set;} 
		public String area_guide {get;set;} 
		public String date_Z {get;set;} // in json: date
		public String available_from {get;set;} 
		public Boolean internet_adv {get;set;} 
    }
}