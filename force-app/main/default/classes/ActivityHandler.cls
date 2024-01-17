public with sharing class ActivityHandler {
    public static void forEmail(List<Task> taskList){
        try {
            Set<id> setId = new Set<id>();
        list<Account> accList = new list<Account>();
        for (Task t : taskList) {
            setId.add(t.WhatId);
        }
        List<Account> newAccList = [SELECT Name,(SELECT Status,Subject from ActivityHistories where Subject like 'Email:%') FROM Account where id In: setId];
        for(Account acc : newAccList){
            Account tempAcc = new Account();
            tempAcc.id = acc.id;
            tempAcc.BBDEC__EmailCount__c = acc.ActivityHistories.size();
            accList.add(tempAcc);
            System.debug(acc.ActivityHistories.size());
        }
        upsert accList;
    
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR,'ERROR MESSAGE '+ex.getMessage()+' ERROR LINE NUMBER '+ ex.getLineNumber());
        }
        
}
}