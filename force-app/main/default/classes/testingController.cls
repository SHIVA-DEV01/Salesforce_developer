public with sharing class testingController {
    @AuraEnabled
    public static List<Account> show() {
        return [Select Name from account Limit 10];
    }
}