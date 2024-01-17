public class Contact_Controller {
    @AuraEnabled
     public static String getDetails(String uname, String password)
     { 
         List<User> con_List=[Select Id, Username, BBDEC__Password__c from User where Username =: uname Limit 1];
         if(con_List.size() == 0)
         {
            return 'User does not exist'; 
         }
         else if(con_List[0].BBDEC__Password__c==password)
             {
                 return 'success';
             }
             else
             {
                 return 'Invalid password please try again!!!!';
             }

     }






     @AuraEnabled
    public static  List<Account> getAccounts(Integer pageSize, Integer pageNumber){
        Integer offset = (pageNumber - 1) * pageSize;
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, Name, AccountNumber, Industry, Phone FROM Account LIMIT :pageSize OFFSET :offset];
        return accList;
    }
    
    //Delete Account
    @AuraEnabled
    public static void deleteAccount(Account acc){
        system.debug('the id is' +acc.Id);
        Account acc1=[select Id,Name from Account where Id=:acc.Id limit 1];
        system.debug(acc1.id);
        
         delete acc1;
        if(acc1==null){
            system.debug('the value is null');
        }
        else{
            system.debug('value is there');
        }
    } 
    
     @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        String name =  + searchKey + '%';
        return [SELECT Id, Name, AccountNumber, Industry, Phone FROM Account WHERE name LIKE :name];
    }
    
     @AuraEnabled
    public static void insertAccount(Account acc){
        system.debug('acc'+acc.Name);
        
            insert acc;
    }
    
    
     @AuraEnabled
    public static Account View(string AccId){
        Account acc=[SELECT Name,Type,Phone,NumberOfEmployees FROM Account WHERE Id=:AccId LIMIT 1];
            system.debug('view Account '+acc.Name);
            return acc;
       
    }
    

    
    @AuraEnabled
    public static void EditAccountDetail(Account Acc){
        system.debug('Account '+Acc.Id);
        if(Acc!=null){
            Database.update(acc);
        }
    }



    @AuraEnabled
    public static string PermissionSet(){
    String permission_Set_Id = [SELECT Id FROM PermissionSet WHERE Label='PermissionUser'].Id;
        system.debug('Permission Set Id > '+permission_Set_Id );
        String user_Id = [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSetId =: Permission_Set_Id].AssigneeId;
        system.debug('User Id > '+user_Id);
        String user_Name = [SELECT Username FROM User WHERE Id=:User_Id].Username;
        system.debug('Username > '+user_Name);
        return user_Name;

    }


 }