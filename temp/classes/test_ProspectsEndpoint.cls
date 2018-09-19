@isTest
private class test_ProspectsEndpoint {
	@isTest
    static void testCreateEndpoint() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        ProspectsEndpoint pEndpoint = new ProspectsEndpoint(sInfoMock);
        
        Test.startTest();
        String returnedEndpoint = pEndpoint.createEndpoint();
        Test.stopTest();
        
        String expectedEndpoint = 'https://stats.nba.com/stats/commonallplayers/?LeagueID=00&Season=2015-16&IsOnlyCurrentSeason=1';
        
        System.assertEquals(expectedEndpoint, returnedEndpoint, 'a returned string should have been correctly created');
    }
}