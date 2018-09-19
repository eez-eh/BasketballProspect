public class HttpCalloutHelper {
	// Returns name of the season
    public static String getSeason(Integer yearsBefore) {
        if (Date.today().month() >= 10) {
            return (Date.today().year() - yearsBefore) + '-' + (Date.today().year() - 1999 - yearsBefore);
        } else {
            return (Date.today().year() - 1 - yearsBefore) + '-' + (Date.today().year() - 2000 - yearsBefore);
        }
    }
    // Return nubmer of seasons to track
    public static Integer getNumberOfSeasonsToTrack(String seasonExp) {
        // If player has no experiance return only current season
        if (seasonExp.equals('0')) {
            return 0;
        }
        // maximum 5 ended seasons can be tracked
        Integer yearsToTrack = Integer.valueOf(seasonExp) > 5 ? 5 : Integer.valueOf(seasonExp);
        // Check if the season ended
        if (Date.today().month() >= 5 && date.today().month() <= 10) {
            yearsToTrack -= 1;
        }
        return yearsToTrack;
    }
    // Return map with seasons records to track
    public static Map<String, Season__c> getSeasonsToTrack(Integer numberOfSeasons) {
        Map<String, Season__c> seasons = new Map<String, Season__c>();
        List<String> years = new List<String>();
        for (Integer i = 0; i <= numberOfSeasons; i++) {
        	years.add(getSeason(i));
        }
        for (Season__c season : [SELECT Id, Year__c, Name FROM Season__c WHERE Year__c IN :years]) {
            seasons.put(season.Year__c, season);
        }
        
        return seasons;
    }
    // Returns player by given External ID
    public static Player__c getPlayerByExtId(String externalId) {
        Player__c player;
        List<Player__c> players = [SELECT Id FROM Player__c WHERE ExternalID__c =: externalId];
        if (players.size() == 1) {
            player = players[0];
        }
        return player;
    }
    // Return player's external ID 
    public static String getPlayerID(String fullName, String team) {
        String externalId;
        List<Potential_Prospect__c> selectedPlayer = [SELECT ExternalID__c FROM Potential_Prospect__c WHERE 
                                      				  Full_Name__c = :fullName AND Team__c = :team];
        if (selectedPlayer.size() == 1) {
            externalId = selectedPlayer[0].ExternalID__c;
        }
        return externalId;
    }
    // Get all seasons
    public static void getSeasons() {
        List<Potential_Prospect__c> longestExp = [SELECT From_Year__c FROM Potential_Prospect__c ORDER BY From_Year__c ASC LIMIT 1];
        List<Season__c> seasons = new List<Season__c>();
        
        // Maximum 5 years tracked
        Integer yearsTracked = longestExp[0].From_Year__c < Date.today().year()-5 ? Date.today().year()-5 : Integer.valueOf(longestExp[0].From_Year__c);
        // Check if season is still going
        if (!(Date.today().month() >= 5 && date.today().month() <= 10)) {
            yearsTracked += 1;
        }
        
        for (Integer i = Integer.valueOf(getSeason(0).substring(0,4)); i >= yearsTracked; i--) {
            Integer yearsBefore = Integer.valueOf(getSeason(0).substring(0,4)) - i; 
            Season__c season = new Season__c(
            	Name = '220' + getSeason(yearsBefore).substring(2,4),
            	Year__c = getSeason(yearsBefore));
            seasons.add(season);
        }
        database.upsert(seasons, Season__c.Name);
    }
    // Get set of currently tracked players
	public static Set<String> getTrackedPlayers() {
        Set<String> palyersExternalId = new Set<String>();
        for (Player__c player : [SELECT ExternalID__c FROM Player__c]) {
            palyersExternalId.add(player.ExternalID__c);
        }
        return palyersExternalId;
    }
	// Create game record with season average stats
    public static List<Game__c> getSeasonAverageStats(Set<Id> seasonsIds, Id playerId) {
        List<Id> seasons = new List<Id>();
        seasons.addAll(seasonsIds);
        seasons.sort();
        Map<Id, Season__c> seasonsMap = new Map<Id, Season__c>([SELECT Id, Year__c FROM Season__c]);
        List<AggregateResult> groupedResults = [SELECT Avg(Plus_minus__c), Avg(AST__c), Avg(BLK__c), Avg(DREB__c), Avg(FG__c), Avg(FG3__c), 
                               					Avg(FG3A__c), Avg(FG3M__c), Avg(FGA__c), Avg(FGM__c), Avg(FT__c), Avg(FTA__c), Avg(FTM__c), 
                               					Avg(OREB__c), Avg(PF__c), Avg(PTS__c), Avg(REB__c), Avg(STL__c), Avg(TOV__c), Avg(MIN__c),
                                                Count(W_L__c) FROM Game__c
                               					WHERE Player__c =: playerId AND Season__c IN :seasons GROUP BY Season__c];
        List<Game__c> seasonStats = new List<Game__c>();
        for (Integer i = 0; i < seasons.size(); i++) {
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
                Name = seasonsMap.get(seasons[i]).Year__c,
                Number_of_Games__c = Integer.valueOf(String.valueOf(groupedResults[i].get('expr20'))),
                GameId__c = seasons[i] + String.valueOf(playerId),
                OREB__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr13'))),
                PF__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr14'))),
                Player__c = playerId,
                PTS__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr15'))),
                REB__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr16'))),
                Season__c = seasons[i],
                STL__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr17'))),
                TOV__c = Decimal.valueOf(String.valueOf(groupedResults[i].get('expr18'))),
                MIN__c = Integer.valueOf(groupedResults[i].get('expr19'))
        	);
            seasonStats.add(seasonAvg);
        }
        return seasonStats;
    }    
}