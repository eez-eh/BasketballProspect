public class PlayerExperienceInfo {
	private static PlayerExperienceInfo instance = null;
    public List<Season__c> seasons {get; private set;}
    
    private PlayerExperienceInfo(String externalId, SeasonInfo sInfo) {
        seasons = new List<Season__c>();
        getListOfSeasonsToTrack(externalId, sInfo);
    }
    
    private void getListOfSeasonsToTrack(String externalId, SeasonInfo sInfo) {
        // get the starting year of the player's first season
        Player__c player = [SELECT Season_Experience__c FROM Player__c WHERE ExternalID__c = :externalId LIMIT 1];
        // get a number of seasons to track based on player's experiance
        Integer numberOfFullSeasons = Integer.valueOf(player.Season_Experience__c);
        List<String> seasonsNames = new List<String>();
        
        for (Integer i = 0; i < numberOfFullSeasons; i++) {
            seasonsNames.add(sInfo.getSeasonName(i));
        }
        // include one more season if current one is still going
        if (!sInfo.isSeasonEnded()) {
            seasonsNames.add(sInfo.getSeasonName(numberOfFullSeasons));
        }
        // create list of all seasons to track  
        seasons = [SELECT Id, Name, Number__c FROM Season__c WHERE Name IN :seasonsNames];
    }
    
    // lazy load of PlayerExperienceInfo instance
    public static PlayerExperienceInfo getInstance(String externalId, SeasonInfo sInfo) {
        if (instance == null) instance = new PlayerExperienceInfo(externalId, sInfo);
        return instance;
    }
}