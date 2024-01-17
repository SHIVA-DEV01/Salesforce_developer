@RestResource(urlMapping='/whatsapp/shiva/v1/*')
global class WhatsappWebhook {
	private static Final String SIGNATURE_VALID_MESSAGE = 'Signature Verified';
    private static Final String SIGNATURE_NOT_VALID_MESSAGE = 'Signature could not be verfied';
    
    @HttpGet
    global static void doGet() {
        RestResponse response = RestContext.response;
        RestRequest request = RestContext.request;
        if(request.params.get('hub.verify_token') == 'TEST'){
            response.responseBody = Blob.valueOf( request.params.get('hub.challenge') );
        }
    }
    
    @HttpPost
    global static void doPost() {
        
        RestResponse response = RestContext.response;
        response.addHeader('Content-type','application/json');
        String responseString = RestContext.request.requestBody.toString();
        Map<String, String> headers = RestContext.request.headers;
        //System.debug(System.LoggingLevel.DEBUG,' Headers Response From Whatsapp \n'+ JSON.serialize(headers));
        String responseValid = validateStripeSignature(RestContext.request, responseString);
        
        if(responseValid == SIGNATURE_VALID_MESSAGE) {
            System.debug(System.LoggingLevel.DEBUG,' Headers Response From Whatsapp \n'+ JSON.serialize(headers));
            System.debug(System.LoggingLevel.DEBUG,' Response From Whatsapp \n'+ responseString);
            System.debug('responseString >>>> '+ responseString);
            String finalResponseString = responseString.replace('type', 'typex');
            WhatsAppMessage parentMessage =(WhatsAppMessage) JSON.deserialize(finalResponseString,WhatsAppMessage.class);
            
            List<WhatsAppMessage.entry> messageEntries = parentMessage.entry;
            if(messageEntries.size()>0 && messageEntries != null){
                WhatsAppMessage.entry entryMessage = messageEntries.get(0);
                List<WhatsAppMessage.changes> changeMessages = entryMessage.changes;
                if(changeMessages != null && changeMessages.size()>0){
                    WhatsAppMessage.changes changeMessage = changeMessages.get(0);
                    List<WhatsAppMessage.contacts> contactList = changeMessage.value.contacts;
                    List<WhatsAppMessage.messages> messageList = changeMessage.value.messages;
                    WhatsAppMessage.metadata metadata = changeMessage.value.metadata;
                    WhatsAppMessage.contacts contact = contactList.get(0);

                    List<BBDEC__WA_Message__c> wAMessageList = [Select id,BBDEC__CustomerPhone__c, BBDEC__MessageContext__c from BBDEC__WA_Message__c where BBDEC__CustomerPhone__c =: contact.wa_id];
                    // Create record into SalesForce
                    
                    BBDEC__WA_Message__c salesForceMessage = new BBDEC__WA_Message__c();
                    List<BBDEC__Test_Event__e> inkEvents = new List<BBDEC__Test_Event__e>();
                    if(wAMessageList.size()<=0 || wAMessageList == null){

                        salesForceMessage.BBDEC__BusinessPhoneNumber__c = metadata != null ? metadata.display_phone_number : null;

                        if(contactList != null && contactList.size()>0){
                            
                            salesForceMessage.BBDEC__CustomerPhone__c = contact.wa_id;
                            salesForceMessage.BBDEC__CustomerName__c = contact.profile.name;
                        }


                        if(messageList != null && messageList.size()>0){
                            WhatsAppMessage.messages message = messageList.get(0);
                            salesForceMessage.BBDEC__MessageId__c = message.id;
                            salesForceMessage.BBDEC__MessageType__c = message.typex;
                            salesForceMessage.BBDEC__Message_Set_Time__c = System.now();
                            salesForceMessage.BBDEC__MessageContext__c = message.text.body + 'C';

                            salesForceMessage.BBDEC__Reaction__c = message.reaction != null ? message.reaction.emoji : null;
                            salesForceMessage.BBDEC__ParentMessageID__c = message.reaction != null ? message.reaction.message_id : null;

                            

                            salesForceMessage.BBDEC__ParentMessageID__c = message.context != null ? message.context.id : null;

                            Insert salesForceMessage;

                            inkEvents.add(new BBDEC__Test_Event__e(BBDEC__Message__c=message.text.body, BBDEC__Phone__c=contact.wa_id));
                        }
                    }else{
                        salesForceMessage.BBDEC__BusinessPhoneNumber__c = metadata != null ? metadata.display_phone_number : null;

                        salesForceMessage.id = wAMessageList[0].id;

                        if(contactList != null && contactList.size()>0){
                            
                            salesForceMessage.BBDEC__CustomerPhone__c = contact.wa_id;
                            salesForceMessage.BBDEC__CustomerName__c = contact.profile.name;
                        }


                        if(messageList != null && messageList.size()>0){
                            WhatsAppMessage.messages message = messageList.get(0);
                            salesForceMessage.BBDEC__MessageId__c = message.id;
                            salesForceMessage.BBDEC__MessageType__c = message.typex;
                            salesForceMessage.BBDEC__Message_Set_Time__c = System.now();
                            salesForceMessage.BBDEC__MessageContext__c = wAMessageList[0].BBDEC__MessageContext__c + ';' +message.text.body+'C';

                            salesForceMessage.BBDEC__Reaction__c = message.reaction != null ? message.reaction.emoji : null;
                            salesForceMessage.BBDEC__ParentMessageID__c = message.reaction != null ? message.reaction.message_id : null;

                            

                            salesForceMessage.BBDEC__ParentMessageID__c = message.context != null ? message.context.id : null;

                            Update salesForceMessage;
                            inkEvents.add(new BBDEC__Test_Event__e(BBDEC__Message__c=message.text.body, BBDEC__Phone__c=contact.wa_id));
                        }
                    }

                    if(!inkEvents.isEmpty()){
                    List<Database.SaveResult> results = EventBus.publish(inkEvents);
                    }
                    

                } 
            }
        } else{
            response.responseBody = Blob.valueOf('{success:false, event:"Unknown","message"'+responseValid+'"}');
            System.debug(System.LoggingLevel.DEBUG,' Response From Whatsapp######## \n'+ responseString);
            response.statusCode = 401;
            return;
            
        }
        response.statusCode = 200;
        response.responseBody = Blob.valueOf('{success:true, event:"success"}');
    }
    
    private static String validateStripeSignature(RestRequest request,String responseString){
        
        Map<String, String> headers = request.headers;
        //system.debug(System.LoggingLevel.DEBUG,' Response From ValidateStripe \n'+ headers);
       //Map<String, String> headers1 = JSON.serialize(headers);
        String whatsAppSignature = headers.get('X-Hub-Signature-256');
        String whatsAppPayload = RestContext.request.requestBody.toString();
        
        String whatsAppSecret = '72a2dba276e10057f2254cf2c75f09b8';
        Blob signedPayload = Crypto.generateMac('hmacSHA256', Blob.valueOf(whatsAppPayload), Blob.valueOf(whatsAppSecret));
        
        //System.debug(System.LoggingLevel.DEBUG,' Response From ValidateStripe signedPayload \n'+ signedPayload);
        
        String encodedPayload = 'sha256='+EncodingUtil.convertToHex(signedPayload);
        
        String response = (encodedPayload == whatsAppSignature)? SIGNATURE_VALID_MESSAGE : SIGNATURE_NOT_VALID_MESSAGE;
        return response;

    }
}