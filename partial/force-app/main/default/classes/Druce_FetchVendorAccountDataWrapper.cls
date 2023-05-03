global class Druce_FetchVendorAccountDataWrapper
{
	global List<embeddedCls> embedded;
    public Integer pageNumber;
	public Integer pageSize;
	public Integer pageCount;
	public Integer totalPageCount;
	public Integer totalCount;
	public parentlinks links;
	
	global class embeddedCls {
		public String id;	    
		public DateTime created;	   
		public DateTime modified;	    
		public Date lastCall;
		public Date nextCall;
		public String typeId;
		public String sellingReasonId;
		public String solicitorId;
		public String propertyId;
		public sourceCls source;
		public List<relatedWrapperCls> related;
		public String negotiatorId;
		public List<String> officeIds;
		public String archivedOn;
		public boolean fromArchive;
		public String eTag;
		public accLinks links; 
		public String embedded; 
		public metadata metadata;
	} 

    public class sourceCls
    {
        public string id;
        public string type;
    }
	
    public class relatedWrapperCls
    {
		public String id; 
		public String name;
		public String title;
		public String forename;
		public String surname;
		public Date dateOfBirth;
		public String type;
		public String homePhone;
		public String workPhone;
		public String mobilePhone;
		public String email;
		public boolean fromArchive;
		public address primaryAddress;						
	}
    
	public class address{
        public String buildingName;
        public String buildingNumber;
        public String line1;
        public String line2;
        public String line3;
        public String line4;
        public String postcode;
        public String countryId;    
	}

    public class accLinks { 
        public self self;
        public property property; 
        public negotiator negotiator; 
        public relationships relationships; 
        public offices offices;
    }
	
	public class parentlinks {
		public cls_self self;
		public cls_first first;
		public cls_last last;
        public cls_next next;
	}
	
    public class self 
    { 
        public String href;
    } 
    public class property {
        public String href; 
    } 
    public class negotiator { 
        public String href; 
    } 
    public class relationships { 
        public String href; 
    }
    public class offices { 
        public String href;
    }
    public class metadata { 
        public String CustomField1;
		public boolean CustomField2;
    }
	public class cls_self {
		public String href;
	}
	class cls_first {
		public String href;
	}
	class cls_next {
		public String href;
	}
	class cls_last {
		public String href;
	}
}