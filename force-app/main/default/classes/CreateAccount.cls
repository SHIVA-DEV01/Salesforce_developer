public class CreateAccount {
    @AuraEnabled
    public static string createAcc(Account acc) {
        System.debug('Account:'+acc);
        insert acc;
        return acc.Name;
    }
}