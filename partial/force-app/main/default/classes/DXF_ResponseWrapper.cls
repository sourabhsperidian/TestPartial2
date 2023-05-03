public class DXF_ResponseWrapper {
    
    public response response;
    
    public class response {
		public String Status;	//Success
		public String status_code;
        public String errormessage;	//200
		public List<results> results;
	}
    
    public class results {
		public String extDB_Id;
		public String salesforce_Id;
        public String userId;
        public string message;
        public boolean AccountCreated;
	}

}