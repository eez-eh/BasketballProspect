@isTest
private class test_ProspectsCallout {
	@isTest
    static void testGetMethods() {
        IWebServiceFactory prospectsCallout = new ProspectsCallout();
        
        Test.startTest();
        String method = prospectsCallout.getMethod();
        INbaEndpoint endpoint = prospectsCallout.getEndpoint();
        ICallout callout = prospectsCallout.getHttpCallout();
        IReturnedRecords returnedRecords = prospectsCallout.getResponseManager();
        Test.stopTest();
        
        System.assertEquals('GET', method, 'correct method should have been returned');
        System.assertEquals(true, endpoint instanceOf ProspectsEndpoint, 'correct type of instance should have been returned');
        System.assertEquals(true, callout instanceOf HttpCallout, 'correct type of instance should have been returned');
        System.assertEquals(true, returnedRecords instanceOf ReturnedProspects, 'correct type of instance should have been returned');
    }
}