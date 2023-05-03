public class Druce_FetchContactAPIWrapper {
    public List<Contact> embedded;
    public Integer pageNumber;
    public Integer pageSize;
    public Integer pageCount;
    public Integer totalPageCount;
    public Integer totalCount;
    public Links links;
    
    public class Contact {
        public String id;
        public DateTime created;
        public DateTime modified;
        public String title;
        public String forename;
        public String surname;
        public Date dateOfBirth;
        public Boolean active;
        public String marketingConsent;
        public String identityCheck;
        public Source source;
        public String homePhone;
        public String workPhone;
        public String mobilePhone;
        public String email;
        public String archivedOn;
        public Boolean fromArchive;
        public PrimaryAddress primaryAddress;
        public SecondaryAddress secondaryAddress;
        public WorkAddress workAddress;
        public List<String> officeIds;
        public List<String> negotiatorIds;
        public List<String> categoryIds;
        public Boolean communicationPreferenceLetter;
        public Boolean communicationPreferenceEmail;
        public Boolean communicationPreferencePhone;
        public Boolean communicationPreferenceSMS;
        public List<AdditionalContactDetail> additionalContactDetails;
        public String eTag;
        public Links links;
        public Object embedded;
        public Map<String, Object> metadata;
    }
    
    public class Source {
        public String id;
        public String type;
    }
    
    public class PrimaryAddress {
        public String type;
        public String buildingName;
        public String buildingNumber;
        public String line1;
        public String line2;
        public String line3;
        public String line4;
        public String postcode;
        public String countryId;
    }
    
    public class SecondaryAddress {
        public String type;
        public String buildingName;
        public String buildingNumber;
        public String line1;
        public String line2;
        public String line3;
        public String line4;
        public String postcode;
        public String countryId;
    }
    
    public class WorkAddress {
        public String type;
        public String buildingName;
        public String buildingNumber;
        public String line1;
        public String line2;
        public String line3;
        public String line4;
        public String postcode;
        public String countryId;
    }
    
    public class AdditionalContactDetail {
        public String type;
        public String value;
    }
    
    public class Links {
        public Link self;
        public Link first;
    }
        
    public class Link {
        public String href;
    }
}