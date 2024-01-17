trigger DemoTrigger on Account (after insert) {
    system.debug('I am in Trigger Block');
    if(Trigger.isAfter && Trigger.isInsert){
        List<Contact> conList = new List<Contact>();
        for(Account accRec: Trigger.New){
            Contact con = new Contact();
            con.LastName = accRec.Name ;
            //con.AccountId = accRec.Id;
            conList.add(con);
        }
        Insert conList;

        /*for(Account accRec:Trigger.New){
            //if(accRec. != Null && accRec.BillingCountry){}
            accRec.ShippingCity = accRec.BillingCity;
            accRec.ShippingState = accRec.BillingState;
            accRec.ShippingCountry = accRec.BillingCountry;
            accRec.ShippingStreet = accRec.BillingStreet;
            accRec.ShippingPostalCode = accRec.BillingPostalCode;
            
            }
        }*/
    }
}