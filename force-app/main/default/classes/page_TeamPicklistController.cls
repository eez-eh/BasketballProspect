public with sharing class page_TeamPicklistController {
	@AuraEnabled
    public static List<String> getPicklistValues() {
        Set<String> picklistSet = new Set<String>();
        List<String> picklistToReturn = new List<String>();
        
        for (Potential_Prospect__c prospect : [SELECT Team__c FROM Potential_Prospect__c]) {
            picklistSet.add(prospect.Team__c);
        }
        // Players without a team can't be tracked
		picklistSet.remove(null);
        picklistToReturn.addAll(picklistSet);
        picklistToReturn.sort();
        
        return picklistToReturn;
    }   
}