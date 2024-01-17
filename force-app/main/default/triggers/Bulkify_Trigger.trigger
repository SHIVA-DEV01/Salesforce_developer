trigger Bulkify_Trigger on Campaign (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        System.debug(Trigger.new);
    }
}