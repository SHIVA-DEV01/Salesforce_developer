@isTest
public with sharing class CreateContactTest_One {

    @isTest static void Create1() {
        Contact con = New Contact(LastName = 'Test 1', BBDEC__External_Id__c = 'aueb2f3d2dxsad');
        Insert con;
    }
}