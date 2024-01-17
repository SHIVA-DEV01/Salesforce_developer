trigger Trigger_3 on Product2 (after insert) {
    if(Trigger.isInsert && Trigger.Isafter){
        Trigger_handler.setupPriceBook(Trigger.new);
    }
}