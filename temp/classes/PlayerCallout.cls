public class PlayerCallout implements IWebServiceFactory {
    private String externalId;
    
    public PlayerCallout(String externalId) {
        this.externalId = externalId;
    }
    
    public String getMethod() {
        return 'GET';
    }
    
    public INbaEndpoint getEndpoint() {
        return EndpointFactory.getInstance('Player', externalId);    }
    
    public ICallout getHttpCallout() {
        return CalloutFactory.getInstance('Http Callout');
    }
    
    public IReturnedRecords getResponseManager() {
        return ReturnedRecordsFactory.getInstance('Return Player');
    }
}