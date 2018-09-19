public with sharing class NewProspectController {
	@AuraEnabled
    public static String getExternalPlayerID(String fullName, String team) {
        String result;
        List<Potential_Prospect__c> selectedPlayer = [SELECT ExternalID__c FROM Potential_Prospect__c WHERE Full_Name__c =: fullName AND Team__c =: team];
        if (selectedPlayer.size() == 1) {
            result = selectedPlayer[0].ExternalID__c;
        }
        return result;
    }
    @AuraEnabled
    public static PlayerResponse playerCallout(String externalId) {
        try {
			String endpoint = 'https://stats.nba.com/stats/commonplayerinfo/?PlayerId=' + externalId;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint(endpoint);
            HttpResponse response = http.send(request);
            PlayerResponse playerRsp = (PlayerResponse)JSON.deserialize(response.getBody(), PlayerResponse.class);
            return playerRsp;
        } catch (Exception e) {
            String message = 'Error: ' + e.getMessage();
            AuraHandledException auraError = new AuraHandledException(message);
            auraError.setMessage(message);
            throw auraError;
        }
    }
    @AuraEnabled
    public static void deleteProspect(String externalId) {
        List<Potential_Prospect__c> playerToDelete = [SELECT Id FROM Potential_Prospect__c WHERE ExternalID__c =: externalId];
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
    public static void gameCallout(String externalId, String seasonExp) {
        try {
            Integer i = 0;
            Integer numberOfSeasons = HttpCalloutHelper.getNumberOfSeasonsToTrack(seasonExp);
            Player__c player = HttpCalloutHelper.getPlayerByExtId(externalId);
            Map<String, Season__c> mapSeasons = HttpCalloutHelper.getSeasonsToTrack(numberOfSeasons);
            List<Game__c> games = new List<Game__c>();
            Set<Id> seasonsIds = new Set<Id>();
            do {
                String currentSeason = HttpCalloutHelper.getSeason(i);
                String endpoint = 'https://stats.nba.com/stats/playergamelog/?PlayerID=' +
                    externalId + '&Season=' + currentSeason + '&SeasonType=Regular%20Season';
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(endpoint);
                request.setMethod('GET');
                HttpResponse response = http.send(request);
                GameResponse gameRsp = (GameResponse)JSON.deserialize(response.getBody(), GameResponse.class);
                if (response.getStatusCode() == 200) {
                    List<List<String>> rows = gameRsp.resultSets[0].rowSet;
                    for (List<String> row : rows) {
                        Game__c newGame = new Game__c(
                            Plus_minus__c = Integer.valueOf(row[25]),
                            AST__c = Integer.valueOf(row[19]),
                            BLK__c = Integer.valueOf(row[21]),
                            DREB__c = Integer.valueOf(row[17]),
                            FG__c = Decimal.valueOf(row[9]),
                            FG3__c = Decimal.valueOf(row[12]),
                            FG3A__c = Integer.valueOf(row[11]),
                            FG3M__c = Integer.valueOf(row[10]),
                            FGA__c = Integer.valueOf(row[8]),
                            FGM__c = Integer.valueOf(row[7]),
                            FT__c = Decimal.valueOf(row[15]),
                            FTA__c = Integer.valueOf(row[14]),
                            FTM__c = Integer.valueOf(row[13]),
                            Game_Date__c = row[3],
                            Name = row[4],
                            GameId__c = row[2]+row[1],
                            MIN__c = Integer.valueOf(row[6]),
                            OREB__c = Integer.valueOf(row[16]),
                            PF__c = Integer.valueOf(row[23]),
                            Player__c = player.Id,
                            PTS__c = Integer.valueOf(row[24]),
                            REB__c = Integer.valueOf(row[18]),
                            Season__c = mapSeasons.get(currentSeason).Id,
                            STL__c = Integer.valueOf(row[20]),
                            TOV__c = Integer.valueOf(row[22]),
                            W_L__c = row[5]
                        );
                        games.add(newGame);
                        seasonsIds.add(mapSeasons.get(currentSeason).Id);
                    }                
                } else {
                    System.debug('something goes wrong');
                }
                i++;
            } while(i <= numberOfSeasons);
            // upsert games based on externalId concatenated with playerId
            database.upsert(games, Game__c.Fields.GameId__c);
            // add season average game records
            List<Game__c> seasonStats = HttpCalloutHelper.getSeasonAverageStats(seasonsIds, player.Id);
            database.upsert(seasonStats, Game__c.Fields.GameId__c);
        } catch (Exception e) {
            String message = 'Error: ' + e.getMessage();
            AuraHandledException auraError = new AuraHandledException(message);
            auraError.setMessage(message);
            throw auraError;
        }
    }
}