({
	refreshGames : function(component, event, helper) {
		var action = component.get("c.gameCallout");
        // refreshes current season's games
        action.setParams({
            "seasonExp": "0",
            "externalId": component.get("v.player.ExternalID__c")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                console.log("Games added successfuly");
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
	}
})