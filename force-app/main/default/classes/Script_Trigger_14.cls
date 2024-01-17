public class Script_Trigger_14 {
    public static void create10EventParticipant(){
        List<Event_Participant__c> eventPartList = new List<Event_Participant__c>();
        for(Integer i=1;i<=10;i++){
            Event_Participant__c eventPart = new Event_Participant__c();
            if(i<=4){
                eventPart.Multipicklist__c = 'Presenter';
            }
            else if(i <= 6){
                 eventPart.Multipicklist__c = 'Organizer';
                
            }
            else{
                 eventPart.Multipicklist__c = 'Attendee';
            }
            eventPartList.add(eventPart);
        }
        Insert eventPartList;
    }
}