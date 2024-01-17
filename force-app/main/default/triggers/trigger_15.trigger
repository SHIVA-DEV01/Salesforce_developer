trigger trigger_15 on Event_Participant__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Event_Participant__c eventPart : Trigger.New){
            Trigger_handler.stopCreatingEventParticipantDay(eventPart);
        }
    }
}