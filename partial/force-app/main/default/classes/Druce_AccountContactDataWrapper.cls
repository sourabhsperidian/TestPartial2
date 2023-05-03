global class Druce_AccountContactDataWrapper { 
public String eventId;
    public String entityId;
    public String customerId;
    public Date eventTime;
    public String topicId;
    public Embedded embedded;
        
    public class Embedded {
        public String id;
        public Date created;
        public Date modified;
        public String title;
        public String forename;
        public String surname;
        public Date dateOfBirth;
        public boolean active;
        public String marketingConsent;
        public String identityCheck;
        public String source;
        public String homePhone;
        public String workPhone;
        public String mobilePhone;
        public String email;
        public Date archivedOn;
        public boolean fromArchive;
        public PrimaryAddress primaryAddress;
        public SecondaryAddress secondaryAddress;
        public WorkAddress workAddress;
        public List<String> officeIds;
        public List<String> negotiatorIds;
        public List<String> categoryIds;
        public boolean communicationPreferenceLetter;
        public boolean communicationPreferenceEmail;
        public boolean communicationPreferencePhone;
        public boolean communicationPreferenceSMS;
        public AdditionalContactDetails[] additionalContactDetails;
        public String eTag;
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
    
    public class AdditionalContactDetails {
        public String type;
        public String value;
    }
}