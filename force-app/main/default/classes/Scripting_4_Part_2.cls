public class Scripting_4_Part_2 {
    public static List<string> sameEmail(){
        List<Contact> conList = [Select Email from Contact];
        List<User> UseList = [Select Email from User where Profile.UserLicense.Name = 'Salesforce'];
        List<String> str = new List<String>();
        for(Contact i : conList){
            for(User j : UseList){
                if (i.Email == j.Email){
                    str.add(i.Email);
                }
            }
         
        }System.debug(str);
        return str;
        }
}