trigger TriggerOnActivity on Task (After insert) {

    if (trigger.isAfter && trigger.isInsert) {
        ActivityHandler.forEmail(trigger.new);
        EngagementIndicator.updateEngagementIndicator(Trigger.New);
        System.debug('In After insert');
    }
    
        
    
}
    // system.debug('*** after insert mcontactCount'+mcontactCount);