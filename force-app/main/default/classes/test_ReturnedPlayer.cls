@isTest
public class test_ReturnedPlayer {
	@isTest
    static void testManageReturnedRecords() {
        HttpResponse response = test_f_HttpResponseFactory.getPlayer();
        ReturnedPlayer retPlayer = new ReturnedPlayer();
        
        Test.startTest();
        List<Player__c> player = retPlayer.manageReturnedRecords(response);
        Test.stopTest();
        
        Integer numbOfPlayers = 1;
        String playerToString = 'Player__c:{First_Name__c=Quincy, Name=Acy, Team_Abbreviation__c=BKN, Team_Name__c=Brooklyn Nets, ' +
            					'ExternalID__c=203112, Birthdate__c=1990-10-06 00:00:00, Country__c=USA, Height__c=6ft 7in, ' +
                				'Position__c=Forward, School__c=Baylor, Season_Experience__c=6, Weight__c=240lbs}';
        
        System.assertEquals(numbOfPlayers, player.size(), 'there should have been only player record');
        System.assertEquals(playerToString, String.valueOf(player[0]), 'a response should have been correctly deserialized');
    }
}