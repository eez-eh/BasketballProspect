@isTest
private class test_PlayerCallout {
	@isTest
    static void testGetMethods() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
       	Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        IWebServiceFactory playerCallout = new PlayerCallout(player.ExternalId__c);
        
        Test.startTest();
        String method = playerCallout.getMethod();
        INbaEndpoint endpoint = playerCallout.getEndpoint();
        ICallout callout = playerCallout.getHttpCallout();
        IReturnedRecords returnedRecords = playerCallout.getResponseManager();
        Test.stopTest();
        
        System.assertEquals('GET', method, 'correct method should have been returned');
        System.assertEquals(true, endpoint instanceOf PlayerEndpoint, 'correct type of instance should have been returned');
        System.assertEquals(true, callout instanceOf HttpCallout, 'correct type of instance should have been returned');
        System.assertEquals(true, returnedRecords instanceOf ReturnedPlayer, 'correct type of instance should have been returned');
    }
}