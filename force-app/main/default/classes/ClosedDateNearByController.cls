public class ClosedDateNearByController{
    public Opportunity opp{get;set;}
    public ClosedDateNearByController(ApexPages.StandardController controller){
        opp = new Opportunity();
    }
    
    public void save(){
        insert opp;
        if(opp.CloseDate >= date.today() && opp.CloseDate <= (date.today()+5) ){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Opportunity closed date is near by '+opp.CloseDate));
        }
    }
}