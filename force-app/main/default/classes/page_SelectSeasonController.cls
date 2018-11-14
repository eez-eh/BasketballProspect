public with sharing class page_SelectSeasonController {
	@AuraEnabled
    public static List<Season__c> getSeasons(Id playerId) {
        SeasonInfo sInfo = new SeasonInfo(Date.today());
        
        if (Test.isRunningTest()) {
            sInfo = (SeasonInfo)Test.createStub(SeasonInfo.class, new SeasonInfoAugustMock());
        } 
        Player__c player = [SELECT ExternalId__c FROM Player__c WHERE Id =: playerId LIMIT 1];
        List<Season__c> seasonsList = PlayerExperienceInfo.getInstance(player.ExternalID__c, sInfo).seasons;
        return seasonsList;
    }
}