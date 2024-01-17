public class displaysObject {
    
    public string selectedname{get; set;}
    Public List<Selectoption> getselectedfields(){
            List<Selectoption> lstname = new List<selectoption>();
            for(Account acc :[SELECT id,name FROM Account]){
            lstname.add(new selectoption(acc.id,acc.name));
            }
        
            return lstname; 
        }
    
    
    public void ShowTable()  
    {  
        
       accList=new List<Account>([SELECT id,name,NumberOfEmployees,AnnualRevenue,Industry FROM Account WHERE id=:selectedname limit 100]);
                     conList=new List<Contact>([SELECT id,name,Email,MobilePhone,FirstName FROM Contact WHERE Accountid=:selectedname limit 100]);
                     oppList=new List<Opportunity>([SELECT id,name,Amount,CloseDate,StageName FROM Opportunity WHERE Accountid=:selectedname limit 100]);

    } 
    
    public List<Account> accList{get; set;}
    public List<Contact> conList{get; set;}
    public list<Opportunity> oppList{get ; set;}
   
}