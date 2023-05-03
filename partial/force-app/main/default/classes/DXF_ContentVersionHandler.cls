//It is not useful now, it was done for S3 integration
public class DXF_ContentVersionHandler {
	
    public static void afterInsert(List<ContentVersion> lstRec){
        Set<Id> contentDocIds = new Set<Id>();
        Map<Id, ContentVersion> mapContentVersion = new Map<Id, ContentVersion>();
        for(ContentVersion cv : lstRec){
            if(cv.ContentDocumentId != NULL){
                contentDocIds.add(cv.ContentDocumentId);
                mapContentVersion.put(cv.ContentDocumentId, cv);                
            }
    	}
    
    	List<ContentDocumentLink> cdLinkList = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId IN:contentDocIds];            
        
        Set<Id> linkedEntityIds = new Set<Id>();
        Map<String, Set<Id>> mapObjectIds = new Map<String, Set<Id>>();
        Map<String, String> mapProject = new Map<String, String>();
        for(ContentDocumentLink cdl : cdLinkList){
            String sobjectType = cdl.LinkedEntityId.getSObjectType().getDescribe().getName();
            mapObjectIds.put(sobjectType, new Set<Id>{cdl.LinkedEntityId});
            linkedEntityIds.add(cdl.LinkedEntityId);
            mapProject.put(cdl.ContentDocumentId, cdl.LinkedEntityId);
        }
        
        Map<String, String> mapWithProjName = new Map<String, String>();
        
        for(Project__c prjlist : [SELECT Id,Name FROM Project__c WHERE Id IN :linkedEntityIds]){
            mapWithProjName.put(prjlist.Id, prjlist.Id);
        }
        system.debug(mapWithProjName);
        for(Id contentId : mapContentVersion.keyset()){
            if(mapProject.containsKey(contentId)){
             //   DXF_AmazonIntegration.putFileInS3FromObject(contentId,mapWithProjName, mapProject);
            }
        }        
    }
    public static void afterDelete(List<ContentVersion> lstRec){
        
    }
}