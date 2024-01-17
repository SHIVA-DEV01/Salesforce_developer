public class TotalOrder {
    public static void caculatetotalorder(){
        List<Opportunity> oppList = [Select id , Total_Order__c from Opportunity];
        System.debug(oppList);
    }
}