@isTest
private class test_ReturnedGames {
    @isTest
    static void testManageReturnedRecords() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
        Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        SobjectFactory seasonFactory = new test_f_SeasonFactory();
        Season__c season = (Season__c)seasonFactory.buildAndInsertRecord();
        HttpResponse response = test_f_HttpResponseFactory.getGames();
        ReturnedGames retGames = new ReturnedGames(player.Id, season.Id);
        
        Test.startTest();
        List<Game__c> games = retGames.manageReturnedRecords(response);
        Test.stopTest();
        system.debug(String.valueOf(games[0]));
        Integer numbOfGames = 3;
        String gameToString = 'Game__c:{Plus_minus__c=-4, AST__c=1, BLK__c=1, DREB__c=4, FG__c=0.500, FG3__c=0.400, ' +
            				'FG3A__c=5, FG3M__c=2, FGA__c=6, FGM__c=3, FT__c=0.000, FTA__c=0, FTM__c=0, Game_Date__c=APR 11, 2018, Name=BKN @ BOS, ' +
            				'GameId__c=0021701219203112, MIN__c=24, OREB__c=1, PF__c=2, Player__c=' + player.Id + ', ' +
            				'PTS__c=8, REB__c=5, Season__c=' + season.Id + ', STL__c=1, TOV__c=1, W_L__c=L}';
        
        System.assertEquals(numbOfGames, games.size(), 'there should have been 3 games records');
        System.assertEquals(gameToString, String.valueOf(games[0]), 'a response should have been correctly deserialized');
    }
}