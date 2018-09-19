@isTest
private class test_SeasonRecord {
	@isTest
    static void createRecordsWhenMonthIsNovember() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoNovemberMock());
        SeasonRecord sRecord = new SeasonRecord(sInfoMock);
        
        Test.startTest();
        sRecord.createSeasonRecords();
        Test.stopTest();
        
        List<Season__c> upsertedSeasons = [SELECT Id, Name, Number__c FROM Season__c ORDER BY Name ASC];
        
        Integer numberOfSeasons = 6;
        String firstSeasonName = '2013-14';
        String firstSeasonNumber = '22013';
        String currentSeasonName = '2018-19';
        String currentSeasonNumber = '22018';
        
        System.assertEquals(numberOfSeasons, upsertedSeasons.size(), 'a correct number of season records should have been returned');
        System.assertEquals(firstSeasonName, upsertedSeasons[0].Name, 'a correct name of the first season should have been returned');
        System.assertEquals(firstSeasonNumber, upsertedSeasons[0].Number__c, 'a correct number of the first season should have been returned');
        System.assertEquals(currentSeasonName, upsertedSeasons[upsertedSeasons.size()-1].Name, 'a correct name of the current season should have been returned');
        System.assertEquals(currentSeasonNumber, upsertedSeasons[upsertedSeasons.size()-1].Number__c, 'a correct number of the current season should have been returned');
    }
	@isTest
    static void createRecordsWhenMonthIsAugust() {
        SeasonInfo sInfoMock = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        SeasonRecord sRecord = new SeasonRecord(sInfoMock);
        
        Test.startTest();
        sRecord.createSeasonRecords();
        Test.stopTest();
         
        List<Season__c> upsertedSeasons = [SELECT Id, Name, Number__c FROM Season__c ORDER BY Name ASC];
        
        Integer numberOfSeasons = 5;
        String firstSeasonName = '2011-12';
        String firstSeasonNumber = '22011';
        String currentSeasonName = '2015-16';
        String currentSeasonNumber = '22015';
        
        System.assertEquals(numberOfSeasons, upsertedSeasons.size(), 'a correct number of season records should have been returned');
        System.assertEquals(firstSeasonName, upsertedSeasons[0].Name, 'a correct name of the first season should have been returned');
        System.assertEquals(firstSeasonNumber, upsertedSeasons[0].Number__c, 'a correct number of the first season should have been returned');
        System.assertEquals(currentSeasonName, upsertedSeasons[upsertedSeasons.size()-1].Name, 'a correct name of the current season should have been returned');
        System.assertEquals(currentSeasonNumber, upsertedSeasons[upsertedSeasons.size()-1].Number__c, 'a correct number of the current season should have been returned');
    }
}