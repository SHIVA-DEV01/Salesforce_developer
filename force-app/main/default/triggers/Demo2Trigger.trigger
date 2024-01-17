trigger Demo2Trigger on Account (before update) {
    if(Trigger.isBefore && Trigger.IsUpdate){
        /*System.debug('Old Trigger');
        System.debug(Trigger.old);
        System.debug('New Trigger');
        System.debug(Trigger.new);*/
        
        for(Account accRec: trigger.new){
            Account accRecOld = Trigger.oldMap.get(accRec.id);
            if(accRec.Active__c == 'Yes'){
                accRec.addError('Can not be update');
            }
        }
    }
}