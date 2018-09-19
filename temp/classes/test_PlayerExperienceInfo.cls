@isTest
public class test_PlayerExperienceInfo {
    @testSetup
    static void setup() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
        playerFactory.buildAndInsertRecord();
        SobjectFactory seasonFactory = new test_f_SeasonFactory();
        seasonFactory.buildAndInsertRecords(10);
    }
    @isTest
    static void getPlayerExperienceWhenSeasonEnded() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());

		Test.startTest();
        List<Season__c> seasons = PlayerExperienceInfo.getInstance('123451', sInfoMock).seasons;
        Test.stopTest();
        
        Integer numberOfSeasonsToTrack = 4;
        String nameOfTheFirstSeason = '2012-13';
        String nameOfTheLastSeason = '2015-16';
        system.debug([SELECT Id, Name, Number__c FROM Season__c]);
        System.assertEquals(numberOfSeasonsToTrack, seasons.size(),'a correct number of season records should have been returned');
        System.assertEquals(nameOfTheFirstSeason, seasons[0].Name, 'a correct name of the first season should have been returned');
        System.assertEquals(nameOfTheLastSeason, seasons[seasons.size() - 1].Name,'a correct name of the last season should have been returned');
    }
	@isTest
    static void getPlayerExperienceWhenSeasonIsStillGoing() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoNovemberMock());

		Test.startTest();
        List<Season__c> seasons = PlayerExperienceInfo.getInstance('123451', sInfoMock).seasons;
        Test.stopTest();
        
        Integer numberOfSeasonsToTrack = 5;
        String nameOfTheFirstSeason = '2014-15';
        String nameOfTheLastSeason = '2018-19';
        
        System.assertEquals(numberOfSeasonsToTrack, seasons.size(),'a correct number of season records should have been returned');
        System.assertEquals(nameOfTheFirstSeason, seasons[0].Name, 'a correct name of the first season should have been returned');
        System.assertEquals(nameOfTheLastSeason, seasons[seasons.size() - 1].Name,'a correct name of the last season should have been returned');
    }
}