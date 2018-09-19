public class GamesCallout implements IWebServiceFactory {
    private String externalId;
    private String playerId;
    private String seasonId;
    private Integer yearsAgo;
    
    public GamesCallout(String externalId, String playerId, String seasonId, Integer yearsAgo) {
        this.externalId = externalId;
        this.playerId = playerId;
        this.seasonId = seasonId;
        this.yearsAgo = yearsAgo;
    }
    
    public String getMethod() {
        return 'GET';
    }
    
    public INbaEndpoint getEndpoint() {
        return EndpointFactory.getInstance('Games', externalId, yearsAgo);
    }
    
    public ICallout getHttpCallout() {
        return CalloutFactory.getInstance('Http Callout');
    }
    
    public IReturnedRecords getResponseManager() {
        return ReturnedRecordsFactory.getInstance('Return Games', playerId, seasonId);
    }
}