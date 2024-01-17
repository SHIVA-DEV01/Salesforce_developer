public class BrainStorming2
{
    public static void BrainStorming2_test(List<Policy__c> polList){
        try{
        if(polList.size()>0){
  		List<Opportunity> oppList = [Select id, Name, Policy_Number__c from Opportunity where Policy_Number__c =:polList[0].Policy_Number__c];
        List<Opportunity> oppList1 = new List<Opportunity>();
        List<Policy__c> polList1 = new List<Policy__c>();
        for(Policy__c pol : polList){
            for(Opportunity opp: oppList){
                opp.StageName = 'Closed Won';
                opp.Id = pol.Opportunity__c;
                if(pol.Policy__c != Null){
                    Policy__c pol1 = new Policy__c();
                    pol1.Id = pol.Policy__c;
                    pol1.Renew_Policy__c = True;
                    polList1.add(pol1);
                    System.debug(pol.Policy__c);
                }
                oppList1.add(opp);
            	}
        	}
          update polList1;
          update oppList1;  
       }
    	}
        catch(DmlException e){
            System.debug(e.getMessage());
        }
        catch(Exception e){
            System.debug(e);
		}
    }
}