public class Scripting1 {
    public static List<Account> createAccount(){
        List<Account> accList = new List<Account>();
        for (Integer i=0;i<20;i++){
            Account acc = new Account();
            acc.Name = 'Naruto '+i;
            acc.Rating = 'Hot';
            acc.AccountNumber = '653'+i+i+'00'+i;
            acc.Phone = '783'+i+'95'+i+'4'+i+i;
            acc.Fax = '983'+i+i+'88';
            accList.add(acc);
        }
        insert accList;
        
        return accList;
    }
}