public class Scripting3 {
    public static List<Opportunity> createOpportunity(){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0;i<20;i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TCL'+i;
            opp.CloseDate = date.parse('03/05/2022');
            opp.StageName = 'Close Won';
            oppList.add(opp);
        }
        insert oppList;
        return oppList;
    }
}