@isTest
public class Opportunity_Trigger_Test {
	@isTest
    public static void opportunityCloseDateTest(){
        List<Opportunity> oppList = TestDataFactory.opportunitySingleDataFactory();
        Test.startTest();
        Insert oppList;
        Test.stopTest();
        
    }
    
    @isTest(SeeAllData = True)
    public static void notAllowUserToAddaPriceBookTest(){
        List<Opportunity> oppList = TestDataFactory.OpportunityTest();
        Insert oppList;
        
    }
}