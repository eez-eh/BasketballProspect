public with sharing class page_RefreshProspectsController {
	@AuraEnabled
    // Make a callout to retrieve list of potential prospects
    public static void prospectsCallout() {
        IWebServiceFactory prospectsCallout = new ProspectsCallout();
        AssembleCallout callout = new AssembleCallout(prospectsCallout);
        List<sObject> objects = callout.makeCallout();
        // Save records to the database
        try {
            database.upsert((List<Potential_Prospect__c>)objects, Potential_Prospect__c.Fields.ExternalID__c); 
            system.debug('success');              
        } catch(DMLException e) {
        	system.debug(e.getMessage());
        }
    }
}