trigger Trigger_4 on Contact (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        Trigger_handler.updateAccountName(Trigger.new);
    }
}