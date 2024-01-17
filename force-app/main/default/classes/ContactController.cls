public with sharing class ContactController {

    @AuraEnabled
    public static List<Contact> show(){
        List<Contact> contacts = [Select Id,FirstName,LastName,Phone from Contact limit 50];
        return contacts;
    }
}