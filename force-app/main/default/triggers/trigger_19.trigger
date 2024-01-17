trigger trigger_19 on Lead (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Lead ld : Trigger.New){
            Trigger_handler.leadToShowErrorMessage(ld);
        }
    }
}