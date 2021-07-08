@isTest
public class VerifyPhoneNumbersMock implements HttpCalloutMock{
    public HttpResponse respond(HttpRequest request){
		HttpResponse response = new HttpResponse();
        String jsonBody='{'+
		'"valid": true,'+
		'"number": "13125961000",'+
		'"local_format": "3125961000",'+
		'"international_format": "+13125961000",'+
		'"country_prefix": "+1",'+
		'"country_code": "US",'+
		'"country_name": "United States of America",'+
		'"location": "Chicgozn01",'+
		'"carrier": "",'+
		'"line_type": "landline"'+
		'}';
		response.setBody(jsonBody);
		response.setStatusCode(200);     
        return response;
    }

}