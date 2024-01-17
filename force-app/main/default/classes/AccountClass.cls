public class AccountClass {

    public static void Address(){
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for (Integer i=0;i<10;i++){
        	Account acc = new Account();
        	acc.Name = 'Shiva Verma'+i;
        	accList.add(acc);
            for (Integer j=0;j<10;j++){
                Contact con = new Contact();
                con.FirstName = 'Shiva ';
                con.LastName = 'Verma'+i+j;
                con.Phone = '963'+j+i+i+i+j;
                con.Email = 'ShivaVerma'+j+i+'@protonmail.com';
                con.AccountId = acc.Id;
                con.Account = acc;
                conList.add(con);
            }
        }
        insert accList;
        insert conList;
    }
}