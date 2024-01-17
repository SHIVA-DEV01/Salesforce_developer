trigger OnBoardingTrigger on Test_Event__e (after insert) {
    List<Account> acc = new List<Account>();
    for(Test_Event__e oBording :trigger.new){
        acc.add(new Account(Name =oBording.BBDEC__Name__c , Phone =oBording.BBDEC__Phone__c));
    }
    if(acc.size() >0){
        insert acc ;
    }
}