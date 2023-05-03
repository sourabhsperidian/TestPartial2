public class wrapperCustomObjCtrCmp {    
   
    public class wrapperCustomClass{
        @AuraEnabled
        public string fileName;
        @AuraEnabled
        public Boolean isPrimary;
        @AuraEnabled
        public string description;
        @AuraEnabled
        public Id recId;
        @AuraEnabled
        public boolean checkAttachFile= false;
        
        public wrapperCustomClass(string fileName, boolean isPrimary, string description, Id recId,boolean checkAttachFile){
         this.fileName = fileName;
         this.isPrimary = isPrimary;
         this.description = description;  
         this.recId = recId;  
         this.checkAttachFile=checkAttachFile;
        }
    }
    
    
    @AuraEnabled
    public static List<wrapperCustomClass> appCustomWrapListMthd(){
       List<Amazon_Files__c> newStudent = new List<Amazon_Files__c>();       
       List<wrapperCustomClass> custWrapObj = new  List<wrapperCustomClass>();
       List<Amazon_Files__c> newStudentView =[Select Id, Name, Is_Primary__c, Description__c From Amazon_Files__c];
        
        Map<Id,contentdocumentlink> projCheckIdDocMap = new Map<Id,contentdocumentlink> ();
        Set<Id> projChecklistIdSet= new Set<Id> ();
        for(Amazon_Files__c de: newStudentView) {
            projChecklistIdSet.add(de.Id);
        }
        List<Contentdocumentlink> listDocs = [select Id,LinkedEntityId from contentdocumentlink where LinkedEntityId IN :projChecklistIdSet
                                              ];
        for(Contentdocumentlink doc: listDocs) {
          projCheckIdDocMap.put(doc.LinkedEntityId, doc); 
        }     
        
        boolean hasAttch= false;
        for(Amazon_Files__c studentObj:newStudentView){
        
            if(projCheckIdDocMap.get(studentObj.Id)!=null){
                hasAttch=true;
                system.debug('hasAttch###' + hasAttch);
                
            }else{
                 hasAttch=false;
            }            
         custWrapObj.add(new wrapperCustomClass(studentObj.Name,studentObj.Is_Primary__c, studentObj.Description__c,studentObj.Id, hasAttch));                       
        }
        return custWrapObj;     
    }
 }