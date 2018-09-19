@isTest
public class SeasonInfoNovemberMock implements System.StubProvider {
	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, 
		List<Type> ListOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
            if (stubbedMethodName == 'getCurrentSeasonName') {
                return '2018-19';
            } else if (stubbedMethodName == 'getSeasonName') {
				Integer counter = Integer.valueOf(listOfArgs[0]);
                String seasonName = String.valueOf(2018 - counter) + '-' + String.valueOf(19 - counter);
                return seasonName;
            } else if (stubbedMethodName == 'isSeasonEnded') {
                return false;
            }
            return null;
        }
}