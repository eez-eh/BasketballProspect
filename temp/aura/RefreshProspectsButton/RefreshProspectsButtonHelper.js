({
	onRefresh : function(component) {
        var self = this;
		var action = component.get("c.prospectsCallout");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                console.log("Prospects added successfuly");
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