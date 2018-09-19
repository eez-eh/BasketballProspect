@isTest
public class test_f_HttpResponseFactory {
	// Prospects response
    public static HttpResponse getProspects() {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"resource":"commonallplayers","parameters":{"LeagueID":"00","Season":"2017-18","IsOnlyCurrentSeason":1},"resultSets":' +
                         '[{"name":"CommonAllPlayers","headers":["PERSON_ID","DISPLAY_LAST_COMMA_FIRST","DISPLAY_FIRST_LAST","ROSTERSTATUS",' +
                         '"FROM_YEAR","TO_YEAR","PLAYERCODE","TEAM_ID","TEAM_CITY","TEAM_NAME","TEAM_ABBREVIATION","TEAM_CODE","GAMES_PLAYED_FLAG"],' +
                         '"rowSet":[[123451,"Player1, Test","Test Player1",1,"2013","2018","test_player1",1610612760,"Test","Team","TST",' +
                         '"team","Y"],[203112,"Acy, Quincy","Quincy Acy",1,"2012","2018","quincy_acy",1610612751,"Brooklyn","Nets","BKN","nets","Y"],' +
                         '[203500,"Adams, Steven","Steven Adams",1,"2013","2018","steven_adams",1610612760,"Oklahoma City","Thunder","OKC","thunder","Y"]]}]}');
        response.setStatusCode(200);
        return response;
    }
    // Prospects response with the same external Ids
    public static HttpResponse getProspectsWithErrors() {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"resource":"commonallplayers","parameters":{"LeagueID":"00","Season":"2017-18","IsOnlyCurrentSeason":1},"resultSets":' +
                         '[{"name":"CommonAllPlayers","headers":["PERSON_ID","DISPLAY_LAST_COMMA_FIRST","DISPLAY_FIRST_LAST","ROSTERSTATUS",' +
                         '"FROM_YEAR","TO_YEAR","PLAYERCODE","TEAM_ID","TEAM_CITY","TEAM_NAME","TEAM_ABBREVIATION","TEAM_CODE","GAMES_PLAYED_FLAG"],' +
                         '"rowSet":[[123451,"Player1, Test","Test Player1",1,"2013","2018","test_player1",1610612760,"Test","Team","TST",' +
                         '"team","Y"],[123451,"Acy, Quincy","Quincy Acy",1,"2012","2018","quincy_acy",1610612751,"Brooklyn","Nets","BKN","nets","Y"],' +
                         '[123451,"Adams, Steven","Steven Adams",1,"2013","2018","steven_adams",1610612760,"Oklahoma City","Thunder","OKC","thunder","Y"]]}]}');
        response.setStatusCode(200);
        return response;
    }
    // Player response
    public static HttpResponse getPlayer() {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"resource":"commonplayerinfo","parameters":[{"PlayerID":203112},{"LeagueID":null}],"resultSets":[{"name":"CommonPlayerInfo",' +
                         '"headers":["PERSON_ID","FIRST_NAME","LAST_NAME","DISPLAY_FIRST_LAST","DISPLAY_LAST_COMMA_FIRST","DISPLAY_FI_LAST","BIRTHDATE",' +
                         '"SCHOOL","COUNTRY","LAST_AFFILIATION","HEIGHT","WEIGHT","SEASON_EXP","JERSEY","POSITION","ROSTERSTATUS","TEAM_ID","TEAM_NAME",' +
                         '"TEAM_ABBREVIATION","TEAM_CODE","TEAM_CITY","PLAYERCODE","FROM_YEAR","TO_YEAR","DLEAGUE_FLAG","GAMES_PLAYED_FLAG","DRAFT_YEAR",' +
                         '"DRAFT_ROUND","DRAFT_NUMBER"],"rowSet":[[203112,"Quincy","Acy","Quincy Acy","Acy, Quincy","Q. Acy","1990-10-06T00:00:00","Baylor",' +
                         '"USA","Baylor/USA","6-7","240",6,"13","Forward","Active",1610612751,"Nets","BKN","nets","Brooklyn","quincy_acy",2012,2018,"Y","Y",' +
                         '"2012","2","37"]]},{"name":"PlayerHeadlineStats","headers":["PLAYER_ID","PLAYER_NAME","TimeFrame","PTS","AST","REB","PIE"],' +
                         '"rowSet":[[203112,"Quincy Acy","2017-18",5.900000,0.800000,3.700000,0.057]]},{"name":"AvailableSeasons","headers":["SEASON_ID"],' +
                         '"rowSet":[["12012"],["22012"],["12013"],["22013"],["12014"],["22014"],["12015"],["22015"],["12016"],["22016"],["12017"],["22017"]]}]}');
        response.setStatusCode(200);
        return response;
    }
    // Games response
    public static HttpResponse getGames() {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"resource":"playergamelog","parameters":{"PlayerID":203112,"LeagueID":null,"Season":"2017-18","SeasonType":"Regular Season","DateFrom":' +
                         'null,"DateTo":null},"resultSets":[{"name":"PlayerGameLog","headers":["SEASON_ID","Player_ID","Game_ID","GAME_DATE","MATCHUP","WL","MIN",' +
                         '"FGM","FGA","FG_PCT","FG3M","FG3A","FG3_PCT","FTM","FTA","FT_PCT","OREB","DREB","REB","AST","STL","BLK","TOV","PF","PTS","PLUS_MINUS",' +
                         '"VIDEO_AVAILABLE"],"rowSet":[["22017",203112,"0021701219","APR 11, 2018","BKN @ BOS","L",24,3,6,0.500,2,5,0.400,0,0,0.000,1,4,5,1,1,1,1,2,8,-4,1],' +
                         '["22017",203112,"0021701205","APR 09, 2018","BKN vs. CHI","W",20,2,4,0.500,1,2,0.500,0,0,0.000,1,3,4,0,2,0,0,2,5,2,1],["22017",203112,"0021701193",' +
                         '"APR 07, 2018","BKN @ CHI","W",23,7,14,0.500,6,13,0.462,1,2,0.500,0,3,3,1,0,1,0,4,21,11,1]]}]}');
        response.setStatusCode(200);
        return response;
    }
}