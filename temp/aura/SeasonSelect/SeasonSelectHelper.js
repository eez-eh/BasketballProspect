({
	onInit : function(component) {
		var action = component.get("c.getSeasons");
        action.setParams({
            "playerId": component.get("v.playerId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.seasons", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    onChange : function(component) {
        var seasonValue = component.find("season").get("v.value");
        var appEvent = $A.get("e.c:SeasonSelected");
        appEvent.setParams({
            "seasonId" : seasonValue
        })
        appEvent.fire();        
    }
})