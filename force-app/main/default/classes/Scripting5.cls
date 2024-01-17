public class Scripting5 {
    public static List<Contact> deletingContact(){
        List<Contact> conList = [Select Id from Contact Where Account.Name LIKE'A%' limit 5];
        delete conList;
        return conList;
    }
}