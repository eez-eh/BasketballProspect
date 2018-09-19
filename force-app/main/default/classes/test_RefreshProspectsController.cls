@isTest
private class test_RefreshProspectsController {
	@isTest
    static void testCallout() {
        Test.setMock(HttpCalloutMock.class, new CalloutMocks.ProspectsHttpCalloutMock());
        
        Test.startTest();
        page_RefreshProspectsController.prospectsCallout();
        Test.stopTest();
        
        List<Potential_Prospect__c> prospects = [SELECT Id FROM Potential_Prospect__c];
        
        System.assertEquals(3, prospects.size(), 'new prospects should have been inserted to the database');
    }
    @isTest
    static void testCalloutWhenErrors() {
        Test.setMock(HttpCalloutMock.class, new CalloutMocks.ProspectsHttpCalloutMockWithError());
        
        Test.startTest();
        page_RefreshProspectsController.prospectsCallout();
        Test.stopTest();
        
        List<Potential_Prospect__c> prospects = [SELECT Id FROM Potential_Prospect__c];
        
        System.assertNotEquals(3, prospects.size(), 'no prospects should have been inserted to the database');
    }
}