public class TestYourself {
    public static void contactDeadThenAccountBlock(){
        Integer a;
        Integer b;
        Integer percentage;
        Map<id,List<Contact>> accMap = new Map<id,List<Contact>>();
        Set<id> accSet = new Set<id>();
        List<Account> accList = [Select id,(Select AccountId,id,Dead__c from Contacts) from Account];
        List<Account> accList1 = new List<Account>();
        List<AggregateResult> aggreResultFalseValue = [Select AccountId, count(id) from Contact where Dead__c = false Group by AccountId];
        List<AggregateResult> aggreResultTrueValue = [Select AccountId, count(id) from Contact where Dead__c = True Group by AccountId];
        Map<String,Integer> FalseValueAggregMap = new Map<String,Integer>();
        Map<String,Integer> TrueValueAggregMap = new Map<String,Integer>();
                for(Account acc : accList){
                if(acc.Contacts.size() != 0){
                    accSet.add(acc.id);
                    
                }
        }
        for(AggregateResult fV : aggreResultFalseValue){
            if(fV.get('AccountId') != Null){
                String str;
                str = String.valueOf(fV.get('AccountId'));
                a = Integer.valueOf(fV.get('expr0'));
                
            FalseValueAggregMap.put(str,a);
            }   
        }
        if(aggreResultTrueValue.size() != 0){
        for(AggregateResult tV : aggreResultTrueValue){
            if(tV.get('AccountId') != Null){
                String str;
                str = String.valueOf(tV.get('AccountId'));
                a = Integer.valueOf(tV.get('expr0'));
                
            TrueValueAggregMap.put(str,a);
            }   
        }
        }
        
        

        for(id acc: accSet){
            if(TrueValueAggregMap.get(acc) == Null){
                a = 0;
            }
            if(FalseValueAggregMap.get(acc) != Null && TrueValueAggregMap.get(acc) != Null){
            b = FalseValueAggregMap.get(acc) + TrueValueAggregMap.get(acc);
                        }
            else if(FalseValueAggregMap.get(acc) != Null){
                    b = FalseValueAggregMap.get(acc) + a;
                	
                }
            if(TrueValueAggregMap.get(acc) != Null){
            percentage = (TrueValueAggregMap.get(acc)*100)/b;
            
            System.debug(percentage);
            
            if(percentage >= 75){
                Account acc2 = new Account();
                acc2.Id = acc;
                acc2.Block__c = True;
                accList1.add(acc2);
            }
            else{
                Account acc2 = new Account();
                acc2.Id = acc;
                acc2.Block__c = False;
                accList1.add(acc2);
            }
            }
                
            }
        Update accList1;
    }

}