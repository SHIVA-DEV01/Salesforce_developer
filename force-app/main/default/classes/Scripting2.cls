public class Scripting2 {
    public static List<Contact> createContact(){

        List<Contact> conList = new List<Contact>();
        List<Account> accList = [Select Id from Account Where Rating = 'Hot' LIMIT 10];
        for (Integer i=0;i<10;i++){
            Contact con = new Contact();
            con.AccountId = accList[i].id;
            con.FirstName = 'Goku'+1;
            con.LastName = 'Gohan '+i;
            con.Phone = '742'+i+i+i+'914';
            System.debug(con);
            
            conList.add(con);
       }
        insert conList;
       

        return conList;
    }
}