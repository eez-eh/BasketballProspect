public class AssembleCallout {
	private String method;
    private INbaEndpoint nbaEndpoint;
    private ICallout httpCallout;
    private IReturnedRecords responseManager;
    
    public AssembleCallout(IWebServiceFactory ws) {
        method = ws.getMethod();
        nbaEndpoint = ws.getEndpoint();
        httpCallout = ws.getHttpCallout();
        responseManager = ws.getResponseManager();
    }
    
    public List<sObject> makeCallout() {
        List<sObject> objects = null;
        String endpoint = nbaEndpoint.createEndpoint();
        HttpResponse response = httpCallout.createCallout(method, endpoint);
        
        if (response.getStatusCode() == 200) {
        	objects = responseManager.manageReturnedRecords(response); 
        } else {
            system.debug(response.getBody());
        }
        return objects;
    }
}