@isTest
public class Account_Trigger_Test {
	@isTest
    public static void employeeIsEqualContactTest(){
        List<Account> accList = TestDataFactory.accountDateFactory(10);
        Test.startTest();
        Insert accList;
        List<Contact> conList = [Select id , AccountId from Contact where LastName like 'TestData%'];
        Test.stopTest();
        System.assertEquals(accList[0].id, conList[0].AccountId);
        
    }
    @isTest
    public static void employeesGreaterThan100Test(){
        List<Account> accList = TestDataFactory.accountDateFactory(101);
        Test.startTest();
        Insert accList;
        List<Opportunity> oppList = [Select id, AccountId from Opportunity where Name like 'Default Opportunity'];
        Test.stopTest();
        System.assertEquals(accList[0].id, oppList[0].AccountId);
    }
}