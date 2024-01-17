trigger trigger_21 on Contact (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Contact con : Trigger.New){
            Trigger_handler.createACheckBox(con);
        }
    }
}