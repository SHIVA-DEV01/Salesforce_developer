public class Soql_4 {
    public static List<Contact> whoseBirthToday(){
        List<Contact> conList = [SELECT id,Name, Birthdate FROM Contact WHERE Birthdate = today];
        System.debug(conList);
        return conList;
    }
}