trigger PlatformEventPublish on Account (after insert , after update) {
	If(trigger.isAfter && trigger.isUpdate){
        List<BBDEC__Test_Event__e> publishEvents = new List<BBDEC__Test_Event__e>();
        for(Account a : Trigger.new){
            BBDEC__Test_Event__e eve = new BBDEC__Test_Event__e();
            eve.BBDEC__Name__c = a.Name ;
            eve.BBDEC__Phone__c = a.Phone ;
            publishEvents.add(eve);            
        }
        if(publishEvents.size()>0){
            EventBus.publish(publishEvents);
        }
        
    }
}