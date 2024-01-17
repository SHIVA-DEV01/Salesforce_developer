@isTest
public class Scripting_Part_3Test {

    @isTest(SeeAllData = true)
    public static void createProductAndPriceBookTest(){
		
        Scripting_Part_3.createProductAndPriceBook();
        
    }
    
    @isTest
    public static void moreThan2OpportunityLineItemPrintAllAccountTest(){
        Scripting_Part_3_3.moreThan2OpportunityLineItemPrintAllAccount();
    }
    
    @isTest(SeeAllData = true)
    public static void sendOpportunityDetailsToContactEmailTest(){
        Scripting_Part_3_4.sendOpportunityDetailsToContactEmail();
    }
    
    @isTest(SeeAllData = true)
    public static void opportunity10Test(){
        Scripting_Part_31.opportunity10();
    }
    
    @isTest(SeeAllData = true)
    public static void moreThan2OpportunityLineItemPrintAllAccount2Test(){
        Scripting_Part_32.moreThan2OpportunityLineItemPrintAllAccount();
	}
    
}