public class ReturnedProspects implements IReturnedRecords {
    public List<Potential_Prospect__c> manageReturnedRecords(HttpResponse response) {
        List<List<String>> rows = deserializeRespone(response);
        Set<String> trackedPlayers = getTrackedPlayers();
        List<Potential_Prospect__c> potentialProspects = new List<Potential_Prospect__c>();
        
        for (List<String> row : rows) {
            String externalId = row[0];
            // Players currently tracked shouldn't be added to prospects list
            if (trackedPlayers.contains(externalId)) {
                continue;
            }
            
            List<String> fullName = row[1].split(',');
            Potential_Prospect__c potentialProspect = new Potential_Prospect__c(
                Name = fullName[0],
                Team__c = row[8] + ' ' + row[9],
                From_Year__c = Integer.valueOf(row[4]),
                ExternalID__c = externalId);
            
            if (fullName.size() > 1) {
                potentialProspect.First_Name__c = fullName[1];
            }
            potentialProspects.add(potentialProspect);
        }
        return potentialProspects;
    }
    // Get all currently tracked players
    private Set<String> getTrackedPlayers() {
        Set<String> palyersExternalId = new Set<String>();
        
        for (Player__c player : [SELECT ExternalID__c FROM Player__c]) {
            palyersExternalId.add(player.ExternalID__c);
        }
        return palyersExternalId;
    }
    // Deserialize the response into a list of records 
    private List<List<String>> deserializeRespone(HttpResponse response) {
        ProspectsRespone prospectsRsp = (ProspectsRespone)JSON.deserialize(response.getBody(), ProspectsRespone.class);
        return prospectsRsp.resultSets[0].rowSet;
    }
}