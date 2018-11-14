public with sharing class page_RefreshProspectsController {
	@AuraEnabled
    public static void prospectsCallout() {
        IWebServiceFactory prospectsCallout = new ProspectsCallout();
        AssembleCallout callout = new AssembleCallout(prospectsCallout);
        List<sObject> objects = callout.makeCallout(); 
        
        try {
            database.upsert((List<Potential_Prospect__c>)objects, Potential_Prospect__c.Fields.ExternalID__c);
            SeasonInfo sInfo = new SeasonInfo(Date.today());
        	SeasonRecord sRecord = new SeasonRecord(sInfo);
        	sRecord.createSeasonRecords(); 
            system.debug('success'); 
        } catch(DMLException e) {
        	system.debug(e.getMessage());
        }
    }
}