@isTest
private class test_ReturnedRecordsFactory {
	@isTest
    static void testGetInstance() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
       	sObject player = playerFactory.buildAndInsertRecord();
        SObjectFactory seasonFactory = new test_f_SeasonFactory();
        sObject season = seasonFactory.buildAndInsertRecord();
        
        Test.startTest();
        IReturnedRecords prospectsInstance = ReturnedRecordsFactory.getInstance('Return Prospects');
        IReturnedRecords playerInstance = ReturnedRecordsFactory.getInstance('Return Player');
        IReturnedRecords gamesInstance = ReturnedRecordsFactory.getInstance('Return Games', player.Id, season.Id);
        IReturnedRecords nullInstance = ReturnedRecordsFactory.getInstance('test');
        Test.stopTest();
        
        System.assertEquals(true, prospectsInstance instanceOf ReturnedProspects, 'correct type of instance should have been returned');
        System.assertEquals(true, playerInstance instanceOf ReturnedPlayer, 'correct type of instance should have been returned');
        System.assertEquals(true, gamesInstance instanceOf ReturnedGames, 'correct type of instance should have been returned');
        System.assertEquals(null, nullInstance, 'null value should have been returned');
    }
}