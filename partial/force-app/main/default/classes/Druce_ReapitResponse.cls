public class Druce_ReapitResponse {
    public response response;
    
    public class response {
		public String Status;	//Success
		public String status_code;
        public String errormessage;	//200
		public List<results> results;
	}
    
    public class results {
        public string message;
	}

}