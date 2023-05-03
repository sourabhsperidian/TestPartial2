public class DXF_QueueMemeberHandler {
    @AuraEnabled(cacheable=true)
    public static List<WrapperQueue> getQueues(){
        try {
            List<WrapperQueue> lstwrap = new List<WrapperQueue>();
            Map<Id,String> mapQueue = new Map<Id, String>();
            for(GroupMember grpMem : [Select Id,GroupId, Group.Name from GroupMember]){
                mapQueue.put(grpMem.GroupId, grpMem.Group.Name);                
            }
            
            for(String grpName : mapQueue.keySet()){
                WrapperQueue wrap = new WrapperQueue();
                wrap.groupId = mapQueue.get(grpName);
                wrap.groupName = grpName;
                lstwrap.add(wrap);
            }
            
            return lstwrap;
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
            return null;
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<GroupMember> onChangeQueue(String groupId){
        List<GroupMember> grpMemLst = new List<GroupMember>();
        for(GroupMember member : [SELECT Id,UserOrGroupId FROM GroupMember WHERE GroupId =:groupId]){            
            grpMemLst.add(member);
        }
        return grpMemLst;
    }
    
    public class WrapperQueue{
        @AuraEnabled
        public String groupId {get;set;}
        @AuraEnabled
        public String groupName {get;set;}
    }
}