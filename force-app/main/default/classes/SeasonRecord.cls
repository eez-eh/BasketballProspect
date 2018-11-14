public class SeasonRecord {
	private SeasonInfo sInfo;
    // Maximum 5 full seasons can be tracked
    private Integer yearsToTrack = 5;
    
    public SeasonRecord(SeasonInfo sInfo) {
        this.sInfo = sInfo;
    }
    
    public void createSeasonRecords() {
        Integer currentSeasonYear = Integer.valueOf(sInfo.getCurrentSeasonName().substring(0,4));
        List<Season__c> seasons = new List<Season__c>();
        // If a season is still going, then it should be included
        Integer numOfSeasonsToTrack = sInfo.isSeasonEnded() ? yearsToTrack : yearsToTrack + 1;
        
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