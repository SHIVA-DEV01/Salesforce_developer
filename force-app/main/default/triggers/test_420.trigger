trigger test_420 on Account (before Update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Account acc : Trigger.New){
            for(Account acc1 : Trigger.old)
                if(acc.Phone != acc1.Phone){
                acc.Name = acc.Name + acc.Phone;
            }
            
        }
    }
}