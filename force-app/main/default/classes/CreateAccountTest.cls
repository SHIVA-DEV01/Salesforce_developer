@isTest
public class CreateAccountTest {

    @isTest
    public static void createTenAccount(){
        List<Account> accList = Scripting1.createAccount();
        system.debug(accList.size());
        System.assertEquals(accList.size(),20);
    }
}