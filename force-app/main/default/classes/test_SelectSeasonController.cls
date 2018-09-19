@isTest
private class test_SelectSeasonController {
	@isTest
    static void testGetSeasons() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
        Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        SObjectFactory seasonFactory = new test_f_SeasonFactory();
        seasonFactory.buildAndInsertRecords(Integer.valueOf(player.Season_Experience__c) + 1);
        
        Test.startTest();
        List<Season__c> seasons = page_SelectSeasonController.getSeasons(player.Id);
        Test.stopTest();
        
        System.assertEquals(player.Season_Experience__c, seasons.size(), 'a correct number of the seasons should have been returned');
    }
}