public class GamesEndpoint implements INbaEndpoint {
    private SeasonInfo sInfo;
    private String externalId;
    private Integer yearsAgo;
    
    public GamesEndpoint(String externalId, Integer yearsAgo, SeasonInfo sInfo) {
        this.externalId = externalId;
        this.sInfo = sInfo;
        this.yearsAgo = yearsAgo;
    }
    // create endpoint
    public String createEndpoint() {
        String currentSeasonName = sInfo.getSeasonName(yearsAgo);
        String endpoint = 'https://stats.nba.com/stats/playergamelog/?PlayerID=' +
                    externalId + '&Season=' + currentSeasonName + '&SeasonType=Regular%20Season';
        return endpoint;
    }
}