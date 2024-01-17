public class Soql_6 {
    public static List<Opportunity> amountGreatThan20000(){
        List<Opportunity> oppList = [Select id , Name, Amount from opportunity where StageName = 'Closed Won' AND Amount > 20000];
        System.debug('Opportunity'+oppList);
        return oppList;
    }
}