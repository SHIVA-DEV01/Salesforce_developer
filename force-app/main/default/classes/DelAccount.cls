public class DelAccount {
    public static List<Account> deleteMethod(){
        List<Account> accList = [Select Id from Account where Name Like 'T%'];
        delete accList;
        return accList;
    }
}