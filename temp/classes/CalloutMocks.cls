@isTest
global class CalloutMocks {
	global class ProspectsHttpCalloutMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest request) {
            HttpResponse response = test_f_HttpResponseFactory.getProspects();
            return response;
        }
	}  
    global class ProspectsHttpCalloutMockWithError implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest request) {
            HttpResponse response = test_f_HttpResponseFactory.getProspectsWithErrors();
            return response;
        }
	}
    global class PlayerHttpCalloutMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest request) {
            HttpResponse response = test_f_HttpResponseFactory.getPlayer();
            return response;
        }
    }
    global class GamesHttpCalloutMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest request) {
            HttpResponse response = test_f_HttpResponseFactory.getGames();
            return response;
        }
    }
}