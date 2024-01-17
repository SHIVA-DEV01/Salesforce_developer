public class AccountsController {
    //Get Account Records
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
        Delete acc;
    } 
    
    
    @AuraEnabled
    public static List<Account> findByName(String searchKey) {
        String name =  + searchKey + '%';
        return [SELECT id, name, phone,type FROM Account WHERE name LIKE :name];
    }

    @AuraEnabled
    public static Account editrecords(String recordId){
        Account acc = [SELECT id,name,phone,type FROM Account WHERE id =: recordId];
        Update acc;
        return acc;
    }


    @AuraEnabled
    public static BBDEC__Personal_Info__c ProfileRec(String emailName){
        BBDEC__Personal_Info__c Pro = [SELECT id,BBDEC__Name__c,BBDEC__Username__c,BBDEC__Password__c FROM BBDEC__Personal_Info__c WHERE BBDEC__Username__c =: emailName LIMIT 1];
        return Pro;
    }
    
}