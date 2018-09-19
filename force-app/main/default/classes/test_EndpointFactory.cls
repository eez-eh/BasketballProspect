@isTest
private class test_EndpointFactory {
    @isTest
    static void testGetInstance() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
       	Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        
        Test.startTest();
        INbaEndpoint prospectsInstance = EndpointFactory.getInstance('Prospects');
        INbaEndpoint playerInstance = EndpointFactory.getInstance('Player', player.ExternalId__c);
        INbaEndpoint gamesInstance = EndpointFactory.getInstance('Games', player.ExternalId__c, 0);
        INbaEndpoint nullInstance = EndpointFactory.getInstance('test');
        Test.stopTest();
        
        System.assertEquals(true, prospectsInstance instanceOf ProspectsEndpoint, 'correct type of instance should have been returned');
        System.assertEquals(true, playerInstance instanceOf PlayerEndpoint, 'correct type of instance should have been returned');
        System.assertEquals(true, gamesInstance instanceOf GamesEndpoint, 'correct type of instance should have been returned');
        System.assertEquals(null, nullInstance, 'null value should have been returned');
    }
}