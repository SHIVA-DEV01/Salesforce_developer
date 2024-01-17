public class Scripting_Part_3_3 {
    public static void moreThan2OpportunityLineItemPrintAllAccount(){
        List<AggregateResult> oppLineItemList = [select Opportunity.Account.Name from OpportunityLineItem group by Opportunity.Account.Name having count(id)>2];
        for(AggregateResult oppLineItem: oppLineItemList){
            System.debug(oppLineItem);
        }
    }
}