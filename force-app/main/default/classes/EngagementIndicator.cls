public with sharing class EngagementIndicator {
    public static void updateEngagementIndicator(List<Task> taskList) {
        try {
            if(taskList.size()>0 && !taskList.isEmpty()){
                
                Set<id> leadIdSet = new Set<id>();
                for (Task t : taskList) {
                    if(t.WhoId.getSObjectType(). getDescribe(). getName() == 'Lead'){
                        leadIdSet.add(t.WhoId);
                    }
                    
                }
                //List<tdc_tsw__Message__c> tdcMessage = [SELECT Id, Name, CreatedDate, OwnerId, tdc_tsw__Lead__c FROM tdc_tsw__Message__c WHERE Name = 'Incoming' AND tdc_tsw__Lead__c IN: leadIdSet];
                List<Lead> leadList = [Select id, LeadSource from Lead where id In: leadIdSet];
                List<Lead> leadNewList = new List<Lead>();
                for(Lead ld : leadList){
                    // for(tdc_tsw__Message__c message : tdcMessage){
                        System.debug('In lead section:::>>>'+ ld.LeadSource);
                        if(ld.LeadSource == 'Web'){
                            Lead ldNew = new Lead();
                            ldNew.company = 'Test1';
                            ldNew.id = ld.id;
                            ldNew.Engagement_Indicator_auto__c = true;
                            leadNewList.add(ldNew);
                        }
                    // }
                    
                }

                Update leadNewList;


            }
            

        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR,'ERROR MESSAGE '+ex.getMessage()+' ERROR LINE NUMBER '+ ex.getLineNumber());
        }
    }
}