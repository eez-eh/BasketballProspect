@isTest
private class test_NewProspectController {
	@isTest
    static void testGetExternalPlayerId() {
        SObjectFactory prospectFactory = new test_f_PotentialProspectFactory();
        Potential_Prospect__c prospect = (Potential_Prospect__c)prospectFactory.buildAndInsertRecord();
        
        Test.startTest();
        String retVal = page_NewProspectController.getExternalPlayerID(prospect.First_Name__c + ' ' + prospect.Name, prospect.Team__c);
        Test.stopTest();
        
        System.assertEquals(prospect.ExternalID__c, retVal, 'a correct external id value should have been returned');
    }
    @isTest
    static void testPlayerCallout() {
        Test.setMock(HttpCalloutMock.class, new CalloutMocks.PlayerHttpCalloutMock());
        
        Test.startTest();
        Player__c player = page_NewProspectController.playerCallout('203112');
        Test.stopTest();
        
        String playerToString = 'Player__c:{First_Name__c=Quincy, Name=Acy, Team_Abbreviation__c=BKN, Team_Name__c=Brooklyn Nets, ' +
            					'ExternalID__c=203112, Birthdate__c=1990-10-06 00:00:00, Country__c=USA, Height__c=6ft 7in, ' +
                				'Position__c=Forward, School__c=Baylor, Season_Experience__c=6, Weight__c=240lbs}';
        
        System.assertEquals(playerToString, String.valueOf(player), 'a response should have been correctly deserialized');
    }
    @isTest
    static void testDeleteProspect() {
        SObjectFactory prospectFactory = new test_f_PotentialProspectFactory();
        Potential_Prospect__c prospect = (Potential_Prospect__c)prospectFactory.buildAndInsertRecord();
        
        Test.startTest();
        page_NewProspectController.deleteProspect(prospect.ExternalID__c);
        Test.stopTest();
        
        Integer numOfProspects = [SELECT Count() FROM Potential_Prospect__c];
        
        System.assertEquals(0, numOfProspects, 'there should not have been any prospect records');
    }
    @isTest
    static void testGameCallout() {
        SObjectFactory playerFactory = new test_f_PlayerShortExpFactory();
        Player__c player = (Player__c)playerFactory.buildAndInsertRecord();
        SObjectFactory seasonFactory = new test_f_SeasonFactory();
        List<Season__c> seasons = (List<Season__c>)seasonFactory.buildAndInsertRecords(Integer.valueOf(player.Season_Experience__c) + 10);
        Test.setMock(HttpCalloutMock.class, new CalloutMocks.GamesHttpCalloutMock());
        
        Test.startTest();
        page_NewProspectController.gameCallout(player.ExternalID__c, player.Id);
        Test.stopTest();
        
        Integer numbOfGames = [SELECT Count() FROM Game__c];
        System.assertEquals(4, numbOfGames, 'a correct number of game records should have been inserted to the database');
    }
}