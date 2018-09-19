@isTest
private class test_ScheduledSeasonUpdate {
	// Dummy CRON expression
	public static String CRON_EXP = '0 0 0 1 11 ? 2020';
    
    @isTest
    static void testScheduledUpdate() {
        Test.startTest();
        String jobId = System.schedule('SeasonUpdateTest', CRON_EXP, new ScheduledSeasonUpdate());
        // verify the season records doesn't exist yet
        List<Season__c> seasonsBeforeRun = [SELECT Id FROM Season__c];
        System.assertEquals(0, seasonsBeforeRun.size(), 'Season records exists before job has run');
        Test.stopTest();
        
        List<Season__c> seasonsAfterRun = [SELECT Id FROM Season__c];
        
        System.assertNotEquals(0, seasonsAfterRun.size(), 'Season records were not created');
    }
}