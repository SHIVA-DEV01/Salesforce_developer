public with sharing class AccountTableLwc {
    public AccountTableLwc() {

    }
    @AuraEnabled(cacheable=true)
    public static List<sObject> getContact()
    {
        
       return [select Account.BBDEC__Active__c,BBDEC__Ge__c, LastModifiedDate, PhotoUrl ,Account.Name , Name,Phone,Email  from Contact]; 
    }
}