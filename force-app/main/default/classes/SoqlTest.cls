@isTest
public class SoqlTest {

    @isTest
    public static void contactNameTest(){
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0;i<5;i++){
            Contact con = new Contact();
            con.LastName = 'Aman'+i;
            contactList.add(con);
        }
        test.startTest();
        Insert contactList;
        List<Contact> conList = Soql_1.contactName();
        test.stopTest();

        System.assert(!conList.isEmpty());
        
    }
    
    @isTest
    public static void fatchAllContactTest(){
        List<Contact> conList = TestDataFactory.contactDataFactory();
        test.startTest();
        Insert conList;
        List<Contact> con = Soql_2.fatchAllContact();
        test.stopTest();
        
        System.assert(con.size()>0);
    }
    
        @isTest
    public static void fatchAllContactLikeATest(){
        List<Contact> conList = TestDataFactory.contactDataFactory();
        test.startTest();
        Insert conList;
        List<Contact> con = Soql_3.fatchAllContact();
        test.stopTest();
        System.assert(!con.isEmpty());
        System.assertEquals(con[0].Name, 'Aman0a');
    }
    
        @isTest
    public static void whoseBirthTodayTest(){
        List<Contact> conList = TestDataFactory.contactDataFactory();
		test.startTest();
        Insert conList;
        List<Contact> con = Soql_4.whoseBirthToday();
        test.stopTest();
        System.assert(!con.isEmpty());
        System.assertEquals(con[0].Name, 'Aman0a');
    }
    
        @isTest
    public static void allOppSumAvgTest(){
        List<Opportunity> oppList = TestDataFactory.opportunityDataFactory();
		test.startTest();
        Insert oppList;
        Soql_5.allOppSumAvg();
        test.stopTest();
    }
    
        @isTest
    	public static void amountGreatThan20000Test(){
        List<Opportunity> oppList = TestDataFactory.opportunityDataFactory();
		test.startTest();
        Insert oppList;
        List<Opportunity> opp = Soql_6.amountGreatThan20000();
        test.stopTest();
        System.assert(!opp.isEmpty());
    }
    
            @isTest
    public static void phoneNoNotMentionTest(){
        List<Contact> conList = TestDataFactory.contactDataFactory();
		test.startTest();
        Insert conList;
        List<Contact> con = Soql_7.phoneNoNotMention();
        test.stopTest();
        system.assert(!con.isEmpty());
    }
            @isTest
    public static void findNotMoreTest(){
        List<Contact> conList = TestDataFactory.contactDataFactory();
		test.startTest();
        Insert conList;
        List<Contact> con = Soql_8.findNotMore();
        test.stopTest();
        System.assert(!con.isEmpty());
    }
            @isTest
    public static void nameAllContactTest(){
        List<Contact> conList = TestDataFactory.contactDataFactory();
		test.startTest();
        Insert conList;
        List<Contact> con = Soql_9.nameAllContact();
        test.stopTest();
        System.assert(!con.isEmpty());
        
    }


}