public class Soql_2 {

    public static List<Contact> fatchAllContact(){
        
        List<Contact> conList = [SELECT Id,Name FROM Contact WHERE Name LIKE 'A%'];
        System.debug(conList);
        return conList;
    }
}