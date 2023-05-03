public class Druce_ReapitImagesResponse {
	public string status;
    public string message;
    public response response;
    
    public class response{
        public string id;
        public boolean deleted;
        public boolean isPrimary;
        public boolean floorPlan;
        public boolean epc;
        public String description;
        public String projectId;
        public string unitId;
        
    }
}