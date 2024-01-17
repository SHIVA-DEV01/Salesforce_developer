@isTest
public class Scripting6Test {

    @isTest
    public static void updateOpportunityTest(){
        List<Opportunity> oppList = [Select Id,Name from Opportunity Where CloseDate>=:System.today() And Name like '%update' Limit 1];
        List<Opportunity> oppUpdateList = Scripting6.updateOpportunity();
        System.assertEquals(oppList, oppUpdateList);
    }
}