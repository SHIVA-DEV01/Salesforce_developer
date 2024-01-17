public class Brainstroming {
    public static void getOpportunity(){
        List<Product2> proList = [Select id , Name From Product2];
        List<sObject> oppLI = [SELECT Id, Product2Id, PricebookEntryId, Name, Quantity FROM OpportunityLineItem where Quantity > 4 And Opportunity.StageName = 'Close Won'];
        System.debug(proList);
        System.debug(oppLI);
     }
}