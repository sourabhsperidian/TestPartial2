({
	doInit : function(component, event, helper) {
		var action = component.get("c.calloutFromAura");
        action.setParams({
            recId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
        });
        $A.enqueueAction(action);
	}
})