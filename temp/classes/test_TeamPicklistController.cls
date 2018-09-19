@isTest
private class test_TeamPicklistController {
	@isTest
    static void testGetPicklistValues() {
        SObjectFactory prospectFactory = new test_f_PotentialProspectFactory();
        List<Potential_Prospect__c> prospects = (List<Potential_Prospect__c>)prospectFactory.buildAndInsertRecords(10);
        String team = prospects[0].Team__c;
        
        Test.startTest();
        List<String> teams = page_TeamPicklistController.getPicklistValues();
        Test.stopTest();
        
        System.assertEquals(team, teams[0], 'a correct team name should have been returned');
        System.assertEquals(1, teams.size(), 'a correcut number of strings should have been returned');
    }
}