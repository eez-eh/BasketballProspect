public with sharing class page_PlayerPicklistController {
	@AuraEnabled
    // Get all players names by team
    public static List<String> getPicklistValues(String team) {
        List<String> players = new List<String>();
        for (Potential_Prospect__c prospect : [SELECT Full_Name__c FROM Potential_Prospect__c WHERE Team__c = :team]) {
            players.add(prospect.Full_Name__c);
        }
        players.sort();
        
        return players;
    } 
}