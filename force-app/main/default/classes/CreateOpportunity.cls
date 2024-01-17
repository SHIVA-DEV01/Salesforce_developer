public class CreateOpportunity {
    Public static void createAccountAndOpportunityCreateBydefault(List<Account> accList){
        List<Opportunity> oppList = new List<Opportunity>();
        List<Account> accListSec = new List<Account>();
        for(Account acc : accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.CloseDate = date.parse('10/10/2022');
            opp.StageName = 'Closed Won';
            oppList.add(opp);
            if(acc.Rating == 'Hot'){
                Account acc1 = new Account();
                acc1.Rating = 'Warm';
                acc1.id = acc.id;
                accListSec.add(acc);
            }
        }
        if(oppList.size()>0){
            Insert oppList;
        }
        Upsert accListSec;
        
    }
}