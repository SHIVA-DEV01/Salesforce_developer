Global class DeleteAccountBatch implements database.batchable <sobject> , schedulable {
    global database.QueryLocator Start(Database.BatchableContext bc ){
     
        return Database.getQueryLocator('SELECT Id FROM Account where createdDate<last_n_days:5 and  createdDate=last_n_days:20 ');
    }
    global void execute(Database.BatchableContext bc , list<Account>accountsList){
         delete accountsList;

    }
    global void finish(database.BatchableContext bc){
        
    }
    global void execute(schedulableContext scx){
        DeleteAccountBatch batchobject = new DeleteAccountBatch();
        database.executeBatch(batchobject);
    }
    

}