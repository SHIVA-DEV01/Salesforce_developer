public with sharing class AccountPubSub {
    public AccountPubSub() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountInfo()
    {
        return [Select Name,Type,Phone,Website FROM Account LIMIT 10];
    }


    @AuraEnabled
    public static Account getAccountdata(String acc)
    {
        if(acc!=''){
            Account accData = [Select Name,Type,Phone,Website FROM Account where id =: acc LIMIT 1];
            return accData;
        }
        else {
            return null;
        }
    }
}