public class ReturnedPlayer implements IReturnedRecords {
	public List<Player__c> manageReturnedRecords(HttpResponse response) {
        List<String> profile = deserializeRespone(response);
        List<Player__c> players = new List<Player__c>();
        Player__c player = new Player__c(
        	First_Name__c = profile[1],
        	Name = profile[2],
        	Team_Abbreviation__c = profile[18],
        	Team_Name__c = profile[20] + ' ' + profile[17],
        	ExternalID__c = profile[0],
        	Birthdate__c = Date.valueOf(profile[6]),
        	Country__c = profile[8],
        	Height__c = profile[10].split('-')[0] + 'ft ' + profile[10].split('-')[1] + 'in',
        	Position__c = profile[14],
        	School__c = profile[7],
        	Season_Experience__c = Integer.valueOf(profile[12]),
        	Weight__c = profile[11] + 'lbs');
        players.add(player);
        return players;
    }
    
    // Deserialize the response into a list of records 
    private List<String> deserializeRespone(HttpResponse response) {
        PlayerResponse playerRsp = (PlayerResponse)JSON.deserialize(response.getBody(), PlayerResponse.class);
        return playerRsp.resultSets[0].rowSet[0];
    }
}