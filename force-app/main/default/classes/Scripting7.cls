public class Scripting7 {
    public static List<user> displayUser(){
        List<User> userStr = [Select Id,Name,MobilePhone,Email,Profile.UserLicense.Name from User where Profile.UserLicense.Name = 'Salesforce'];
        System.debug('Information of User who use Salesforce License ---->'+userStr);
        return userStr;
    }
}