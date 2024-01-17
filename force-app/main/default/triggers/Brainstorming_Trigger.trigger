trigger Brainstorming_Trigger on Policy__c (Before Update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        BrainStorming2.BrainStorming2_test(Trigger.New);
    }
}