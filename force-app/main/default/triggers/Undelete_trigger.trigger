trigger Undelete_trigger on Account (after undelete) {
    if(Trigger.isAfter && Trigger.isUndelete){
        System.debug(Trigger.new);
    }
}