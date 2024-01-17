public class Scripting_Part_3_4 {
    public static void sendOpportunityDetailsToContactEmail() {
        DAte a =date.today();
        Date b = a.addDays(10);

List<Opportunity> oppL = [SELECT Name, CloseDate, StageName, AccountId FROM Opportunity where CloseDate >: b ];
Set<Id> accIdSet = new Set<Id>();

for(Opportunity op : oppL){
    accIdSet.add(op.AccountId);
}

List<Contact> contacts = [SELECT Id, Email,AccountId FROM Contact WHERE AccountID IN : accIdSet];
Map<Id,Set<String>> mapAccIdWithEmails = new Map<Id,Set<String>>();

for(Contact con : contacts){
    if(!mapAccIdWithEmails.containsKey(con.AccountId)){
        mapAccIdWithEmails.put(con.AccountId, new Set<String>{con.Email});
        //system.debug(mapAccIdWithEmails);
    }else{
        Set<String> emailSet = mapAccIdWithEmails.get(con.AccountId);
        emailSet.add(con.Email);
        //system.debug('else value'+ emailset);
        mapAccIdWithEmails.put(con.AccountId, emailSet);
        //system.debug('else value'+ mapAccIdWithEmail);
        
    }
}
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
//for(String  emSet: emailSet){

Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] {'Shiva'};
message.optOutPolicy = 'FILTER';
message.subject = 'Subject Test Message';
message.plainTextBody = 'This is the message body.';
Messaging.SingleEmailMessage[] messages =  new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

/*if (results[0].success) {
    System.debug('The email was sent successfully.');
} else {
    System.debug('The email failed to send: ' + results[0].errors[0].message);
}
  */
    
//}
    }
}