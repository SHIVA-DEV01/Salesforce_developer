public class NamedCredUseCrtl {
	 public static void getAccountInfo(){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HTTPResponse response = new HTTPResponse();
 
        req.setMethod('POST');
        req.setEndpoint('callout:GoogleCalender/some_path');
        response = http.send(req);
         
        System.debug('response-' + response);
        System.debug('response-' + response.getBody());
    }
}