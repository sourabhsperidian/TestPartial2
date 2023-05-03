public class DXF_ReapitWrapper {
	
    public List<embedded> embedded;
    
	public class embedded {
        public String id; //Reapit_Id__c
        public string marketingMode;
        public string currencyCode;
        public address address;
        public string areaId;        
        public string description;
        public string departmentId;
        public string negotiatorId;
        public Integer bedrooms;
        public Integer receptions;
        public Integer bathrooms;
        public integer numberOfUnits;
        public string parkingSpaces;
        public string councilTax;
        public string featuredImageUrl;
        /*public List<string> disabledPortalIds;
        public boolean internetAdvertising;
        public boolean isExternal;
        public string viewingArrangements;
        public string videoUrl;
        public string videoCaption;
        public string video2Url;
        public string video2Caption;
        public string notes;
        public string boardStatus;
        public string boardNotes;
        
        public string url;
        public string urlCaption;
        public Decimal groundRent;
        public string groundRentComment;
        public Date groundRentReviewDate;
        public string groundRentIncrease;
        public Decimal serviceCharge;
        public string serviceChargeComment;
        public string boardUpdated;
        public string valuation;
        public string rural;
        public string externalArea;
        public string internalArea;
        public epc epc;       
        public List<string> type;
        public List<string> style;
        public List<string> parking;
        public List<string> age;
        public List<string> locality;
        public List<string> specialFeatures;
        public List<string> unmappedAttributes;
        public List<string> rooms;
        public Boolean roomDetailsApproved;
        public List<String> officeIds;
        public Date lostInstructionDate;
        public String lostInstructionNote;
        public string eTag;*/
        public selling selling;
        public letting letting;
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
        Public Boolean completed;
        Public Boolean exchanged;
        Public Boolean accountPaid;
        public Date agreementExpiry;
        public String vendorId;
        public String agency;
        public String agencyId;
        public Decimal exchangedCompanyFee;
        public Decimal recommendedPrice;
        public Decimal valuationPrice;
        public String brochureId;
        public String publicBrochureUrl;
        Public Decimal exchangedPrice;
        public String exchangedOfficeId;
        //public tenure tenure;
    }
    
    public class tenure{
        public String type;
        public DateTIme expiry;
    }
    
    public class letting{
        public Date instructed;
        Public Date availableFrom;
        Public Date availableTo;
        public String brochureId;
        public String publicBrochureUrl;
        public String landlordId;
		public lettingFee lettingFee;
        
        public Integer minimumTerm;
		public String managementCompanyIds;        
        public Decimal managementFee;
        public String propertyManagerId;
        
        public Decimal rent;
        public String rentFrequency;
        public List<String> furnishing;        
        public String agentRole;        
        public String qualifier;
		public string term;
        public string status;
		public String worksOrderNote;
		
        public utilities utilities;
        
    }
    
    public class utilities{
        Public Boolean hasGas;
        Public String gasCompanyId;
        public Boolean gasMeterPoint;
        public String electricityCompanyId;
        public Boolean electricityMeterPoint;
        public String waterCompanyId;
        public Boolean waterMeterPoint;
        public String telephoneCompanyId;
        public String internetCompanyId;
        public String cableTvCompanyId;
        public deposit deposit;
    }
    
    public class lettingFee{
        public string type;
        public decimal amount;
    }
           
    public class deposit{
        public String type;
        public Decimal amount;
    }
    public class epc{
        
    }
	public Integer pageNumber;	//87
	public Integer pageSize;	//100
	public Integer pageCount;	//5
	public Integer totalPageCount;	//87
	public Integer totalCount;	//8605
	public links links;
    
	class disabledPortalIds {
	}
	class videoUrl {
	}
	class videoCaption {
	}
	class video2Url {
	}
	class video2Caption {
	}
	class boardStatus {
	}
	class boardNotes {
	}
	class featuredImageUrl {
	}
	class cls_url {
	}
	class cls_urlCaption {
	}
	class cls_groundRentComment {
	}
	class cls_groundRentReviewDate {
	}
	class cls_groundRentIncrease {
	}
	class cls_serviceChargeComment {
	}
	class cls_boardUpdated {
	}
	class cls_valuation {
	}
	class cls_archivedOn {
	}
	class cls_rural {
	}
	class cls_externalArea {
	}
	class cls_internalArea {
	}
	class cls_epc {
		public boolean exempt;
		public Integer eer;	//31
		public Integer eerPotential;	//42
		public Integer eir;	//0
		public Integer eirPotential;	//0
	}
	
	class cls_parking {
		/*public String 0;	//o
		public String 1;	//f
		public String 2;	//f
		public String 3;	//S
		public String 4;	//t
		public String 5;	//r
		public String 6;	//e
		public String 7;	//e
		public String 8;	//t*/
	}
	class cls_age {
		/*public String 0;	//p
		public String 1;	//e
		public String 2;	//r
		public String 3;	//i
		public String 4;	//o
		public String 5;	//d*/
	}
	class cls_locality {
	}
	class cls_specialFeatures {
	}
	class cls_unmappedAttributes {
	}
	class cls_rooms {
	}
	class cls_officeIds {
		/*public String 0;	//N
		public String 1;	//P
		public String 2;	//G*/
	}
	class cls_lostInstructionDate {
	}
	class cls_lostInstructionNote {
	}
	class cls_extrasField {
	}
	public class links {
		public cls_self self;
		public cls_first first;
		public cls_prev prev;
		public cls_last last;
	}
	class cls_self {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
	class cls_images {
		public String href;	///propertyImages/?propertyId=NPG040005
	}
	class cls_documents {
		public String href;	///documents/?associatedType=property&associatedId=NPG040005
	}
	class cls_offers {
		public String href;	///offers/?propertyId=NPG040005
	}
	class cls_appointments {
		public String href;	///appointments/?propertyId=NPG040005
	}
	class cls_negotiator {
		public String href;	///negotiators/TZW
	}
	class cls_offices {
		public String href;	///offices/?id=NPG
	}
	class cls_department {
		public String href;	///departments/G
	}
	class cls_landlord {
		public String href;	///landlords/RPT160010
	}
	class cls_area {
		public String href;	///areas/NEL
	}
	class cls_lettingBrochure {
		public String href;	///documents/NGL15000555
	}
	class cls_localAuthority {
		public String href;	///companies/RPT10000002
	}
	class cls_metadata {
	}
	class cls_first {
		public String href;	///properties/?PageNumber=1&PageSize=100
	}
	class cls_prev {
		public String href;	///properties/?PageNumber=86&PageSize=100
	}
	class cls_last {
		public String href;	///properties/?PageNumber=87&PageSize=100
	}
}