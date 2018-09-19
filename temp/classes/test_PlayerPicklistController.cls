@isTest
private class test_PlayerPicklistController {
	@isTest
    static void testGetPicklistValues() {
        SObjectFactory prospectFactory = new test_f_PotentialProspectFactory();
        List<Potential_Prospect__c> prospects = (List<Potential_Prospect__c>)prospectFactory.buildAndInsertRecords(10);
        String team = prospects[0].Team__c;
        
        Test.startTest();
        List<String> retrievedProspects = page_PlayerPicklistController.getPicklistValues(team);
        Test.stopTest();
        
        System.assertEquals(prospects.size(), retrievedProspects.size(), 'a correct number of records names should have been returned');
    }
}