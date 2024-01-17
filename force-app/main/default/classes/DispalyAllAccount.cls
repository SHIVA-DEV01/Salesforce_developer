public class DispalyAllAccount {
    @AuraEnabled
    public static List<Account> fetchAccountInfo(){
        List<Account> showAcc = [SELECT Id,Name FROM Account];
        return showAcc; 
    }
    @AuraEnabled
    public static List<Contact> fetchContact(String accId){
        List<Contact> showCon = [SELECT AccountId,LastName FROM Contact WHERE AccountId =: accId];
        return showCon;
    }
    @AuraEnabled
    public static List<Opportunity> fetchOpportunity(String accId){
        List<Opportunity> showOpp = [SELECT AccountId,Name FROM Opportunity WHERE AccountId =: accId];
        return showOpp;
    }
}