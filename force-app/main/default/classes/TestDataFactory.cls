public class TestDataFactory {

    public static List<Contact> contactDataFactory(){
        List<Contact> conList = new List<Contact>();
        for(Integer i=0;i<10;i++){
            Contact con = new Contact();
            con.LastName = 'Aman'+i + 'a';
            con.Birthdate = date.today();
            con.Ge__c = 'Male';
            conList.add(con);
            
        }
        return conList;
    }

    public static List<Opportunity> opportunityDataFactory(){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i = 0; i<10; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'Test'+i;
            opp.StageName = 'Closed Won';
            opp.CloseDate = date.today();
            opp.Amount = 20000+i;
            oppList.add(opp);
        }
        return oppList;
    }
    
    public static List<Opportunity> opportunitySingleDataFactory(){
        List<Opportunity> oppList = new List<Opportunity>();
            Opportunity opp = new Opportunity();
            opp.Name = 'Test';
            opp.StageName = 'Closed Won';
            opp.CloseDate = date.parse('02/02/2022');
            opp.Amount = 20000;
            oppList.add(opp);
        	return oppList;
    }
    
    public static List<Account> accountDateFactory(Integer employeesNumber){
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name = 'TestData';
        acc.Rating = 'Hot';
        acc.NumberOfEmployees = employeesNumber;
        accList.add(acc);
        return accList;
    }
    
        public static List<Account> accountDataFactory(){
        List<Account> accList = new List<Account>();
            for(Integer i=0 ; i<10; i++){
        		Account acc = new Account();
        		acc.Name = 'TestData'+i;
        		acc.Rating = 'Hot';
                acc.Working_In__c = 'ASIA';
        		accList.add(acc);
            }
        return accList;
    }
    
    public static List<Opportunity> OpportunityTest(){
        List<Opportunity> oppList = [Select id, AccountId, Pricebook2Id from Opportunity where AccountId != null And Pricebook2Id != null Limit 1];
        return oppList;
    }
}