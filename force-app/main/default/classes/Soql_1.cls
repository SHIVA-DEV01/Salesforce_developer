public class Soql_1 {
    public static List<Contact> contactName(){
        List<Contact> conList = [SELECT ID,Name FROM Contact WHERE Name LIKE '%A%'];
        System.debug(conList);
        return conList;
    }
}