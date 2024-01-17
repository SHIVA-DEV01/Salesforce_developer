public with sharing class RingCentralWebhookSubscriber {
    // Your Salesforce authentication and initialization logic would go here

    // Define the endpoint URL where RingCentral will send webhook notifications
    public static final String DELIVERY_ADDRESS = 'https://cloudanalogy-2f1-dev-ed.lightning.force.com/services/apexrest/webhook';

    // This method is called after authenticating to Salesforce
    public static void subscribeForNotification() {
        Map<String, Object> bodyParams = new Map<String, Object> {
            'eventFilters' => new List<String>{ 'https://platform.devtest.ringcentral.com/restapi/v1.0/account/~/extension/~/message-store' },
            'deliveryMode' => new Map<String, Object>{
                'transportType' => 'WebHook',
                'address' => DELIVERY_ADDRESS
            },
            'expiresIn' => 3600
        };

        String endpoint = 'https://platform.devtest.ringcentral.com/restapi/v1.0/subscription';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + 'U0pDMTJQMDFQQVMwMHxBQUNoek1oeU9JbFBuQTZQU1NYek5NRTh6R1RrTkNRSEFEMUxnVnY0b1A2aTBmdG9CSHZONXFtUldrRlN1WnMySWFjb3NPamgtSzFjaHF2b2lmaGo2bGtFT2xQMDlHclZ6NTNKUnJsX2lxV0wxaUZ5OGxtbDdWM3ZKSzlRRFRzamR1VmhuNFV4bzdWQ2hGQjA5ZmlUU25VdXhCWWZUTWRjdzdWYVJnRjlEd3pKRzdVSzdyUjVualhudWw5cHlTdG5vZ1g1d0JxbFlEUXw5cFdlWkF8cThiNVo4ZGJZbXowUG1sSkdUai1uZ3xBUXxBQXxBQUFBQUlJUVpsZw'); // Replace with your actual access token
        req.setBody(JSON.serialize(bodyParams));

        HttpResponse resp = new Http().send(req);
        if (resp.getStatusCode() == 201) {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(resp.getBody());
            System.debug('Subscription Id: ' + jsonResponse.get('id'));
            System.debug('Ready to receive incoming SMS via WebHook.');
        } else {
            System.debug('Error subscribing for notifications: ' + resp.getBody());
        }
    }
}