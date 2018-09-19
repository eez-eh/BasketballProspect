public class CalloutFactory {
	// Factory methods to return an instance of concreete class of Callout
    public static ICallout getInstance(String calloutName) {
        ICallout retVal = null;
        if (calloutName == 'Http Callout') {
            retVal = new HttpCallout();
        }
        return retVal;
    }
}