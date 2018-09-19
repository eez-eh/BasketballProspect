({
	doInit : function(component, event, helper) {
		var action = component.get("c.getPicklistValues");
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistTeamValues", list);
        })
        $A.enqueueAction(action);
	}
})