public class ReturnedGames implements IReturnedRecords {
    private String playerId;
    private String seasonId;
        
    public ReturnedGames(String playerId, String seasonId) {
        this.playerId = playerId;
        this.seasonId = seasonId;
    }
    
    public List<Game__c> manageReturnedRecords(HttpResponse response) {
        List<List<String>> rows = deserializeRespone(response);
        List<Game__c> games = new List<Game__c>();
        
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
                Game_Date__c = parseDate(row[3]),
                Name = row[4],
                GameId__c = row[2]+row[1],
                MIN__c = Integer.valueOf(row[6]),
                OREB__c = Integer.valueOf(row[16]),
                PF__c = Integer.valueOf(row[23]),
                Player__c = playerId,
                PTS__c = Integer.valueOf(row[24]),
                REB__c = Integer.valueOf(row[18]),
                Season__c = seasonId,
                STL__c = Integer.valueOf(row[20]),
                TOV__c = Integer.valueOf(row[22]),
                W_L__c = row[5]
            );
            games.add(newGame);
        } 
        return games;
    }  
    
    // Deserialize the response into a list of records 
    private List<List<String>> deserializeRespone(HttpResponse response) {
        GameResponse gamesRsp = (GameResponse)JSON.deserialize(response.getBody(), GameResponse.class);
        return gamesRsp.resultSets[0].rowSet;
    }
    
    // Create Date field from text input
    private Date parseDate(String textDate) {
        String year = textDate.substring(8, 12);
		String month = getMonthNumber(textDate.substring(0, 3));
		String day = textDate.substring(4, 6);
		String fullDate = year + '-' + month + '-' + day;
		return Date.valueOf(fullDate);
    }
    
    // Get month number from abbreviation
    private String getMonthNumber(String abbr) {
        switch on abbr {
            when 'JAN' { return '1'; }
            when 'FEB' { return '2'; }
            when 'MAR' { return '3'; }
            when 'APR' { return '4'; }
            when 'MAY' { return '5'; }
            when 'JUN' { return '6'; }
            when 'JUL' { return '7'; }
            when 'AUG' { return '8'; }
            when 'SEP' { return '9'; }
            when 'OCT' { return '10'; }
            when 'NOV' { return '11'; }
            when 'DEC' { return '12'; }
            when else { 
                system.debug('unexpected month: ' + abbr); 
            	return '0';
            }
        }
    }
}