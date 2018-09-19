public class ProspectInfo {
	private static ProspectInfo instance = null;
    public Potential_Prospect__c prospect {get; private set;}
    
    private ProspectInfo(String fullName, String team) {
        prospect = [SELECT ExternalID__c FROM Potential_Prospect__c WHERE Full_Name__c =: fullName AND Team__c =: team LIMIT 1];
    }
    
    // lazy load of ProspectInfo instance
    public static ProspectInfo getInstance(String fullName, String team) {
        if (instance == null) instance = new ProspectInfo(fullName, team);
        return instance;
    }
}