public with sharing class AccountHelper {
        @AuraEnabled(cacheable=true)
        public static List<Account> getAccounts()
        {
           return [select Id, Name,Phone,Industry from Account where Phone!=null AND Industry != null limit 20]; 
        }
}