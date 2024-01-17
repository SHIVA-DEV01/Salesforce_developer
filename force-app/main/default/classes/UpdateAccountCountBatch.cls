global class UpdateAccountCountBatch implements database.Batchable<sObject>, schedulable {
    global database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id ,(select Name from Contacts) from account');
    }
    global void execute(Database.BatchableContext bc, List<Account> accList){
        List<Account> accNewList = new List<Account>();
        if(accList.size()>0){
            
            for(Account aR: accList){
                if(aR.Contacts.size()>0){
                    Account acc = new Account();
                    acc.Id = aR.id;
                    acc.Count__c = aR.Contacts.size();
                    accNewList.add(acc);
                    }
                else{
                    Account acc = new Account();
                    acc.Id = aR.id;
                    acc.Count__c = 0;
                    accNewList.add(acc);
                }
                }
                
            }
            Update accNewList;
        }
    global void finish(database.BatchableContext bc){
        System.debug('Execute');
    }
    
    global void execute(schedulableContext sC){
        UpdateAccountCountBatch updateAccountCountSchedule = new UpdateAccountCountBatch();
        database.executeBatch(updateAccountCountSchedule);
    }
    
}