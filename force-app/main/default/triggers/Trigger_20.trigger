trigger Trigger_20 on Contact (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        Trigger_handler.fillMailAddressWithItsShippingAddress(Trigger.new);
    }
}