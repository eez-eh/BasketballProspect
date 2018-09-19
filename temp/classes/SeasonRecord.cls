public with sharing class SeasonRecord {
	private SeasonInfo sInfo;
    private Integer yearsToTrack = 5; // Maximum 5 full seasons can be tracked
    
    public SeasonRecord(SeasonInfo sInfo) {
        this.sInfo = sInfo;
    }
    
    public void createSeasonRecords() {
        Integer currentSeasonYear = Integer.valueOf(sInfo.getCurrentSeasonName().substring(0,4));
        List<Season__c> seasons = new List<Season__c>();
        // Check if a season is still going
        Integer numOfSeasonsToTrack = sInfo.isSeasonEnded() ? yearsToTrack : yearsToTrack + 1;
        
        // Create list of seasons to track and add them to the database
        for (Integer yearsAgo = 0; yearsAgo < numOfSeasonsToTrack; yearsAgo++) {
            Season__c season = new Season__c(
                Name = sInfo.getSeasonName(yearsAgo),
                Number__c = '220' + sInfo.getSeasonName(yearsAgo).substring(2,4));
            seasons.add(season);
        }
        try {
        	database.upsert(seasons, Season__c.Name);
        } catch(DMLException e) {
            system.debug(e.getMessage());
        }
    }
}