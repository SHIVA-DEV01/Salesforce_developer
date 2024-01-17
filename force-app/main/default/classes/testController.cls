public class testController {
    public static List<Contact> getTest(){
        List<Contact> conList = database.query('Select id, Name, Account.Name from Contact');
        return conList;
    } 
}