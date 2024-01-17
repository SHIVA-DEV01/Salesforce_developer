trigger Trigger_16 on Opportunity (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Opportunity opp: Trigger.New){
            Trigger_handler.notAllowUserToAddaPriceBook(opp);
        }
    }
}