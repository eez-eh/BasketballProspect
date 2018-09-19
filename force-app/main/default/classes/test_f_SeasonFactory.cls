@isTest
public class test_f_SeasonFactory extends SObjectFactory {
    public SObject buildRecordWithData() {
        Integer tempCounter = counter;
        return new Season__c(
        	Name = String.valueOf(2010 + tempCounter) + '-' + String.valueOf(11 + tempCounter),
            Number__c = '220' + String.valueOf(10 + tempCounter));
    } 
}