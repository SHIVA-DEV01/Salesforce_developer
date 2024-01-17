public class Soql_3 {
    public static List<Contact> fatchAllContact(){
        
        List<Contact> conList = [SELECT Id,Name FROM Contact WHERE Name LIKE '%A'];
        System.debug(conList);
        return conList;
    }
}