global class LeadBatchClass implements Database.Batchable<sobject>{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return  Database.getQueryLocator('Select leadsource,rating from lead');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead l: scope){
            if(l.leadsource=='web'){
                l.rating = 'warm';
            }
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('He Navneet' + bc);
    }
}