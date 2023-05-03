({
	doInit : function(component, event, helper) {    
        
	  var action = component.get("c.appCustomWrapListMthd"); 
        
        action.setCallback(this, function(response){
            var state = response.getState();            
            if(state=='SUCCESS'){
                var result = response.getReturnValue();            
                component.set('v.wrapListItems',result);
            }
        });
        $A.enqueueAction(action);        
	},
    
    
    uploadFileAction : function(component, event, helper) {
        var uploadedFiles = event.getParam("files");
        var documentId = uploadedFiles[0].documentId;
        var fileName = uploadedFiles[0].name;
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",   
            "type": "success",
            "message": "File "+fileName+" Uploaded successfully."
        });
        toastEvent.fire();
        $A.get('e.force:refreshView').fire();        
    },
    
    
})