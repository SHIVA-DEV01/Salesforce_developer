global class FetchAllLeadSendEmail implements Database.Batchable<sObject>{
    global database.QueryLocator start(Database.BatchableContext bC){        
        
        return database.getQueryLocator('Select id, Name, Company from Lead where CreatedDate = yesterday');
    }
    
    global void execute(Database.BatchableContext bC , List<Lead> ld){
            }
    
    global void finish(Database.BatchableContext bC){
        
        List<Lead> leadList = [Select id,Name,Company from Lead where Phone = null And CreatedDate = today];
        if(leadList.size()>0){
        List<User> UserList = [Select Email from User Where Profile.Name = 'System Administrator'];
        
        messaging.SingleEmailMessage message = new messaging.SingleEmailMessage();
        message.toaddresses = new string[] {UserList[0].Email};
        message.subject = 'Lead without Phone Number '+ date.today().addDays(-1);
        for(Lead ld: leadList){
        message.plaintextbody = 'Name :-  ' + ld.Name +'\n'+'Company :-  '+ ld.Company + '\n'+'\n' ;
            }
        Messaging.SingleEmailMessage[] messages =  new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
    		System.debug('The email was sent successfully.');
		} else {
    		System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
		}
  
        
    }

}