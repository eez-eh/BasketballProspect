public with sharing class page_NewProspectController {
	@AuraEnabled
    // Get palyer's external Id
    public static String getExternalPlayerID(String fullName, String team) {
        Potential_Prospect__c prospect = ProspectInfo.getInstance(fullName, team).prospect;
        return prospect.ExternalId__c;
    }
    @AuraEnabled
    // Make a callout to retrieve player's profile
    public static Player__c playerCallout(String externalId) {
        IWebServiceFactory playerCallout = new PlayerCallout(externalId);
        AssembleCallout callout = new AssembleCallout(playerCallout);
        List<sObject> objects = callout.makeCallout();
        return (Player__c)objects[0];
    }
    @AuraEnabled
    // Detlete player's record from list of potential prospects
    public static void deleteProspect(String externalId) {
        Potential_Prospect__c playerToDelete = [SELECT Id FROM Potential_Prospect__c WHERE ExternalID__c = :externalId LIMIT 1];
        try {
            delete playerToDelete;
        } catch (DMLException e) {
            String message = 'Error: ' + e.getMessage();
            AuraHandledException auraError = new AuraHandledException(message);
            auraError.setMessage(message);
            throw auraError;
        }
    }
    @AuraEnabled
    public static void gameCallout(String externalId, Id playerId) {
        Integer yearsAgo = 0;
        SeasonInfo sInfo = new SeasonInfo(Date.today());
        if (Test.isRunningTest()) {
            sInfo = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        } 
		List<Game__c> games = new List<Game__c>();
        List<Id> seasonsIds = new List<Id>();
        // Get all seasons in which the player appeared (maximum 5 full seasons) 
        List<Season__c> seasonsList = PlayerExperienceInfo.getInstance(externalId, sInfo).seasons;
        // Aggregate all games from selected seasons
        for (Season__c season : seasonsList) {
        	// Get current Season Id
            Id currentSeasonId = season.Id;
            // Make a callout
            IWebServiceFactory gamesCallout = new GamesCallout(externalId, playerId, currentSeasonId, yearsAgo);
            AssembleCallout callout = new AssembleCallout(gamesCallout);
            List<sObject> objects = callout.makeCallout();
            games.addAll((List<Game__c>)objects);
            seasonsIds.add(season.Id);
            yearsAgo++;
        }
        try {
            // Upsert games based on externalId concatenated with playerId
            database.upsert(games, Game__c.Fields.GameId__c);
            // Add season average game records
            List<Game__c> seasonStats = getSeasonAverageStats(seasonsIds, playerId);
            database.upsert(seasonStats, Game__c.Fields.GameId__c);
            system.debug('success');
        } catch (DMLException e) {
            String message = 'Error: ' + e.getMessage();
            AuraHandledException auraError = new AuraHandledException(message);
            auraError.setMessage(message);
            system.debug(message);
            throw auraError;
        }

    }

    // Get season average game records
    private static List<Game__c> getSeasonAverageStats(List<Id> seasonsIds, Id playerId) {
        // Get all seasons map
        Map<Id, Season__c> seasonsMap = new Map<Id, Season__c>([SELECT Id, Name FROM Season__c WHERE Id IN :seasonsIds]);
        // Get average results in every season
        List<AggregateResult> groupedResults = [SELECT Avg(Plus_minus__c), Avg(AST__c), Avg(BLK__c), Avg(DREB__c), Avg(FG__c), Avg(FG3__c), 
                               					Avg(FG3A__c), Avg(FG3M__c), Avg(FGA__c), Avg(FGM__c), Avg(FT__c), Avg(FTA__c), Avg(FTM__c), 
                               					Avg(OREB__c), Avg(PF__c), Avg(PTS__c), Avg(REB__c), Avg(STL__c), Avg(TOV__c), Avg(MIN__c),
                                                Count(W_L__c) FROM Game__c
                               					WHERE Player__c =: playerId AND Season__c IN :seasonsIds GROUP BY Season__c];
        // Create season average records for every season
        List<Game__c> seasonStats = new List<Game__c>();
        for (Integer i = 0; i < seasonsIds.size(); i++) {
            Decimal FG3A = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr6')));
            Decimal FG3M = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr7')));
            Decimal FTA = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr11')));
            Decimal FTM = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr12')));
            Decimal FGA = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr8')));
            Decimal FGM = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr9')));
            
            Game__c seasonAvg = new Game__c(
                Plus_minus__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr0'))),
                AST__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr1'))),
                BLK__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr2'))),
                DREB__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr3'))),
                FG__c = FGA > 0 ? (FGM / FGA) : 0,
                FG3__c = FG3A > 0 ? (FG3M / FG3A) : 0,
                FG3A__c = FG3A,
                FG3M__c = FG3M,
                FGA__c = FGA,
                FGM__c = FGM,
                FT__c = FTA > 0 ? (FTM / FTA) : 0,
                FTA__c = FTA,
                FTM__c = FTM,
                Name = seasonsMap.get(seasonsIds[i]).Name,
                Number_of_Games__c = Integer.valueOf(String.valueOf(groupedResults[i].get('expr20'))),
                GameId__c = seasonsIds[i] + String.valueOf(playerId),
                OREB__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr13'))),
                PF__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr14'))),
                Player__c = playerId,
                PTS__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr15'))),
                REB__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr16'))),
                Season__c = seasonsIds[i],
                STL__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr17'))),
                TOV__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr18'))),
                MIN__c = Integer.valueOf(groupedResults[i].get('expr19'))
        	);
            seasonStats.add(seasonAvg);
        }
        return seasonStats;
    }    
}