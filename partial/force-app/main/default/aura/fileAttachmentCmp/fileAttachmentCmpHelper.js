({
	refreshView : function(component, event, helper) {
		var action = component.get("c.appCustomWrapListMthd"); 
        
        action.setCallback(this, function(response){
            var state = response.getState();
            //alert(state);
            if(state=='SUCCESS'){
                var result = response.getReturnValue();
               // alert('result ' + JSON.stringify(result));
                component.set('v.wrapListItems',result);
            }
        });
        $A.enqueueAction(action);
	}
})