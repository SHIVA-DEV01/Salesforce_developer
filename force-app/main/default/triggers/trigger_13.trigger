trigger trigger_13 on Plan__c (before insert) {
    if(Trigger.isInsert && Trigger.isBefore){
        for(Plan__c plan : Trigger.New)
        Trigger_handler.stopCreatingAnyMorePlan(plan);
    }
}