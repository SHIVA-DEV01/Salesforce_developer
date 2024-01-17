public class GoogleNamedCredential {
    public static HTTPResponse getDriveData(){
        String endpoint = 'callout:BBDEC__Google_Integration_Named/drive/v3/files';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HTTPResponse res = http.send(req);

        System.debug('Response >>>>>> '+ res.getBody());

        return null;
    }
}