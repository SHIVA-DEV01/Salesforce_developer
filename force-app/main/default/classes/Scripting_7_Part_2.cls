public class Scripting_7_Part_2 {
    public static List<Lead> leadVsProduct() {
        //Create a look up[Lead] on product so that Products come over in related list of a Lead.  Write script to create 3 Leads and 5 Products with Lead lookup field.
        try{
        List<Lead> leadList = new List<Lead>();
        List<Product2> proList = new List<Product2>();
        for(Integer i=0;i<3;i++){
            Lead led=new lead();
            led.LastName='Goku'+i;
            led.Status='Working - Contacted';
            led.Company='Tycoon '+i;
            leadList.add(led);
            for(Integer j=0;j<5;j++){
                Product2 pro = new Product2();
                //pro.Name = 'Product '+j;
                pro.Lead__c = leadList.get(i).Name;
                proList.add(pro);
                
            }
            system.debug(proList);
        }
        insert leadList;
        insert proList;
    }catch(DmlException e){
        System.debug('Dml Exception hit '+e);
    }
    catch(QueryException e){
        System.debug('Query Exception hit '+e);
    }
    catch(Exception e){
        System.debug('Exception hit '+e);
    }

	return null;
    }
}