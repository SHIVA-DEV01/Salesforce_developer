trigger Trigger_7 on Opportunity (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        Trigger_handler.contactAddInOpportunity(Trigger.New);
    }
}