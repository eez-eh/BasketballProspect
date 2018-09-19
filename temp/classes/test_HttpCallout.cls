@isTest
private class test_HttpCallout {
	@isTest
    static void testCreateCallout() {
        Test.setMock(HttpCalloutMock.class, new CalloutMocks.ProspectsHttpCalloutMock());
        HttpCallout callout = new HttpCallout();
        
        Test.startTest();
        HttpResponse response = callout.createCallout('GET', 'fakeEndpoint');
        Test.stopTest();
        
        String contentType = 'application/json';
        String expectedResponse = '{"resource":"commonallplayers","parameters":{"LeagueID":"00","Season":"2017-18","IsOnlyCurrentSeason":1},"resultSets":' +
                         		'[{"name":"CommonAllPlayers","headers":["PERSON_ID","DISPLAY_LAST_COMMA_FIRST","DISPLAY_FIRST_LAST","ROSTERSTATUS",' +
                         		'"FROM_YEAR","TO_YEAR","PLAYERCODE","TEAM_ID","TEAM_CITY","TEAM_NAME","TEAM_ABBREVIATION","TEAM_CODE","GAMES_PLAYED_FLAG"],' +
                         		'"rowSet":[[123451,"Player1, Test","Test Player1",1,"2013","2018","test_player1",1610612760,"Test","Team","TST",' +
                         		'"team","Y"],[203112,"Acy, Quincy","Quincy Acy",1,"2012","2018","quincy_acy",1610612751,"Brooklyn","Nets","BKN","nets","Y"],' +
                         		'[203500,"Adams, Steven","Steven Adams",1,"2013","2018","steven_adams",1610612760,"Oklahoma City","Thunder","OKC","thunder","Y"]]}]}';
        Integer expectedStatusCode = 200;
        
        System.assertEquals(contentType, response.getHeader('Content-Type'), 'a response should have correct header');
        System.assertEquals(expectedResponse, response.getBody(), 'a response should have correct body');
        System.assertEquals(expectedStatusCode, response.getStatusCode(), 'a response should have correct status code');
    }
}