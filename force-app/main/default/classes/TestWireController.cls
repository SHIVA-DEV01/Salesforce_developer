public with sharing class TestWireController {
    @AuraEnabled(cacheable=true)
    public static Account testWireMethod() {
        // testWireMethod1();
        return [SELECT Id, Name, Phone, Website FROM Account LIMIT 1];
    }
    @AuraEnabled
    public static void testWireMethod1() {
        Account acc = new Account();
        acc.Name = 'Test Wire';
        insert acc;
    }
}