global class Druce_FetchOwnerRelationshipWrapper {
    global List<EmbeddedRelationship> embedded;
    public Integer pageNumber;
    public Integer pageSize;
    public Integer pageCount;
    public Integer totalPageCount;
    public Integer totalCount;
    public ParentLinks links;
    
    global class EmbeddedRelationship {
        public String id;
        public String vendorId;
        public String landlordId;
        public Datetime created;
        public Datetime modified;
        public String associatedType;
        public String associatedId;
        public Boolean isMain;
        public Links links;
        public string embedded;
        public metadataCls metadata;
    }
    
    public class ParentLinks {
        public Link self;
        public Link first;
    }
    
	public class Links {
        public Link self;
        public Link contact;
    }
	
    public class Link {
        public String href;
    }
	
	public class metadataCls { 
        public String CustomField1;
		public boolean CustomField2;
    }
}