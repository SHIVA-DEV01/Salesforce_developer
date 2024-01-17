public with sharing class StripePaymentController {

    public static List<BBDEC__Stripe__c> stripeValues = [SELECT BBDEC__CustomerId__c, BBDEC__Secret_key__c FROM BBDEC__Stripe__c LIMIT 1];

    @AuraEnabled
    public static string createCustomer(String firstName, String lastName, String email){
        try {

            if(firstName != null && lastName != null && email != null && firstName.length() != 0 && lastName.length() != 0 && email.length() != 0 )
                    {
                        String body = 'name='+firstName+' '+lastName+'&email='+ email +'&description=Stripe Customer User';
                        Map<String, Object> customerMap= globalHttpCalloutMethod(body,'https://api.stripe.com/v1/customers', 'POST');
                        String customerID = String.valueOf(customerMap.get('id'));
                        if(customerID != null)
                        {
                            return customerID;
                        }
                        else{
                            return 'null';
                        }
                    }
                    return null;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

     // Method to geeting the card details
     @AuraEnabled
     public static Map<String,Object> getCardDetails(){
         if(stripeValues[0].BBDEC__CustomerId__c!=null){
            Map<String,Object> savedCardDetails = globalHttpCalloutMethod('','https://api.stripe.com/v1/customers/'+stripeValues[0].BBDEC__CustomerId__c+'/payment_methods?type=card','GET');
            if(savedCardDetails!=null)
               return savedCardDetails;
            else
               return new Map<String,Object>();
         }
         return new Map<String,Object>();
     }

     //Create Payment Method 
     @AuraEnabled
    public static Map<String,Object> paymentMethod(String payload){
        try {
            Map<String,Object> objectResponse = globalHttpCalloutMethod(payload,'https://api.stripe.com/v1/payment_methods','POST');
            return objectResponse;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

     // Method for Payment Intent passing custometr ID and PaymentMethodId
    @AuraEnabled
    public static Map<String,Object> paymentIntentMethod(String amount, String paymentMethodId, Boolean saveForFuture){
         String requestBody = 'currency=USD&amount='+amount+'&confirm=true&customer='+stripeValues[0].BBDEC__CustomerId__c+'&payment_method='+paymentMethodId;
         if(saveForFuture==true)
         requestBody+='&setup_future_usage=off_session';
         Map<String,Object> responseJson = globalHttpCalloutMethod(requestBody,'https://api.stripe.com/v1/payment_intents','POST');
         return responseJson;
    }

    public static Map<String,Object> globalHttpCalloutMethod(String body, String endPoint, String method ){
        try {
            system.debug('body'+body+'endPoint'+endPoint+'method'+method+'stripeValues'+stripeValues[0]);
            Http http = new Http();
            HttpRequest request = new HttpRequest(); 
            request.setHeader('Authorization', 'Bearer ' + stripeValues[0].BBDEC__Secret_key__c);
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setMethod(method);
            request.setEndpoint(endPoint);
            if(body!='')
            request.setBody(body);
            HttpResponse response = http.send(request);
            if(response.getStatusCode()==200){
                Map<String,Object> responseMap =(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                
                return responseMap;
            }
            else{
                Map<String,Object> responseMap =(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                return responseMap;  
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}