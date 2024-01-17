trigger demo_trigger on Account (after Update) {

   if(trigger.isUpdate && trigger.isbefore){
       list <Contact> conList =new list <Contact>();
       list <Contact> con =[SELECT AccountId,MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact];
       for(Account accRec : trigger.new){
           Account accOldRec=trigger.oldMap.get(accRec.Id);
           Account accNewRec = trigger.newMap.get(accRec.Id);
           for(Contact conRec : con){
               if(conRec.AccountId==accRec.id){
                   if(accOldRec.BillingStreet!=accNewRec.BillingStreet || accOldRec.BillingCity!=accNewRec.BillingCity || accOldRec.BillingCountry != accNewRec.BillingCountry || accOldRec.BillingPostalCode!=accNewRec.BillingPostalCode || accOldRec.BillingState!=accNewRec.BillingState){

                         conRec.MailingStreet=accRec.BillingStreet;


                         conRec.MailingState=accRec.BillingState;
                           
                           conRec.MailingCity=accRec.BillingCity;
                       
                   
                       conRec.MailingPostalCode=accRec.BillingPostalCode;
              
                       conRec.MailingCountry=accRec.BillingCountry;
                   
        conRec.Accountid=accRec.id;
                   conlist.add(conRec);
                   }}
           }
           Update conlist;
        }
       
   }
}