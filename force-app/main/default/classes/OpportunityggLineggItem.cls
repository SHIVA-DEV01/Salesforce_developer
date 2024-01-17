public class OpportunityggLineggItem {
    public static void getQuantitythen100(){
        try{
            /*Write a Script to get all the Products Name(in a list) which were sold with one-time Quantity(Opportunitylineitem) > 100 under their Opportunities(CLOSED WON only).

			Note - Consider Only that OpportunityLineItems whose first entered Quantity value > 100.
			For example - OpportunityLineItem - OppL1 (Product - p)-> Quantity = 120
			OppL2 (Product - p1)-> Quantity = 80
			OpplL3 (Product - p1) -> Quantity = 30
			Only OppL1 should be considered for ProducName.4"*/
            Integer k =0;
            List<sObject> sObjectList = new List<sObject>();
            List<Product2> oppList = [Select id , Name from Product2];
            List<sObject> OpportunityLineItemList = [Select PricebookEntry.product2Id from OpportunityLineItem where Quantity > 9 And Opportunity.StageName = 'Close Won' ];
            System.debug(OpportunityLineItemList);
            for(Product2 i :oppList ){
                Product2 str = new Product2() ;
                
                for(sObject sObj : OpportunityLineItemList){
                    system.debug(sObj.get(PricebookEntry.product2Id));
                }
            }

        }catch(DmlException e){
            System.debug('DmlException hit '+ e);
        }catch(QueryException e){
            System.debug('QueryException hit '+ e);
        }catch(Exception e){
            System.debug('Excetion hit '+ e);
        }Finally{
            System.debug('-------- Code Complied -------');
        }
    }
}