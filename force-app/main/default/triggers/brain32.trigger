trigger brain32 on Flight_Passenger__c (before insert) {
	if(trigger.isbefore && trigger.isinsert)
    {
        List<Flight_Passenger__c> flyPassList = [Select id, Flight__c, Passenger__c, Section__c from Flight_Passenger__c ];
        for(Flight_Passenger__c fly : trigger.new){
            for(Flight_Passenger__c fly2 : flyPassList){
                if(fly.Section__c == fly2.Section__c && fly.Passenger__c == fly2.Passenger__c && fly.Flight__c == fly2.Flight__c){
                    fly.adderror('error');
                }
            }
        }
    }
    
}