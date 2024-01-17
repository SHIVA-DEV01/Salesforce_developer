trigger Event_Trigger on Event (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        set<id> setEvent = new Set<id>();
        for(Event eve: trigger.new){
            setEvent.add(eve.id);
            EventHandler.createEventInCalendar(setEvent);
        }
        
    }
}