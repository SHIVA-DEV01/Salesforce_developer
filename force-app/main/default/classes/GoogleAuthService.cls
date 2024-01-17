public class GoogleAuthService {
	private static string key = '70276956555-n4p9b2mf65ovnusm0e6h0hc2pml83caq.apps.googleusercontent.com';
    private static string secert = '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';
    private static string redirect_uri = 'https://cloudanalogy-2f1-dev-ed.lightning.force.com/BBDEC/DemoAuraApp.app';
    private static string authUrl='https://accounts.google.com/o/oauth2/v2/auth';
    private static string scope='https://www.googleapis.com/auth/calendar';
    private static string tokenUrl='https://accounts.google.com/o/oauth2/token';
    
        @AuraEnabled
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
    
    @AuraEnabled
    public static String getAccessToken(String code)
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
        System.debug('Map of response>>>>>'+responseMap);
        String token =  String.valueOf(responseMap.get('access_token'));
        String refreshToken =  String.valueOf(responseMap.get('refresh_token'));
        if(token != null && refreshToken != null){
        BBDEC__Google_Access_Token__c GoogleAT = new BBDEC__Google_Access_Token__c();
        GoogleAT.id = 'a0F5i000005x8NDEAY';
        GoogleAT.BBDEC__Access_Token__c = token;
        GoogleAT.BBDEC__Refresh_Token__c = refreshToken;
        update GoogleAT;
        }
        
        system.debug('token:'+token);
        
        //Update token in custom metadata 
        //MetadataService.UpdateCustomMetadata(token);
        return token;
    }



    @AuraEnabled
    public static List<Object> getMethodwe(string token)
    {
        System.debug('Token in getMethod>>>>>'+ token);
        HttpRequest req = new HttpRequest();
        
        req.setMethod('GET');
        req.setEndpoint('https://www.googleapis.com/calendar/v3/calendars/'+'Shiva.test369@gmail.com'+'/events');
        req.setHeader('Authorization', 'Bearer '+token);
        req.setHeader('content-type', 'application/json;charset=UTF-8');
        
        http callout = new http();
        HttpResponse response = callout.send(req);
        //system.debug('GET RES>>'+response);
        //system.debug('response1 body>>'+ response.getBody());
        //system.debug('response1 body>>'+ response.getStatus());
        //system.debug('response1 body>>'+ response.getBodyAsBlob());
        if (response.getStatusCode() == 200) {
            Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

            list<Object> item = (list<Object>) results.get('items');

            
            System.debug('Get Result>>>>>'+item);

                        
            return item;
        }
        else{
            System.debug('else part in getMethod>>>>>>'+response.getStatusCode());
            return null;
        }

    }


    @AuraEnabled
    public static void postMethod(String token,String eve){
        System.debug('Post token id>>>'+ token);
        System.debug('Event Name>>>>'+eve);
        HttpRequest req = new HttpRequest();
        
        req.setMethod('POST');
        req.setEndpoint('https://www.googleapis.com/calendar/v3/calendars/'+'Shiva.test369@gmail.com'+'/events');
        req.setHeader('Authorization', 'Bearer '+token);
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"summary":"'+eve+'","start":{"dateTime": "2022-09-28T04:30:00+05:30","timeZone": "Asia/Kolkata"},"end": {"dateTime": "2022-09-28T05:30:00+05:30", "timeZone": "Asia/Kolkata"}}');
        

        http callout = new http();
        HttpResponse response = callout.send(req);
        if (response.getStatusCode() != 201){
            
            System.debug('Post method is complete'+response.getStatusCode());
        } else{
            System.debug('response Body>>>>>>'+response.getBody());
        }
    }


    @AuraEnabled
    
    public static string regenerateAccessToken(){
        list<string> tokenlist = new list<string>();
        BBDEC__Google_Access_Token__c str = [Select BBDEC__Refresh_Token__c from BBDEC__Google_Access_Token__c limit 1];
        System.debug('SOQL>>>>>'+str);
        
        String refresh_token = String.valueOf(str.BBDEC__Refresh_Token__c);

        System.debug('refresh_token'+refresh_token);
        

        HttpRequest req = new HttpRequest();
        req.setBody('grant_type=refresh_token'+'&refresh_token='+refresh_token+'&client_id='+key+'&client_secret='+secert);
        req.setMethod('GET');
        req.setEndpoint(tokenUrl);
        http callout = new http();
        HttpResponse response = callout.send(req);
        System.debug('response body>>>>>'+response.getBody());
        Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(response.getBody()) ;  
        String token =  String.valueOf(responseMap.get('access_token'));
        BBDEC__Google_Access_Token__c GoogleAT = new BBDEC__Google_Access_Token__c();
        GoogleAT.id = 'a0F5i000005x8NDEAY';
        GoogleAT.BBDEC__Access_Token__c = token;
        update GoogleAT;
        return token;
    }
    
}