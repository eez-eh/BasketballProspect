public class ProspectsEndpoint implements INbaEndpoint {
    private SeasonInfo sInfo;
    
    public ProspectsEndpoint(SeasonInfo sInfo) {
        this.sInfo = sInfo;
    }
    // create endpoint
    public String createEndpoint() {
        String currentSeasonName = sInfo.getCurrentSeasonName();
        String endpoint = 'https://stats.nba.com/stats/commonallplayers/?LeagueID=00&Season=' + currentSeasonName + '&IsOnlyCurrentSeason=1';
        return endpoint;
    }
}