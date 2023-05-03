global class Druce_FetchLandlordAccountWrapper {
    global List<embeddedCls> embedded;
    public Integer pageNumber;
    public Integer pageSize;
    public Integer pageCount;
    public Integer totalPageCount;
    public Integer totalCount;
    public parentlinks links;
    
    global class embeddedCls{
        public string id;
        public DateTime created;
        public DateTime modified;
        public boolean active;
        public string solicitorId;
        public string officeId;
        public sourceCls source;
        public List<relatedCls> related;
        public extra extrasField;
        public string eTag;
        public linksin links;
        public string embedded;
        public metadata metadata;
    }
    
    public class relatedCls{
        public string id;
        public string name;
        public string title;
        public string forename;
        public string surname;
        public string dateOfBirth;
        public string type;
        public string homePhone;
        public string workPhone;
        public string mobilePhone;
        public string email;
        public address primaryAddress; 
    }
    
    public class sourceCls{
        public string id;
        public string type;
    }
    
    public class parentlinks{
        public link self;
        public link first;   
    }
    
    public class linksin{
        public link self;
        public link documents;
        public link appointments;
        public link office;
        public link properties;
        public link relationships;
    }
    
    public class link{
        public string href;
    }
    
    public class extra{
        
    }
    
    public class metadata{
    }
    public class address{
        public string buildingName;
        public string buildingNumber;
        public string line1;
        public string line2;
        public string line3;
        public string line4;  
        public string postcode;  
        public string countryId;
    }
}