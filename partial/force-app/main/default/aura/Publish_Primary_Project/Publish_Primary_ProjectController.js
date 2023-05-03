({
	doInit : function(component, event, helper) {
		var action = component.get("c.calloutPrimaryProject");
        action.setParams({
            recId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
           //     component.set('v.countries', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})