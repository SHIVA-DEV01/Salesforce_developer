trigger test_3 on Contact (After Delete) {
    if(Trigger.isAfter && Trigger.isDelete){
        List<Contact> conList = [Select id , AccountId from Contact where AccountId =: Trigger.old[0].AccountId];
        Account acc = [Select id from Account where id =: Trigger.old[0].AccountId];
        acc.Number_of_Contact__c = conList.size();
        update acc;
    }
}