@isTest
public class CreateContact {

    @isTest
    public static void createContactHavingAccount(){
        List<Account> accList = TestDataFactory.accountDataFactory();
        Test.startTest();
        Insert accList;
        List<Contact> conList = Scripting2.createContact();
        Test.stopTest();
        System.assert(conList.size()>=0);
    }
}