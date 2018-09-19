({
	refreshProspects : function(component, event, helper) {
		helper.onRefresh(component);
	},
    cancelDialog : function(component, event, helper) {
        var homeEvt = $A.get("e.force:navigateToObjectHome");
        homeEvt.setParams({
            "scope": "Potential_Prospect__c"
        });
        homeEvt.fire();
    }
})