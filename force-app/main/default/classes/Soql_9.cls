public with sharing class Soql_9 {
    public static List<Contact> nameAllContact(){
        //Find Name of all contacts along with Account Name and website.
        List<Contact> conList = [Select Name , Account.Name , Account.website from Contact];
        System.debug(conList);
        return conList;
    }
}