public class Scripting_Part_31 {
public static void opportunity10(){
        Integer j = 0;
    	Integer k = 0;
        List<Opportunity> oppList = new List<Opportunity>();
        List<Product2> proList1 = [Select Id,Name From Product2 LIMIT 10];
        List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>();
        for(Product2 pro : proList1){
            Opportunity opp = new Opportunity();
            opp.Name = 'Opportunity '+ j;
            opp.CloseDate = date.parse('9/12/2022');
            opp.StageName = 'Close Won';
            oppList.add(opp);
            
            j = j+1;
	            
        }
        insert oppList;
    PricebookEntry priceBookList = [Select id,Name from PricebookEntry where Name = 'Product 0'];
	
    for(Product2 i : proList1){
        
        OpportunityLineItem oppLineItem = new OpportunityLineItem();
        
        
        oppLineItem.OpportunityId = oppList[k].id;
        oppLineItem.Product2Id = i.id;
        oppLineItem.Quantity = k+1;
        oppLineItem.UnitPrice = 10000;
        oppLineItem.PricebookEntryId = priceBookList.id;
        oppLineItemList.add(oppLineItem);
        k = k+1;
        }
    insert oppLineItemList;
        
    }
}