@isTest
public class TestClassScripting {
	@isTest
        public static void createTenAccount(){
        List<Account> accList = Scripting1.createAccount();
        System.assertEquals(accList.size(),20);
    }
    
    @isTest
    public static void CreateContactTest(){
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<10;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Rating = 'Hot';
            accList.add(acc);
        }
        
        Insert accList;
        List<Contact> conList = Scripting2.createContact();
        System.debug(conList);
        System.assertEquals(accList.size(), conList.size());
        
        
        
        
    }
    
    @isTest
    public static void createOpportunityTest(){
        List<Opportunity> oppList = Scripting3.createOpportunity();
        System.assert(oppList.size()>0);
    }
    
    @isTest
   	public static void createProductTest(){
    List<Product2> proList = Scripting4.createProduct();
    System.assert(proList.size()>0);
    }
    
    @isTest
    public static void deletingContactTest(){
    List<Contact> conList = Scripting5.deletingContact();
    System.assert(conList.size() == 0);
    }
    
    @isTest
    public static void updateOpportunityTest(){
            Opportunity opp = new Opportunity();
            opp.CloseDate = date.parse('08/04/2022');
            opp.Name = 'TestOpportunity';
        	opp.StageName = 'Closed Won';
        	Insert opp;
    List<Opportunity> oppUpdateList = Scripting6.updateOpportunity();
    System.assert(!oppUpdateList.isempty());
    }
    
    @isTest
    public static void displayUserTest(){
        List<User> userList = [Select Id,Name,MobilePhone,Email,Profile.UserLicense.Name from User where Profile.UserLicense.Name = 'Salesforce'];
        List<User> userStr = Scripting7.displayUser();
        System.assertEquals(userStr.size(), userList.size());
    }
    
    @isTest
    public static void accendingOrderList(){
                list<Account> accList=new list<Account>();
        for(integer i=0; i<5; i++){
            Account acc = new Account();
            acc.Name='testClass'+i;
            accList.add(acc);
        }
        insert accList;
        List<Account> accList1 = Scripting8.accendingOrder();
        integer i=0;
        accList.sort();
        for(Account acc : accList1){
            
            system.assert(acc.Name==accList[i].Name);
            i++;
        }

    }

    @isTest
    public static void reverseOrderTest(){
        List<Account> accList = new List<Account>();
        for(Integer i=0 ; i<20; i++){
            Account acc = new Account();
            acc.Name='testClass'+i;
            accList.add(acc);
        }
        insert accList;
        List<string> str = Scripting9.reverseOrder();
        System.assert(str.size()>0);
        }
    
    @isTest public static void getOpportunityTest(){
        Account acc = new Account(Name='cccount');
        insert acc;
        Contact con = new Contact(Lastname='Contact',AccountID=acc.Id);
        insert con;
        Opportunity op=new Opportunity(Name='OpptTest', AccountId=acc.Id,StageName='Closed Won',CloseDate=System.today());
        insert op;
        OpportunityContactRole opcr=new OpportunityContactRole(OpportunityId=op.Id,ContactId=con.Id);
        insert opcr;
     	List<Opportunity> oplist=Scripting10.getOpportunity();
        
        
    }
}