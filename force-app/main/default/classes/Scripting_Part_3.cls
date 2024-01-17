public class Scripting_Part_3 {
    public static void createProductAndPriceBook() {
        try{
        List<Product2> proList = new List<Product2>();
        
        List<PricebookEntry> priceBook = new List<PricebookEntry>();
        Integer j = 2;
            
            for(Integer i=0;i<10;i++){
                	Product2 pro = new Product2();
                    pro.Name = 'Product '+i;
                    pro.Description = 'Purchase this product '+i;
                    pro.Family = 'Footware '+i;
                    pro.isActive = true;
                    proList.add(pro);
                
                

            }
        insert proList;
        Pricebook2 pb= new Pricebook2(Name='AngloPriceBook',IsActive = true);
        

        INSERT pb;
        System.debug(pb);
        Pricebook2 pbid=[Select id from Pricebook2 where IsStandard=true]; 
        for(Product2 i : prolist){
        	 PricebookEntry pBE  = new PricebookEntry();
            pBE.Pricebook2Id = pbid.Id;
            pBE.Product2Id = i.id;
            pBE.UnitPrice = 10000;
            pBE.IsActive = true;
            priceBook.add(pBE);
            
        }
        INSERT priceBook;     
        }
        catch(DmlException e){
        System.debug('Dml Exception hit '+e);
    	}
    	catch(QueryException e){
        System.debug('Query Exception hit '+e);
	    }
    	catch(Exception e){
        System.debug('Exception hit '+e);
    	}
        Finally{
            System.debug('-----    Code Compiled   -----');
        }
        
        
    }
}