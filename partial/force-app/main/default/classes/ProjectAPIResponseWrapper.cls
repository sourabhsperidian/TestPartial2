public class ProjectAPIResponseWrapper {   

	public Integer status;
	public String message;
	public List<Response> response;
	
    public class Response {
		public String message;
		public String projectId;
		public String sfProjectId;
		public List<ProjectUnitType> projectUnitType;
	}
    
	public class ProjectUnitType {
		public String message;
		public String projectUnitId;
		public String sfProjectUnitId;
		public List<Unit> unit;
	}

	public class Unit {
		public String message;
		public String unitId;
		public String sfUnitId;
		public String detailUrl;
		public List<RoomList> roomList;
	}
	
	public class RoomList {
	    public String message;
		public String roomId;
		public String sfRoomId;
	}
}