({
	onInit : function(component) {
        var self = this;
        var playerId = component.get("v.playerId");
		var action = component.get("c.getCurrentSeasonId");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var seasonId = response.getReturnValue();
                component.set("v.seasonId", seasonId);
                self.queryGames(component, playerId, seasonId);
            }
        })
        $A.enqueueAction(action);
	},
    seasonSelect : function(component, event) {
        var self = this;
		var seasonId = event.getParam("seasonId");
        var playerId = component.get("v.playerId");
        component.set("v.seasonId", seasonId);
        self.queryGames(component, playerId, seasonId);
    },
    queryGames : function(component, playerId, seasonId) {
        var action = component.get("c.getGames");
        action.setParams({
            "playerId" : playerId,
            "seasonId" : seasonId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var games = response.getReturnValue();
                component.set("v.seasonAvg", games[0]);
                games.shift();
                component.set("v.games", games);
                games.splice(5);
                component.set("v.lastGames", games);
            }
        });
        $A.enqueueAction(action);
    }
})