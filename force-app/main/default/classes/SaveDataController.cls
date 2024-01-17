public class SaveDataController {
    
    public String Name {get;set;}
    public String Age {get;set;}
    public String Phone {get;set;}
    public SaveDataController( ) {
    }
    
    
    public void save(){
        
        System.debug(Name);
        Account acc = new Account();
        acc.Name = Name;
        acc.Phone = Phone;
        Insert acc;
    }
}