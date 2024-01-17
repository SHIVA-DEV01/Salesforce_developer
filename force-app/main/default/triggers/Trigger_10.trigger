trigger Trigger_10 on OpportunityLineItem (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        Trigger_handler.stopMoreThan2OppLineItem(Trigger.new);
    }
}