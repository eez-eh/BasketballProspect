@isTest
private class test_DetailCardsController {
	@isTest
    static void testGetCurrentSeasonId() {
        SObjectFactory seasonFactory = new test_f_SeasonFactory();
        seasonFactory.buildAndInsertRecords(10);
        
        Test.startTest();
        Id seasonId = page_DetailCardsController.getCurrentSeasonId();
        Test.stopTest();
        
        System.assertNotEquals(true, seasonId == null, 'returned Id should not have been null');
    }
    @isTest
    static void testGetGames() {
        SObjectFactory playerFactory = new test_f_PlayerShortExpFactory();
        Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        SObjectFactory seasonFactory = new test_f_SeasonFactory();
        Season__c season = (Season__c)seasonFactory.buildAndInsertRecord();
        List<Game__c> games = new List<Game__c>();
        for (Integer i = 0; i < 10; i++) {
            Game__c game = new Game__c(
                Name = 'Game' + i,
            	GameId__c = '123' + i,
            	Player__c = player.Id,
            	Season__c = season.Id);
            games.add(game);
        }
        insert games;
        
        
        Test.startTest();
        List<Game__c> returnedGames = page_DetailCardsController.getGames(player.Id, season.Id);
        Test.stopTest();
        
        System.assertEquals(10, returnedGames.size(), 'a correct number of records should have been returned');
    }
}