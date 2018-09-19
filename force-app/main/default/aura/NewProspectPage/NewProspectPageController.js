({
	onChange : function(component, event, helper) {
		var teamValue = component.find('team').get('v.value');
        component.set('v.selectedTeam', teamValue);
	},
    addPlayer : function(component, event, helper) {
        helper.createPlayerProfile(component);
    },
    doInit : function(component, event, helper) {
        component.find("forceRecord").getNewRecord(
        	"Player__c",
        	null,
        	false,
            $A.getCallback(function() {
                var record = component.get("v.newPlayer");
                var error = component.get("v.recordError");
                if (error || (record === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized");
            }))
    },
    cancelDialog : function(component, event, helper) {
        var homeEvt = $A.get("e.force:navigateToObjectHome");
        homeEvt.setParams({
            "scope": "Player__c"
        });
        homeEvt.fire();
    }
})