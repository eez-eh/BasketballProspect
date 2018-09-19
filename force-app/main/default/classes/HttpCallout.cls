public with sharing class HttpCallout implements ICallout {    
    // make a web service calllout 
    public HttpResponse createCallout(String method, String endpoint) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setEndpoint(endpoint);
        HttpResponse response = http.send(request);
        return response;
    }
}