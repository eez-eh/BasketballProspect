@isTest
private class test_PlayerEndpoint {
	@isTest
    static void testCreateEndpoint() {
        String externalId = '12345';
        PlayerEndpoint pEndpoint = new PlayerEndpoint(externalId);
        
        Test.startTest();
        String returnedEndpoint = pEndpoint.createEndpoint();
        Test.stopTest();
        
        String expectedEndpoint = 'https://stats.nba.com/stats/commonplayerinfo/?PlayerId=12345';
        
        System.assertEquals(expectedEndpoint, returnedEndpoint, 'a returned string should have been correctly created');
    }
}