public class displayobject {
    @AuraEnabled
    public static Boolean updateOpportunityCloseDate(Id optId,Date closedate){
        try {
            System.debug('Id:'+optId);
            System.debug('Date:'+closedate);
            Opportunity op=[Select closedate from Opportunity where Id=:optId];
            op.closedate=closedate;
            if(op!=NULL){
                
            update op;
            System.debug(op);
            return true;
            }
            else{
                return false;
            }
            }
         catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}