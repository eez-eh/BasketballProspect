@isTest
private class test_CalloutFactory {
    @isTest
    static void testGetInstance() {        
        Test.startTest();
        ICallout httpCalloutInstance = CalloutFactory.getInstance('Http Callout');
        ICallout nullInstance = CalloutFactory.getInstance('test');
        Test.stopTest();
        
        System.assertEquals(true, httpCalloutInstance instanceOf HttpCallout, 'correct type of instance should have been returned');
        System.assertEquals(null, nullInstance, 'null value should have been returned');
    }
}