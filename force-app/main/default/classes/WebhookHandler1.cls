public class WebhookHandler1 {

    // For the purpose of testing the code, set the delivery address directly.
    // Feel free to use custom settings or custom metadata for storing such values.
    private static final String DELIVERY_ADDRESS = 'https://cloudanalogy-2f1-dev-ed.my.salesforce.com/services/apexrest/webhook';
    public static String access_Token;
    public WebhookHandler1(){
        access_Token = getAccessToken();
        System.debug('access Token >>> '+ access_Token);
    }

    public void subscribeForNotification() {
        try {
            List<String> eventFilters = new List<String>{
    				'/restapi/v1.0/account/~/extension/~/message-store'
            };
            Map<String, Object> deliveryMode = new Map<String, Object>{
                'transportType' => 'PubNub',
                'address' => DELIVERY_ADDRESS
            };
            Map<String, Object> bodyParams = new Map<String, Object>{
                'eventFilters' => eventFilters,
                'deliveryMode' => deliveryMode,
                'expiresIn' => 36000
            };
            String endpoint = 'https://platform.devtest.ringcentral.com/restapi/v1.0/subscription';
            HttpResponse resp = makePostRequest(endpoint, bodyParams);
            System.debug('Http Response >>> '+ resp);
            Map<String, Object> jsonObj = (Map<String, Object>) JSON.deserializeUntyped(resp.getBody());
            System.debug('Subscription id: ' + jsonObj.get('id'));
            System.debug('resp.getBody() >>> '+ resp.getBody());
            System.debug('Ready to receive incoming SMS via WebHook.');
        } catch (Exception e) {
            System.debug('Webhook creation failed.');
            System.debug('An exception was thrown: ' + e.getMessage() + '  Line No.  '+ e.getLineNumber());
        }
    }

    public static void readSubscriptions() {
        try {
            String endpoint = '/restapi/v1.0/subscription';
            HttpResponse resp = makeGetRequest(endpoint);
            Map<String, Object> jsonObj = (Map<String, Object>) JSON.deserializeUntyped(resp.getBody());
            List<Object> records = (List<Object>) jsonObj.get('records');
            if (records.size() == 0) {
                System.debug('No subscription.');
            } else {
                for (Object recordObj : records) {
                    Map<String, Object> record = (Map<String, Object>) recordObj;
                    System.debug(JSON.serialize(record));
                    deleteSubscription((String) record.get('id'));
                }
            }
        } catch (Exception e) {
            System.debug('An exception was thrown: ' + e.getMessage());
        }
    }

    public static void deleteSubscription(String subscriptionId) {
        try {
            String endpoint = '/restapi/v1.0/subscription/' + subscriptionId;
            HttpResponse resp = makeDeleteRequest(endpoint);
            System.debug('Subscription ' + subscriptionId + ' deleted.');
        } catch (Exception e) {
            System.debug('An exception was thrown: ' + e.getMessage());
        }
    }

    private static HttpResponse makePostRequest(String endpoint, Map<String, Object> bodyParams) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
		req.setHeader('Authorization', 'Bearer '+ access_Token);
        req.setBody(JSON.serialize(bodyParams));
        Http http = new Http();
        return http.send(req);
    }

    private static HttpResponse makeGetRequest(String endpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http http = new Http();
        return http.send(req);
    }

    private static HttpResponse makeDeleteRequest(String endpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('DELETE');
        Http http = new Http();
        return http.send(req);
    }
       public static String getAccessToken(){
        try{
            String client_ID = 'folX1Z45MJfbyPmLJxmUP6';
            String client_Secret = 'bdIhAQ2AnUnfmmIQGW6EkKc4CuzAnedhpeFMYJ7vQnXN';
            String jwt = 'eyJraWQiOiI4NzYyZjU5OGQwNTk0NGRiODZiZjVjYTk3ODA0NzYwOCIsInR5cCI6IkpXVCIsImFsZyI6IlJTMjU2In0.eyJhdWQiOiJodHRwczovL3BsYXRmb3JtLmRldnRlc3QucmluZ2NlbnRyYWwuY29tL3Jlc3RhcGkvb2F1dGgvdG9rZW4iLCJzdWIiOiIzOTA3MTQwMDQiLCJpc3MiOiJodHRwczovL3BsYXRmb3JtLmRldnRlc3QucmluZ2NlbnRyYWwuY29tIiwiZXhwIjozODQwNDQ1MjU5LCJpYXQiOjE2OTI5NjE2MTIsImp0aSI6IjlXLXJ5WW10VDA2eTk1QkVTTXpndXcifQ.Z5wKRs8dqdRniHDec3SdRj9cJhxbMnh0WbszjE0vWaASG6pxfvTOI9g8pu0xsmB29zomPos-B_Lpa2CRfH9Vu4hiZiimP8iJUa4Nv1JccpDMRNLjOvNm_kJF5IYZaUuQuTgvgi3h4fkmp4VkMkMDFvVNk72C3da5Uems3Lfrd-M8Ae5reN5PUMWUC2vGyIvuVAiX_WN-K34ItzCbFgRETqOsDUThdHjH753-ix0IKBtKgj9ZW-bwqpvzP4of4cSZqF9yHvJdDO1mBYSRbJT1Ts933LptYw5KNjTeSmuGw4G0w20dfv1D7RrKwER3SpMCtXMGraJkJ-MW88Cs_PS5Jg';
            //RingCentral_Integration__mdt customMetadataRecord = [SELECT Client_ID__c, Client_Secret__c,Endpoint__c, grant_type__c, JWT_Token__c FROM RingCentral_Integration__mdt Where Label = 'Get Access Token' LIMIT 1];
            //System.debug('customMetadataRecord: '+ customMetadataRecord);
            String auth = EncodingUtil.base64Encode(Blob.valueOf(client_ID + ':' + client_Secret));
            //System.debug('auth : '+ auth);
            String bodyParams = 'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer' + '&assertion=eyJraWQiOiI4NzYyZjU5OGQwNTk0NGRiODZiZjVjYTk3ODA0NzYwOCIsInR5cCI6IkpXVCIsImFsZyI6IlJTMjU2In0.eyJhdWQiOiJodHRwczovL3BsYXRmb3JtLmRldnRlc3QucmluZ2NlbnRyYWwuY29tL3Jlc3RhcGkvb2F1dGgvdG9rZW4iLCJzdWIiOiIzOTA3MTQwMDQiLCJpc3MiOiJodHRwczovL3BsYXRmb3JtLmRldnRlc3QucmluZ2NlbnRyYWwuY29tIiwiZXhwIjozODQwNDQ1MjU5LCJpYXQiOjE2OTI5NjE2MTIsImp0aSI6IjlXLXJ5WW10VDA2eTk1QkVTTXpndXcifQ.Z5wKRs8dqdRniHDec3SdRj9cJhxbMnh0WbszjE0vWaASG6pxfvTOI9g8pu0xsmB29zomPos-B_Lpa2CRfH9Vu4hiZiimP8iJUa4Nv1JccpDMRNLjOvNm_kJF5IYZaUuQuTgvgi3h4fkmp4VkMkMDFvVNk72C3da5Uems3Lfrd-M8Ae5reN5PUMWUC2vGyIvuVAiX_WN-K34ItzCbFgRETqOsDUThdHjH753-ix0IKBtKgj9ZW-bwqpvzP4of4cSZqF9yHvJdDO1mBYSRbJT1Ts933LptYw5KNjTeSmuGw4G0w20dfv1D7RrKwER3SpMCtXMGraJkJ-MW88Cs_PS5Jg';
            //System.debug('bodyParams :::: '+ bodyParams);
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://platform.devtest.ringcentral.com/restapi/oauth/token');
            req.setMethod('POST');
            req.setHeader('Authorization', 'basic ' + auth);
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            req.setBody(bodyParams);
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                //System.debug('get Body >>> '+ res.getBody());
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                //System.debug('get response >>> '+ responseMap);
                return (String) responseMap.get('access_token');
            } else {
                // Handle error case
                System.debug('getstatusCode >>> '+ res.getStatusCode());
                return null;
            }
        }catch(Exception err){
            System.debug('Error : RingCentralIntegrationController.getAccessToken '+ err.getLineNumber() +' : '+ err.getCause() +' : '+err.getMessage()+' : '+ err.getStackTraceString());
            return null;
        }
    }
}