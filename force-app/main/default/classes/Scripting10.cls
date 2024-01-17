public class Scripting10 {
    public static List<Opportunity> getOpportunity()
        {
            
            List<OpportunityContactRole> oppList=[Select ContactId from OpportunityContactRole];
            System.debug(oppList);
            Set<Id> setofId=new Set<Id>();
            for(OpportunityContactRole itr: oppList)
            {
                setofId.add(itr.ContactId);
            }
                
            List<Contact> cList=[Select AccountId from Contact where Id IN:setofId];
            System.debug(cList);
            setofId.clear();
            for(Contact itr: cList)
            {
                setofId.add(itr.AccountId);
            }
            List<Opportunity> opList=[Select Name,AccountId from Opportunity where AccountId IN:setofId AND (StageName='Closed Won' OR StageName='Closed Lost') ];
            for(Opportunity opitr: opList)
            {
                System.debug(opitr.Name);
            }
                  
            return opList;
            
        }
}