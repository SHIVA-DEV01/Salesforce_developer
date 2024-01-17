public with sharing class EventHandler {
    @future (callout=true)
    public static void createEventInCalendar(Set<id> eventset) {
        try {System.debug('id>>>>>'+eventset);
            if(eventset.size()>0 && eventset != null){
            //    String token = GoogleAuthService.regenerateAccessToken();
               list<BBDEC__Google_Access_Token__c> tokenList = [Select BBDEC__Access_Token__c from BBDEC__Google_Access_Token__c limit 1];
               String Token = String.valueOf(tokenList[0].BBDEC__Access_Token__c);
               list<Event> eveList =  [Select id, Subject, StartDateTime, EndDateTime from Event where id In: eventset];
               System.debug('Event List >>>>>'+ eveList);
               System.debug('Date formate>>>>'+eveList[0].StartDateTime.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss'));
               
               System.debug('Debug in Event Handler token>>>>>>>'+token);
                for(Event eve: eveList){
                    HttpRequest req = new HttpRequest();
        
                    req.setMethod('POST');
                    req.setEndpoint('https://www.googleapis.com/calendar/v3/calendars/'+'Shiva.test369@gmail.com'+'/events');
                    req.setHeader('Authorization', 'Bearer '+token);
                    req.setHeader('Content-Type', 'application/json;charset=UTF-8');
                    req.setBody('{"summary":"'+eve.Subject+'","start":{"dateTime":"'+eve.StartDateTime.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss')+'+00:00","timeZone": "Asia/Kolkata"},"end": {"dateTime": "'+eve.EndDateTime.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss')+'+00:00", "timeZone": "Asia/Kolkata"}}');
                    req.setTimeout(60*1000);
                    System.debug('After set body>>>>>');
                    http callout = new http();
                    HttpResponse response = callout.send(req);
                    System.debug('Callout status>>>>'+response);
                    if (response.getStatusCode() != 201){
                        
                        System.debug('Post method is complete'+response.getStatusCode());
                    } else{
                        System.debug('response Body>>>>>>'+response.getBody());
                    }
                            }
                        }
        } catch (Exception e) {

            System.debug('Exception in Event Handler>>>>>'+e);
        }
    }
}