@isTest
public class Scripting5Test {

    @isTest
    public static void deletingContactTest(){
        List<Contact> conList = Scripting5.deletingContact();
        System.assert(conList.size() == 0);
    }
}