@RestResource(urlMapping='/webhook')
global with sharing class WebhookHandler {

    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        System.debug('Inside rest resource class');
        
        String validationToken = req.headers.get('Validation-Token');
        if (validationToken != null) {
            res.statusCode = 200;
            res.responseBody = Blob.valueOf('');
            res.addHeader('Content-Type', 'application/json');
            res.addHeader('Validation-Token', validationToken);
        } else {
            Integer contentLength = Integer.valueOf(req.headers.get('Content-Length'));
            String payload = req.requestBody.toString();
            System.debug(payload);
            res.statusCode = 200;
            res.responseBody = Blob.valueOf('');
        }
    }
}