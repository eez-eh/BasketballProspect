public interface IWebServiceFactory {
	String getMethod();
    INbaEndpoint getEndpoint();
    ICallout getHttpCallout();
    IReturnedRecords getResponseManager();
}