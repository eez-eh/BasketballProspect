public with sharing class page_DetailCardsController {
	@AuraEnabled
    public static Id getCurrentSeasonId() {
        SeasonInfo sInfo = new SeasonInfo(Date.today());
        
        if (Test.isRunningTest()) {
            sInfo = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        } 
        String currentSeason = sInfo.getCurrentSeasonName();
        Season__c season = [SELECT Id FROM Season__c WHERE Name = :currentSeason LIMIT 1];
        return season.Id;
    }
    
    @AuraEnabled
    public static List<Game__c> getGames(Id playerId, Id seasonId) {
        List<Game__c> games = [SELECT Plus_minus__c, AST__c, BLK__c, DREB__c, FG__c,
                              FG3__c, FG3A__c, FG3M__c, FGA__c, FGM__c, FT__c, FTA__c,
                              FTM__c, Game_Date__c, Name, MIN__c, OREB__c, PF__c,
                              PTS__c, REB__c, STL__c, TOV__c, W_L__c, Number_of_Games__c 
                              FROM Game__c
                              WHERE Player__c = :playerId AND Season__c = :seasonId ORDER BY Game_Date__c DESC];
        return games;
    }
}