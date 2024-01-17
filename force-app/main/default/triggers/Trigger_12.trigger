trigger Trigger_12 on Opportunity (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Trigger_handler.createCaseWhenOpportunityTrigger(Trigger.new);
    }
}