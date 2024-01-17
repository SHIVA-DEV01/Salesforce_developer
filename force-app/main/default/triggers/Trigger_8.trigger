trigger Trigger_8 on Campaign (after Update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Trigger_handler.updateCampaignIsCompleted(Trigger.new);
    }
}