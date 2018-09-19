public class EndpointFactory {
	// Factory methods to return an instance of concreete class of Endpoint
    public static INbaEndpoint getInstance(String endpointName) {
        INbaEndpoint retVal = null;
        if (endpointName == 'Prospects') {
            SeasonInfo sInfo = new SeasonInfo(Date.today());
            retVal = new ProspectsEndpoint(sInfo);
        }
        return retVal;
    }
    public static INbaEndpoint getInstance(String endpointName, String externalId) {
        INbaEndpoint retVal = null;
        if (endpointName == 'Player') {
            retVal = new PlayerEndpoint(externalId);
        }
        return retVal;
    }
    public static INbaEndpoint getInstance(String endpointName, String externalId, Integer yearsAgo) {
        INbaEndpoint retVal = null;
        if (endpointName == 'Games') {
            SeasonInfo sInfo = new SeasonInfo(Date.today());
            retVal = new GamesEndpoint(externalId, yearsAgo, sInfo);
        }
        return retVal;
    }
}