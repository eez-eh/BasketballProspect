@isTest
public class test_f_PlayerFactory extends SObjectFactory {
	public SObject buildRecordWithData() {
        Integer tempCounter = counter;
        return new Player__c(
        	First_Name__c = 'Test',
        	Name = 'Player' + tempCounter,
        	Team_Abbreviation__c = 'TST',
        	Team_Name__c = 'Test Team',
        	ExternalID__c = '12345' + tempCounter,
        	Birthdate__c = Date.newInstance(1995, 1, 1),
        	Country__c = 'USA',
        	Height__c = '6ft 6in',
        	Position__c = 'SF',
        	School__c = 'Duke',
        	Season_Experience__c = 4,
        	Weight__c = '210lbs');
    }
}