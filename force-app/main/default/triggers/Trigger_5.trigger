trigger Trigger_5 on Contact (After delete) {
    if(Trigger.isAfter && Trigger.isdelete){
        Trigger_handler.deleteContact(Trigger.old);
    }
}