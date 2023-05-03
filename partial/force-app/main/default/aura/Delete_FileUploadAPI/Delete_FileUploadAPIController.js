({
	doInit : function(component, event, helper) {
		var action = component.get("c.calloutFromAura");
        action.setParams({
            recId: component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                console.log(response.getReturnValue());
               // component.set('v.countries', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})