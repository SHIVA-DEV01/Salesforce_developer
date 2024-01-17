public class Scripting6 {
    public static List<Opportunity> updateOpportunity(){
        List<Opportunity> oppList = [Select Id,Name from Opportunity Where CloseDate >=: System.today() Limit 1];
        List<Opportunity> updateList = new List<Opportunity>();
        for(Opportunity i : oppList){
            i.Name = i.Name+'update'; 
            updateList.add(i);
        }
        update updateList;
		
		return updateList;        
        
    }
}