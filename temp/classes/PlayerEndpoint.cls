public class PlayerEndpoint implements INbaEndpoint {
    private String externalId;
    
    public PlayerEndpoint(String externalId) {
        this.externalId = externalId;
    }
    // create endpoint
    public String createEndpoint() {
        String endpoint = 'https://stats.nba.com/stats/commonplayerinfo/?PlayerId=' + externalId;
        return endpoint;
    }
}