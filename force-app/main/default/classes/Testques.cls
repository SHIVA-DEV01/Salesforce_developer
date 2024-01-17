public class Testques {
    Public static void pbook(){
        pricebook2 pb= new pricebook2(Name = 'Algo Price Book' , isActive=true);
        insert pb;
        
        List<Product2> prolist=new List<Product2>();
        for(integer i=0;i<10;i++){
            Product2 temp=new Product2(Name = 'Name'+i, isActive = true);
            prolist.add(temp);
        }
        insert prolist;
        
        Pricebook2 standardPriceBook = [SELECT Id From Pricebook2 Where isStandard = true];
        system.debug(standardPriceBook);
        
        List<Pricebookentry> splist = new List<Pricebookentry>();
        for(Product2 i : prolist){
            Pricebookentry standardPriceBookEntry = new Pricebookentry();
            standardPriceBookEntry.Pricebook2Id = standardPriceBook.Id;
            standardPriceBookEntry.Product2Id = i.Id;
            standardPriceBookEntry.UnitPrice = 100;
                //UseStandardPrice = false;
            standardPriceBookEntry.IsActive = true;
                 splist.add(standardPriceBookEntry);
        }
        insert splist;
        
        List<Pricebookentry> pList = new List<Pricebookentry>();
        for(Product2 i: prolist){
            Pricebookentry pen= new Pricebookentry(Pricebook2Id = pb.Id,
                                                  UnitPrice=90,
                                                  Product2Id =i.id,
                                                  UseStandardPrice = True,
                                                  IsActive = true);
            pList.add(pen);
        }
        //insert pList;
        system.debug(pList);        
    }
}