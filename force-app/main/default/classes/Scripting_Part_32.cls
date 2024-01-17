public class Scripting_Part_32 {
    public static void moreThan2OpportunityLineItemPrintAllAccount(){
        List<Opportunity> oppList = [Select id, Name from Opportunity];
        List<OpportunityLineItem> oppLineItemList = [Select id, Name from OpportunityLineItem];
        List<Account> accList = [Select id, Name from Account];
        List<Opportunity> opp1List = new List<Opportunity>();
        for(Opportunity opp : oppList){
            for(OpportunityLineItem oppLineItem : oppLineItemList){
                if(opp.id == oppLineItem.OpportunityId){
                    Opportunity opp1 = new Opportunity();
                    opp1.id = opp.id;
                    opp1.AccountId = opp.AccountId;
                    opp1List.add(opp1);
                    
                }
                
            }
            
        }
    }
}