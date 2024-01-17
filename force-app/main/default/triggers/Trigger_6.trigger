trigger Trigger_6 on Opportunity (before update) {
    if(Trigger.isbefore && Trigger.isupdate){
        Trigger_handler.showAlertOpportunityClose(Trigger.New);
    }
}