trigger Trigger_14 on Event_Participant__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        Trigger_handler.noSameContactRegistered(Trigger.new);
    }
}