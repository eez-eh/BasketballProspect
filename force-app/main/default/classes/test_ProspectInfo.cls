@isTest
public class test_ProspectInfo {
    @testSetup
    static void setup() {
        SObjectFactory factory = new test_f_PotentialProspectFactory();
        List<Potential_Prospect__c> prospects = factory.buildAndInsertRecords(3);
    }
    @isTest
    static void getProspectInfo() {
        Test.startTest();
        ProspectInfo pInfo = ProspectInfo.getInstance('Test Player 1', 'TestTeam');
        Test.stopTest();
        
        String externalId = '12345';
        
        System.assertEquals(externalId, pInfo.prospect.ExternalId__c, 'a correct external id of the prospect should have been returned');
    }
}