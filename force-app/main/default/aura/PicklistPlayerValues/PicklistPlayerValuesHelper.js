({
	onInit : function(component) {
		var action = component.get("c.getPicklistValues");
        action.setParams({
            team: component.get("v.team")
        });
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.picklistPlayerValues", list);
        })
        $A.enqueueAction(action);		
	}
})