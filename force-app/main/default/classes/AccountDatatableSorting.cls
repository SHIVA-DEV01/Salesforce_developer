public class AccountDatatableSorting {
    @AuraEnabled
    public static list<Account> getAccountList(){
        List<Account> accList= [Select Id, Name, Phone, CreatedDate From Account Order By CreatedDate];
        if(accList != null && accList.size()>0){
            return accList;
        }
        else{return null;}
    }
}