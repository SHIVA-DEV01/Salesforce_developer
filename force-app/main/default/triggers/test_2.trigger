trigger test_2 on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Contact> conList = [Select id, MailingCity from Contact where AccountId =:Trigger.New[0].id];
        system.debug(conList);
        for(Account acc : trigger.New){
        for(Contact con : conList){
            if( acc.BillingCity != Trigger.OldMap.get(acc.id).BillingCity){
            con.MailingCity = acc.BillingCity;
            }
        }
        }
        Update conList;
    }
}