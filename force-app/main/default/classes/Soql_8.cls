public class Soql_8 {
   // Find not more than five records from contact whose birthday is today,
   //  gender is Male and emil is not mentioned.
    public static List<Contact> findNotMore (){
        List<Contact> conList = [select Name from Contact where Birthdate = today AND Ge__c = 'Male' AND Email = NULL LIMIT 5 ];
        System.debug(conList);
        return conList;
    }
}