@isTest
public class test_f_PotentialProspectFactory extends SObjectFactory {
    public SObject buildRecordWithData() {
        return new Potential_Prospect__c(
        	Name = 'Player ' + counter,
        	Team__c = 'TestTeam',
        	From_Year__c = 2014,
        	ExternalID__c = '12345',
        	First_Name__c = 'Test');
    }
}