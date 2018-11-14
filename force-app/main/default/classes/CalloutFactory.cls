public class CalloutFactory {
    public static ICallout getInstance(String calloutName) {
        ICallout retVal = null;
        
        if (calloutName == 'Http Callout') {
            retVal = new HttpCallout();
        }
        return retVal;
    }
}