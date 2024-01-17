public class ContactSave {
    @AuraEnabled 
    public static void saveContact(Contact con){
        insert con;
    } 
}