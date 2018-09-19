@isTest
public class test_ReturnedProspects {
	@testSetup
    static void setup() {
        SObjectFactory playerFactory = new test_f_PlayerFactory();
        playerFactory.buildAndInsertRecords(3);
    }
    @isTest
    static void testManageReturnedRecords() {
        HttpResponse response = test_f_HttpResponseFactory.getProspects();
        ReturnedProspects retProsp = new ReturnedProspects();
        
        Test.startTest();
        List<Potential_Prospect__c> prospects = retProsp.manageReturnedRecords(response);
        Test.stopTest();
        
        Integer numbOfProspects = 2;
        String prospectToString = 'Potential_Prospect__c:{Name=Acy, Team__c=Brooklyn Nets, From_Year__c=2012, ExternalID__c=203112, First_Name__c= Quincy}';
        
        System.assertEquals(numbOfProspects, prospects.size(), 'there should have been 2 potential prospect records');
        System.assertEquals(prospectToString, String.valueOf(prospects[0]), 'a response should have been correctly deserialized');
    }
}