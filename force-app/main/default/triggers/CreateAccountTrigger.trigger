trigger CreateAccountTrigger on Account (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        CreateOpportunity.createAccountAndOpportunityCreateBydefault(Trigger.New);
    }
}