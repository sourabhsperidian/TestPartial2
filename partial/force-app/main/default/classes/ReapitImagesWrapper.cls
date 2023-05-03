public class ReapitImagesWrapper {
	public String eventId;
    public String entityId;
    public String customerId;
    public DateTime eventTime;
    public String topicId;
    public embedded embedded;
    
    public class embedded {
		public String id;	    //MAS230027
		public DateTime created;	    //2023-03-14T16:35:33Z
		public DateTime modified;	    //2023-03-14T16:53:01Z
        public String propertyId;
		public String caption;
        public String url;
		public String eTag;
        public string type;
    }
}