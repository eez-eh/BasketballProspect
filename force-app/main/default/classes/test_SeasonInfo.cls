@isTest
private class test_SeasonInfo {
    @isTest
    static void monthIsNovember() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoNovemberMock());
        
        Test.startTest();
        String currentSeason = sInfoMock.getCurrentSeasonName();
        String lastSeason = sInfoMock.getSeasonName(1);
        Boolean isEnded = sInfoMock.isSeasonEnded();
        Test.stopTest();
        
        System.assertEquals('2018-19', currentSeason, 'a correct name of the current season should have been returned');
        System.assertEquals('2017-18', lastSeason, 'a correct name of the last season should have been returned');
        System.assertEquals(false, isEnded, 'a correct information about the duration of the season should have been returned');
    }
    @isTest
    static void monthIsAugust() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        
        Test.startTest();
        String currentSeason = sInfoMock.getCurrentSeasonName();
        String lastSeason = sInfoMock.getSeasonName(1);
        Boolean isEnded = sInfoMock.isSeasonEnded();
        Test.stopTest();
        
        System.assertEquals('2015-16', currentSeason, 'a correct name of the current season should have been returned');
        System.assertEquals('2014-15', lastSeason, 'a correct name of the last season should have been returned');
        System.assertEquals(true, isEnded, 'a correct information about the duration of the season should have been returned');
    }
}