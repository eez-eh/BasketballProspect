@isTest
private class test_AssembleCallout {
	@isTest
    static void testMakeCallout() {
        IWebServiceFactory mockWebService = (IWebServiceFactory)Test.createStub(IWebServiceFactory.class, new WebServiceFactoryMock());
        AssembleCallout assCall = new AssembleCallout(mockWebService);
        
        Test.startTest();
        List<sObject> objects = assCall.makeCallout();
        Test.stopTest();
        
        System.assertEquals(5, objects.size(), 'a correct number of records should have been returned');
    }
}