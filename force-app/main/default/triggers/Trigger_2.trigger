trigger Trigger_2 on Opportunity (before insert, before update, after insert, after update) {
    if(Trigger.isbefore && Trigger.isInsert){
        Trigger_handler.opportunityCloseDate(trigger.new);
        for(Opportunity opp: Trigger.New){
            Trigger_handler.notAllowUserToAddaPriceBook(opp);
        }
    }
    else if(Trigger.isbefore && Trigger.isupdate){
        Trigger_handler.showAlertOpportunityClose(Trigger.New);
    }
    else if(Trigger.isAfter && Trigger.isInsert){
        Trigger_handler.contactAddInOpportunity(Trigger.New);
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
        Trigger_handler.createCaseWhenOpportunityTrigger(Trigger.new);
    }
}