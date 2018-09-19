public class ReturnedRecordsFactory {
	// Factory methods to return an instance of concreete class of Returned Records
    public static IReturnedRecords getInstance(String recordsName) {
        IReturnedRecords retVal = null;
        if (recordsName == 'Return Prospects') {
            retVal = new ReturnedProspects();
        } else if (recordsName == 'Return Player') {
            retVal = new ReturnedPlayer();
        }
        return retVal;
    }
    public static IReturnedRecords getInstance(String recordsName, String playerId, String seasonId) {
        IReturnedRecords retVal = null;
        if (recordsName == 'Return Games') {
            retVal = new ReturnedGames(playerId, seasonId);
        }
        return retVal;
    }
}