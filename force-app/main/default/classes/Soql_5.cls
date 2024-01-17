public class Soql_5 {
    public static void allOppSumAvg(){
        
        System.debug('Sum , Avg ---->'+[Select Sum(Amount),Avg(Amount) from Opportunity Where StageName = 'Close Won']);
    }
}