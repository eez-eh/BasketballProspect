@isTest
public class WebServiceFactoryMock implements System.StubProvider {
    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, 
		List<Type> ListOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
            if (stubbedMethodName == 'getMethod') {
                return 'GET';
            } else if (stubbedMethodName == 'getEndpoint') {
                return new MockEndpoint();
            } else if (stubbedMethodName == 'getHttpCallout') {
                return new MockCallout();
            } else if (stubbedMethodName == 'getResponseManager') {
                return new MockResponseManager();
            }
			return null;            
        }
    
    private class MockEndpoint implements INbaEndpoint {
        public String createEndpoint() {
            return 'mock endpoint';
        }
    }
    
    private class MockCallout implements ICallout {
        public HttpResponse createCallout(String arg1, String arg2) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            return response;
        }
    }
    
    private class MockResponseManager implements IReturnedRecords {
        public List<sObject> manageReturnedRecords(HttpResponse response) {
            SObjectFactory factory = new test_f_PlayerFactory();
            List<Player__c> players = factory.buildRecords(5);
            return players;
        }
    }    
}