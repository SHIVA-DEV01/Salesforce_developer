public class Scripting_6_Part_2 {
    public static void opportunity10() {
        
        List<AggregateResult> oppList = [Select Account.Name,count(id) from Opportunity where Account.Name != Null And StageName ='Closed Won' And CloseDate<NEXT_MONTH And CloseDate>=today Group By Account.Name HAVING count(id)>10];

        System.debug(oppList); 

    }
}