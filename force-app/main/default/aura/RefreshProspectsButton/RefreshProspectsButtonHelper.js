({
	onRefresh : function(component) {
        var self = this;
		var action = component.get("c.prospectsCallout");
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resultsToast = $A.get("e.force:showToast");
            if (component.isValid() && state === "SUCCESS") {
                 resultsToast.setParams({
                    "title": "Refreshed",
                    "message": "List of prospects has been successfuly refreshed."
                });
                resultsToast.fire();
                self.navigateTo();
            }
        });
        $A.enqueueAction(action);
	},
    navigateTo : function() {
        var homeEvt = $A.get("e.force:navigateToObjectHome");
        homeEvt.setParams({
            "scope": "Potential_Prospect__c"
        });
        homeEvt.fire();
    }
})