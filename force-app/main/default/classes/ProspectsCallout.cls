public class ProspectsCallout implements IWebServiceFactory {
    public String getMethod() {
        return 'GET';
    }
    
    public INbaEndpoint getEndpoint() {
        return EndpointFactory.getInstance('Prospects');
    }
    
    public ICallout getHttpCallout() {
        return CalloutFactory.getInstance('Http Callout');
    }
    
    public IReturnedRecords getResponseManager() {
        return ReturnedRecordsFactory.getInstance('Return Prospects');
    }
}