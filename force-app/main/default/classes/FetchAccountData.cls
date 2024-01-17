public class FetchAccountData {
    public List<Account> getAccounts(){
        List<Account> accList = Database.query('Select Id, Name, Phone from Account Limit 100');
        return accList;
    }
}