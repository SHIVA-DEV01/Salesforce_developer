public class WhatsAppUtils {
    @AuraEnabled
    public static void sendTextMessage(String messageContent, String toPhone){

        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('https://graph.facebook.com/v17.0/110632955193161/messages');
        httpReq.setMethod('POST');
        httpReq.setHeader('Content-Type','application/json');
        httpReq.setHeader('Authorization','Bearer '+ 'EAAMLRhDiBAABO56yAWGG9hdI6n4PTqZBlprg1AZCTxQlKRf3dSvby6wkbq3XZAfR5y0LN6GnGYE5PxPqZCRQjdqXh34fz6nNhyLa7uZBoVrHmsgM9eiT7Ec2huTrsJ93BBdMfWBP78MlLx4EhBZAyZCnkvTI4ztfphJ1wnP7YOX5aarBx73wqirZCXOLy8xazZBcw');
        

        String messageBody='{'+
		'    "messaging_product": "whatsapp",'+
		'    "to": "'+toPhone+'",'+
		'    "type": "text",'+
		'    "text": {'+
		'        "preview_url": false,'+
		'        "body": "'+messageContent+'"'+
		'    }'+
		'}';

        httpReq.setBody(messageBody);



        Http http = new Http();

        try{
            HttpResponse response = http.send(httpReq);
            System.debug('response >>>> '+ response);
            if(response.getStatusCode() == 200){

                WhatsAppUtils responseFromWA = (WhatsAppUtils) JSON.deserialize(response.getBody(), WhatsAppUtils.class);
                List<BBDEC__WA_Message__c> wAMessageList = [SELECT BBDEC__CustomerPhone__c,Id,BBDEC__MessageContext__c FROM BBDEC__WA_Message__c WHERE BBDEC__CustomerPhone__c =: toPhone LIMIT 1];
                
               
                if(wAMessageList != null && wAMessageList.size()>0){
                    BBDEC__WA_Message__c salesForceMessage = new BBDEC__WA_Message__c();
                    salesForceMessage.Id = wAMessageList[0].Id;
                    salesForceMessage.BBDEC__MessageContext__c = wAMessageList[0].BBDEC__MessageContext__c + ';' + messageContent + 'U';
                    salesForceMessage.BBDEC__CustomerPhone__c = toPhone;
                    salesForceMessage.BBDEC__MessageId__c = responseFromWA.messages.get(0).id;
                    Update salesForceMessage;
                }else {
                    BBDEC__WA_Message__c salesForceMessage = new BBDEC__WA_Message__c();
                    salesForceMessage.BBDEC__MessageContext__c = messageContent + 'U';
                    salesForceMessage.BBDEC__CustomerPhone__c = toPhone;
                    salesForceMessage.BBDEC__MessageId__c = responseFromWA.messages.get(0).id;
                    Insert salesForceMessage ;
                }
            }
        }catch(System.CalloutException ex){
            System.debug(' CalloutException Executed'+ ex.getStackTraceString());
           	System.debug(' CalloutException Executed'+ ex.getmessage());
        }catch(System.Exception ex){
            System.debug(' System.Exception Executed'+ ex.getStackTraceString());
        }
        
    }
    @AuraEnabled
    public static WARecordsWrapper getWARecords(Id recordId){
        Account acc = [SELECT Phone FROM Account WHERE Id =: recordId LIMIT 1];
        WARecordsWrapper wARecord = New WARecordsWrapper();
        wARecord.customer_number = acc.Phone;
        wARecord.wAMessageRecord = [SELECT BBDEC__MessageContext__c FROM BBDEC__WA_Message__c WHERE BBDEC__CustomerPhone__c =: acc.Phone LIMIT 1];
        
        return wARecord;
    }

    @AuraEnabled
    public String messaging_product; //whatsapp
    @AuraEnabled	
	public contacts[] contacts;
    @AuraEnabled
	public messages[] messages;
	public class contacts {
        @AuraEnabled
		public String input;	//917007691632
        @AuraEnabled
		public String wa_id;	//917007691632
	}
	public class messages {
        @AuraEnabled
		public String id;	//wamid.HBgMOTE3MDA3NjkxNjMyFQIAERgSOTExMzcwQzA4QUUwOUZFNzExAA==
	}
    public class WARecordsWrapper{
        @AuraEnabled
        public String customer_number;
        @AuraEnabled
        public BBDEC__WA_Message__c wAMessageRecord;
    }
}