global class Druce_FetchReapitDataWrapper {
	
    global List<embedded> embedded;
    public Integer pageNumber;	//87
	public Integer pageSize;	//100
	public Integer pageCount;	//5
	public Integer totalPageCount;	//87
	public Integer totalCount;	//8605
	public parentlinks links;
    
	global class embedded {
		public String id;	    //MAS230027
		public DateTime created;	    //2023-03-14T16:35:33Z
		public DateTime modified;	    //2023-03-14T16:53:01Z
		public String marketingMode;	    //sellingAndLetting
		public String currencyCode;	    //GBP
		public String alternateId;
		public address address;
		public String areaId;	    //
        public String strapline;
	//	public strapline strapline;
		public String description;	    //
		public String longDescription;	    //
		public String localAuthorityCompanyId;
		public String summary;
		public String departmentId;	    //G
		public String negotiatorId;	    //MMP
		public Integer bedrooms;	    //1
		public Integer bedroomsMax;	    //1
		public Integer receptions;	    //1
		public Integer receptionsMax;	    //1
		public Integer bathrooms;	    //1
		public Integer bathroomsMax;	    //1
		public Integer numberOfUnits;	    //0
		public Integer parkingSpaces;	    //0
		public String councilTax;
		public List<String> disabledPortalIds;
		public boolean internetAdvertising;
		public boolean isExternal;
		public String viewingArrangements;
		public String videoUrl;
		public String videoCaption;
		public String video2Url;
		public String video2Caption;
		public String notes;	    //Property copied from reference: MAL230029
		public String boardStatus;
		public String boardNotes;
		public String featuredImageUrl;
		public String url;
		public String urlCaption;
		public Double groundRent;	    //0
		public String groundRentComment;
		public DateTime groundRentReviewDate;
		public Double groundRentIncrease;
		public Double serviceCharge;	    //0
		public String serviceChargeComment;
		public String boardUpdated;
		public DateTime valuation;	    //2023-03-15T09:30:00Z
		public String archivedOn;
        public List<String> keywords;
		public boolean fromArchive;
		public rural rural;
		public externalArea externalArea;
		public internalArea internalArea;
		public epc epc;
		public selling selling;
		public letting letting;
		public String commercial;
		public String regional;
		public List<String> type;
		public List<String> style;
		public List<String> situation;
		public List<String> parking;
		public List<String> age;
		public List<String> locality;
		public List<String> specialFeatures;
		public List<String> unmappedAttributes;
		public List<rooms> rooms; // Need to check******************************************
		public boolean roomDetailsApproved;
		public List<String> officeIds;
		public DateTime lostInstructionDate;
		public String lostInstructionNote;
		public extrasField extrasField;
		public String eTag;	    //"5F297786052EEC35F8941D5D9762C973"
		public unitlinks links;
		public metadata metadata;
        public String embedded;	
	}
    public class extrasField{
        
    }

    public class epc{
        
        public boolean exempt;
        public Integer eer;
        public Integer eerPotential;
        public Integer eir;
        public Integer eirPotential;
        
    }
    public class rural {
		public String tenureId;	    //LH
		public String buildingsDescription;	    //2 barns and a stable
		public String landDescription;	    //400 acres of mixed arable
	}
	
	public class externalArea {
        public string type;
        public Decimal min;
        public Decimal max;
	}
	public class internalArea {
        public string type;
        public Decimal min;
        public Decimal max;
	}

	public class rooms {
		public String name;	    //Kitchen
		public String dimension;	    //4.5m x 5.2m
		public string dimensionsAlt;
		public String description;	
	} 
    public class metadata {
        public String CustomField1;	    //CustomValue1
		public boolean CustomField2;
	}
    
    public class address {
		public String buildingName;	//
		public String buildingNumber;	//81
		public String line1;	//Silver Street
		public String line2;	//Newport Pagnell
		public String line3;	//Bucks
		public String line4;	//
		public String postcode;	//MK16 0EJ
		public String countryId;	//
		public String localTimeZone;	//Europe/London
		public geolocation geolocation;
	}
    
    public class geolocation {
		public Double latitude;	//52.0851
		public Double longitude;	//-0.722637
	}
    
    public class selling{
        public Date instructed;
        public Decimal price;
        public Decimal priceTo;
        public Decimal reservationFee;
        public String qualifier;
        public String status;
        public String disposal;
        Public DateTime completed;
        Public Date exchanged;
        Public Date accountPaid;
        public tenure tenure;   
        public String vendorId;
        public String agency;
        public String agencyId;
        public Date agreementExpiry;
        public fee fee;		
        public Decimal exchangedCompanyFee;
        public Decimal recommendedPrice;
        public Decimal valuationPrice;
        public String brochureId;
        public String publicBrochureUrl;
        Public Decimal exchangedPrice;
        public String exchangedOfficeId;
        public List<String> decoration;
        public sharedOwnership sharedOwnership;
    }
    
    public class tenure{
        public String type;
        public DateTime expiry;
    }
    public class fee {
        public String type;
        public Decimal amount;
    }
    public class sharedOwnership {
        public Decimal sharedPercentage;
        public Decimal rent;
        public String rentFrequency;
    }
    
    public class letting{
        public Date instructed;
        Public Date availableFrom;
        Public Date availableTo;
        public Decimal rent;
        public String rentFrequency;
        public List<String> furnishing;
        public string term;
        public string status;
        public String agentRole; 
        public String landlordId;
        public String worksOrderNote;
        public Integer minimumTerm;
        public String propertyManagerId;
        public List<String> managementCompanyIds;
        public String brochureId;
        public String publicBrochureUrl;
        public managementFee managementFee;
		public lettingFee lettingFee;
        public String qualifier;
       	public utilities utilities;
        public deposit deposit;
        public string Managementfeetype;
        public string Lettingrentincludes;
        public string AgreementSigned;
        
        
    }
     public class lettingFee{
        public string type;
        public decimal amount;
    }
     public class managementFee{
        public string type;
        public decimal amount;
    }
    
    public class utilities{
        Public Boolean hasGas;
        Public String gasCompanyId;
        public String gasMeterPoint;
        public String electricityCompanyId;
        public String electricityMeterPoint;
        public String waterCompanyId;
        public String waterMeterPoint;
        public String telephoneCompanyId;
        public String internetCompanyId;
        public String cableTvCompanyId;
     //   public deposit deposit;
    }
           
    public class deposit{
        public String type;
        public Decimal amount;
    }


	public class parentlinks {
		public self self;
		public cls_first first;
		public cls_prev prev;
		public cls_last last;
        public cls_last next;
	}
    public class unitlinks {
		public self self;
		public images images;
        public documents documents;
		public appointments appointments;
		public offers offers;
		public negotiator negotiator;
        public offices offices;
        public department department;
		public vendor vendor;
		public landlord landlord;
        public master master;
       	public sellingAgency sellingAgency;
        public localAuthority localAuthority;
		public area area;
        public sellingBrochure sellingBrochure;
        public lettingBrochure lettingBrochure;
        public boardStatus boardStatus;
		public ruralTenure ruralTenure;
		public portalType portalType;
		public gasCompany gasCompany;
        public electricityCompany electricityCompany;
        public waterCompany waterCompany;
        public internetCompany internetCompany;
        public telephoneCompany telephoneCompany;
		public cableTvCompany cableTvCompany;
		public propertyManager propertyManager;
		public managementCompanies managementCompanies;
	}
	public class self {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
	public class images {
		public String href;	///propertyImages/?propertyId=NPG040005
	}
	public class documents {
		public String href;	///documents/?associatedType=property&associatedId=NPG040005
	}
	public class offers {
		public String href;	///offers/?propertyId=NPG040005
	}
	public class appointments {
		public String href;	///appointments/?propertyId=NPG040005
	}
    
	public class negotiator {
		public String href;	///negotiators/TZW
	}
	public class offices {
		public String href;	///offices/?id=NPG
	}
    public class localAuthority {
		public String href;	///offices/?id=NPG
	}
	public class department {
		public String href;	///departments/G
	}
	public class landlord {
		public String href;	///landlords/RPT160010
	}
    public class vendor {
		public String href;	///landlords/RPT160010
	}
    public class master {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
    public class sellingAgency {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
	public class area {
		public String href;	///areas/NEL
	}
	class lettingBrochure {
		public String href;	///documents/NGL15000555
	}
    class sellingBrochure {
		public String href;	///documents/NGL15000555
	}
    class boardStatus {
		public String href;	///documents/NGL15000555
	}
    class ruralTenure {
		public String href;	///documents/NGL15000555
	}
    class portalType {
		public String href;	///documents/NGL15000555
	}
    class gasCompany {
		public String href;	///documents/NGL15000555
	}
    class electricityCompany {
		public String href;	///documents/NGL15000555
	}
    class waterCompany {
		public String href;	///documents/NGL15000555
	}

    class internetCompany {
		public String href;	///documents/NGL15000555
	}
     class telephoneCompany {
		public String href;	///documents/NGL15000555
	}
     class cableTvCompany {
		public String href;	///documents/NGL15000555
	}
     class propertyManager {
		public String href;	///documents/NGL15000555
	}
     class managementCompanies {
		public String href;	///documents/NGL15000555
	}
    

	class cls_first {
		public String href;	///properties/?PageNumber=1&PageSize=100
	}
	class cls_prev {
		public String href;	///properties/?PageNumber=86&PageSize=100
	}
    class cls_next {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
	class cls_last {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
}