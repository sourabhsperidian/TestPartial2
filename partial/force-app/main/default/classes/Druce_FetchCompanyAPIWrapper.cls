global class Druce_FetchCompanyAPIWrapper 
{
    global List<Company> embedded;
    public Integer pageNumber;
    public Integer pageSize;
    public Integer pageCount;
    public Integer totalPageCount;
    public Integer totalCount;
    public ParentLinks links;
    
    public class Company {
        public String id;
        public Datetime created;
        public Datetime modified;
        public String name;
        public String branch;
        public String notes;
        public Boolean active;
        public String marketingConsent;
        public Boolean vatRegistered;
        public List<String> typeIds;
        public String supplierTypeId;
        public String workPhone;
        public String mobilePhone;
        public String email;
        public Datetime archivedOn;
        public Boolean fromArchive;
        public AddressCls address;
        public List<ContactDetail> additionalContactDetails;
        public List<String> officeIds;
        public List<String> negotiatorIds;
        public String eTag;
        public Links links;
        public Object embedded;
        public Map<String, Object> metadata;
    }
    
    public class AddressCls {
        public String buildingName;
        public String buildingNumber;
        public String line1;
        public String line2;
        public String line3;
        public String line4;
        public String postcode;
        public String country;
    }
    
    public class ContactDetail {
        public String type;
        public String value;
    }
	
	public class Links{
		public Link self;
		public Link companyTypes;
		public Link relationships;
	}
    
    public class ParentLinks {
        public Link self;
        public Link first;
    }
	
    public class Link {
        public String href;
    }
	
}