public with sharing class page_TeamPicklistController {
	@AuraEnabled
    // Get all team names
    public static List<String> getPicklistValues() {
        Set<String> picklistSet = new Set<String>();
        List<String> picklistToReturn = new List<String>();
        // Populate set with team names
        for (Potential_Prospect__c prospect : [SELECT Team__c FROM Potential_Prospect__c]) {
            picklistSet.add(prospect.Team__c);
        }
        
        // Players without a team can't be tracked
		picklistSet.remove(null);
        // Return sorted list of teams
        picklistToReturn.addAll(picklistSet);
        picklistToReturn.sort();
        
        return picklistToReturn;
    }   
}