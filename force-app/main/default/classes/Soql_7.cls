public class Soql_7 {
    public static List<Contact> phoneNoNotMention(){
        List<Contact> conList = [Select Id , Name , Phone From Contact Where Phone = NULL order by Name];
        System.debug(conList);
        return conList;
    }
}