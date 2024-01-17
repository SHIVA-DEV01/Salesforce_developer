global class CreateOppDailyBatch implements database.Batchable<sObject>, schedulable{
    global database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select id from Opportunity');
    }
    global void execute(Database.BatchableContext bc, List<Opportunity> oppList){
        List<Opportunity> oppNewList = new List<Opportunity>();
        for(Integer i=0;i<5;i++){
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity'+i;
        opp.CloseDate = date.parse('04/06/2022');
        opp.StageName = 'Closed Won';
        oppNewList.add(opp);
        }
        Insert oppNewList;
        
    }
    global void finish(database.BatchableContext bc){
        System.debug('Execute');
    }
    
    global void execute(schedulableContext sCX){
        CreateOppDailyBatch scheduleDailyBatch = new CreateOppDailyBatch();
        database.executeBatch(scheduleDailyBatch);
    }
}