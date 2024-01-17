public class SendEmailTemplatePopC {
    
    
    
    @auraEnabled
        public static string sendVf(string v,String emailget){
            system.debug(v);
          Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
    message.toAddresses = new String[] {emailget};
    message.optOutPolicy = 'FILTER';
    message.subject = 'OTP ';
    message.plainTextBody = 'Otp for the login is'+ v;
    Messaging.SingleEmailMessage[] messages =  new List<Messaging.SingleEmailMessage> {message};
    Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    
    if (results[0].success) {
        System.debug('The email was sent successfully.');
        return 'The email was sent successfully';
    } else {
        System.debug('The email failed to send: ' + results[0].errors[0].message);
        return NULL;
    }
      
            }
        
        
        
        
        @auraEnabled
        public static  void insertData(string password , string username){
            BBDEC__Personal_Info__c u = new BBDEC__Personal_Info__c();
            u.BBDEC__Username__c=username;
            u.BBDEC__Password__c=password;
            System.debug(u);
            insert u;
            
      
            }
        
        
        
            @auraEnabled
        public static BBDEC__Personal_Info__c fetchUser(string password1 , string username1){
            BBDEC__Personal_Info__c userfetch =[Select BBDEC__Username__c,BBDEC__Password__c from BBDEC__Personal_Info__c where BBDEC__Username__c=:username1 AND Password__c=:password1];
            if(userfetch!=null){
                   return userfetch;
            }
            else{
                return null;
                }
         
        }
        
        
        
        
        
    }