({
	createPlayerProfile : function(component) {
        component.set("v.isLoading", true);
        var self = this;
        var action = component.get("c.getExternalPlayerID");
        action.setParams({
        	team: component.find('team').get('v.value'),
            fullName: component.find('fullName').get('v.value')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
            	var playerId = response.getReturnValue();
            	self.makePlayerCallout(component, playerId); 
            }
        })
        $A.enqueueAction(action);
	}, 
    makePlayerCallout : function(component, playerId) {
        var self = this;
        var action = component.get("c.playerCallout");
        action.setParams({
            externalId: playerId
        })
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var profile = response.getReturnValue();
                component.set("v.newPlayerRecord.First_Name__c", profile.First_Name__c);
                component.set("v.newPlayerRecord.Name", profile.Name);
                component.set("v.newPlayerRecord.Team_Abbreviation__c", profile.Team_Abbreviation__c);
                component.set("v.newPlayerRecord.Team_Name__c", profile.Team_Name__c);
                component.set("v.newPlayerRecord.ExternalID__c", profile.ExternalID__c);
                component.set("v.newPlayerRecord.Birthdate__c", profile.Birthdate__c);
                component.set("v.newPlayerRecord.Country__c", profile.Country__c);
                component.set("v.newPlayerRecord.Height__c", profile.Height__c);
                component.set("v.newPlayerRecord.Position__c", profile.Position__c);
                component.set("v.newPlayerRecord.School__c", profile.School__c);
                component.set("v.newPlayerRecord.Season_Experience__c", profile.Season_Experience__c);
                component.set("v.newPlayerRecord.Weight__c", profile.Weight__c);
                var tempRec = component.find("forceRecord");
                tempRec.saveRecord($A.getCallback(function(result) {
                    console.log(result.state);
                    if (result.state === "SUCCESS") {
                        // Create games records
                        var recId = result.recordId;
                        self.createGames(component, playerId, recId);
                    } else {
                        console.log('Unknown problem, state: ' + result.state + ', error: ' + JSON.stringify(result.error));
                        component.set("v.isLoading", false);
                    }
                }))
            }
        })
        $A.enqueueAction(action);
    },
    navigateTo : function(component, recId) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recId
        });
        navEvt.fire();
    },
    createGames : function(component, extId, recId) {
        var self = this;
        var action = component.get("c.gameCallout");
        action.setParams({
            "externalId": extId,
            "playerId": recId 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resultsToast = $A.get("e.force:showToast");
            if (component.isValid() && state === "SUCCESS") {
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "Records are successfully saved."
                });
                resultsToast.fire();
                self.deleteProspect(component, extId);
                console.log("Games added successfuly");
                // Navigate to new record page
                self.navigateTo(component, recId);
            } else if (result.state === "ERROR") {
                resultsToast.setParams({
                    "title": "Error",
                    "message": "There was an error saving the record: " + JSON.stringify(result.error)
                });
                resultsToast.fire();
            }
            component.set("v.isLoading", false);
        })
        $A.enqueueAction(action);
    },
    deleteProspect : function(component, extId) {
        var action = component.get("c.deleteProspect");
        action.setParams({
            "externalId": extId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
            	console.log("Prospect record deleted successfuly") 
            }
        })
        $A.enqueueAction(action);
    }
})