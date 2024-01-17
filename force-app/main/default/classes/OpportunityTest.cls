@isTest
public class OpportunityTest {
    @isTest
    public static void createAccountAndOpportunityCreateBydefaultTest(){
        List<Account>accList = TestDataFactory.accountDateFactory();
        CreateOpportunity.createAccountAndOpportunityCreateBydefault(accList);
        System.assert(accList.size()>0);
    }

    @isTest
    public static void deleteMethodTest(){
        List<Account> accList = TestDataFactory.accountDateFactory();
        test.startTest();
        Insert accList;
        List<Account> acc = DelAccount.deleteMethod();
        test.stopTest();
    }
    
    @isTest
    public static void listOfListTest(){
        ListOfList.test();
    }
    
    @isTest
    public static void MapTest(){
		MapTest.main();
    }
    
    @isTest(SeeAllData = true)
    public static void getQuantitythen100Test(){
        OpportunityggLineggItem.getQuantitythen100();
    }
    
    @isTest
    public static void pattTest(){
        Patten.patt();
    }
    
    @isTest
    public static void patten2Test(){
        Patten2.patt();
    }
    
    @isTest
    public static void PracticeTest(){
        Practice.practice1();
    }
    
    @isTest
    public static void test_369Test(){
        List<Account> accList = TestDataFactory.accountDataFactory();
        Test.startTest();
        Insert accList;
        Test369.test_369();
        Test.stopTest();
        
    }
    
    @isTest(SeeAllData = true)
    public static void pbook(){
        Testques.pbook();
    }
    
    @isTest(SeeAllData = true)
    public static void contactDeadThenAccountBlock(){
        TestYourself.contactDeadThenAccountBlock();
        
    }
}