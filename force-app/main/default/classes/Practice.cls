public class Practice {
   
    public static void practice1(){
        List<PricebookEntry> priceBookEntryList = new List<PricebookEntry>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityLineItem> oLTList = new List<OpportunityLineItem>();
        List<Product2> proList = new List<Product2>();
        
        
        for(Integer i=0;i<4;i++){
            Opportunity opp = new Opportunity();
            Product2 pro = new Product2();
            opp.Name = 'Test Opportunity '+i;
            opp.StageName = 'Close Won';
            opp.CloseDate = date.parse('10/12/2022');
            pro.Name = 'Test Product '+i;
            proList.add(pro);
            oppList.add(opp);
        }
        insert proList;
        insert oppList;
        
        
        /*Pricebook2 priBook = [Select id from Pricebook2 where IsStandard = True];
        for(Product2 pro2 : proList){
            PricebookEntry pBE = new PricebookEntry();
            pBE.Pricebook2Id = priBook.Id;
            pBE.Product2Id = Pro2.Id;
            pBE.UnitPrice = 1;
            pBE.IsActive = true;
            priceBookEntryList.add(pBE);
            
        }
        Insert priceBookEntryList;
        
        
        
        for(Integer j=0;j<4;j++){
            OpportunityLineItem oLT = new OpportunityLineItem();
            oLT.Product2Id = proList[j].Id;
            oLT.OpportunityId = oppList[j].Id;
            oLT.PricebookEntryId = priceBookEntryList[j].Id;
            oLT.Quantity = 10;
            oLT.TotalPrice = 44;
            oLTList.add(oLT);
        }
        insert oLTList;*/
    }
}