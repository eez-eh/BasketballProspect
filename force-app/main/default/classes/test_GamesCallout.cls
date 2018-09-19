@isTest
private class test_GamesCallout {
	@isTest
    static void testGetMethods() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
       	Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        SObjectFactory seasonFactory = new test_f_SeasonFactory();
        Season__c season = (Season__c)seasonFactory.buildAndInsertRecord();
        IWebServiceFactory gamesCallout = new GamesCallout(player.ExternalId__c, player.Id, season.Id, 0);
        
        Test.startTest();
        String method = gamesCallout.getMethod();
        INbaEndpoint endpoint = gamesCallout.getEndpoint();
        ICallout callout = gamesCallout.getHttpCallout();
        IReturnedRecords returnedRecords = gamesCallout.getResponseManager();
        Test.stopTest();
        
        System.assertEquals('GET', method, 'correct method should have been returned');
        System.assertEquals(true, endpoint instanceOf GamesEndpoint, 'correct type of instance should have been returned');
        System.assertEquals(true, callout instanceOf HttpCallout, 'correct type of instance should have been returned');
        System.assertEquals(true, returnedRecords instanceOf ReturnedGames, 'correct type of instance should have been returned');
    }
}