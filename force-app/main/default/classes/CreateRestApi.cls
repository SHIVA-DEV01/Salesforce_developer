public class CreateRestApi {

    private static String key = '70276956555-n4p9b2mf65ovnusm0e6h0hc2pml83caq.apps.googleusercontent.com';
    private static String secert = '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';
    private static String redirect_uri = 'https://cloudanalogy-2f1-dev-ed.lightning.force.com/c/demo.app';

    private static string authUrl='https://accounts.google.com/o/oauth2/v2/auth';
    private static string scope='https://www.googleapis.com/auth/calendar';
    private static string tokenUrl='https://accounts.google.com/o/oauth2/token';

    public static String createAuthURL() {
        String key = EncodingUtil.urlEncode(key,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = '';
        authuri = authUrl+'?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope='+scope+
            '&redirect_uri='+uri+
            '&access_type=offline'+
           	'&prompt=consent';
        return authuri;
    }


    public static boolean getAccessToken(String code)
    {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(tokenUrl);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        
        String messageBody ='code='+code+'&client_id='+key+
            '&client_secret='+secert+
            '&redirect_uri='+redirect_uri+
            '&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
       	system.debug('messageBody:'+messageBody);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = callout.send(req);
        responseText = response.getBody();
        system.debug('responseText:'+responseText);
        Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
        String token =  String.valueOf(responseMap.get('access_token'));
        system.debug('token:'+token);
        
        //Update token in custom metadata 
        return true;
    }

}