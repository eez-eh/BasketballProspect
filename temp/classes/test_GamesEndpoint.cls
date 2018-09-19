@isTest
private class test_GamesEndpoint {
	@isTest
    static void testCreateEndpoint() {
        String externalId = '12345';
        Integer yearsAgo = 0;
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        GamesEndpoint gEndpoint = new GamesEndpoint(externalId, yearsAgo, sInfoMock);
        
        Test.startTest();
        String returnedEndpoint = gEndpoint.createEndpoint();
        Test.stopTest();
        
        String expectedEndpoint = 'https://stats.nba.com/stats/playergamelog/?PlayerID=12345&Season=2015-16&SeasonType=Regular%20Season';
        
        System.assertEquals(expectedEndpoint, returnedEndpoint, 'a returned string should have been correctly created');
    }
}