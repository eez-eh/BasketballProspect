@isTest
public class SeasonInfoAugustMock implements System.StubProvider {
	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, 
		List<Type> ListOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
			if (stubbedMethodName == 'getCurrentSeasonName') {
            	return '2015-16';
            } else if (stubbedMethodName == 'getSeasonName') {
                Integer counter = Integer.valueOf(listOfArgs[0]);
                String seasonName = String.valueOf(2015 - counter) + '-' + String.valueOf(16 - counter);
                return seasonName;
            } else if (stubbedMethodName == 'isSeasonEnded') {
                return true;
            }
            return null;
		}
}