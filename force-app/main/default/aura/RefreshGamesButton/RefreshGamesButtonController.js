({
	refreshGames : function(component, event, helper) {
		var action = component.get("c.gameCallout");
        action.setParams({
            "playerId": component.get("v.recordId"),
            "externalId": component.get("v.player.ExternalID__c")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resultsToast = $A.get("e.force:showToast");
            if (component.isValid() && state === "SUCCESS") {
                 resultsToast.setParams({
                    "title": "Refreshed",
                    "message": "Games has been successfuly refreshed."
                });
                resultsToast.fire();
                $A.get("e.force:closeQuickAction").fire();
                $A.get("e.force:refreshView").fire();
            }
        });
        $A.enqueueAction(action);
	}
})