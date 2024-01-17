@isTest
public class Scripting3Test {
    @isTest
    public static void createOpportunityTest(){
        List<Opportunity> oppList = Scripting3.createOpportunity();
        System.assert(oppList.size()>0);
    }
}