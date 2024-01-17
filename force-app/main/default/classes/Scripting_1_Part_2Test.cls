@isTest
public class Scripting_1_Part_2Test {
    @isTest
    public static void fibonacciSeries(){
        List<Integer> intList = Scripting_1_Part_2.fibonacciSeries();
        System.assert(intList.size()>0);
    }
    
    @isTest
    public static void reverseOrderTest(){
        String str = Scripting_2_Part_2.reverseOrder();
        System.assert(str.length()>0);
    }
    
    @isTest
    public static void diffBetweenDayTest(){
        Scripting_3_Part_2.diffBetweenDay();
    }

    @isTest(SeeAllData = True)
    public static void sameEmailTest(){
        List<Contact> conList = [Select Email from Contact];
        List<User> UseList = [Select Email from User where Profile.UserLicense.Name = 'Salesforce'];
        List<String> str = Scripting_4_Part_2.sameEmail();
        
        
    }
    
    @isTest
    public static void createAccountOppProTest(){
        List<AggregateResult> ArList = [SELECT COUNT(Id), Account.Name FROM Opportunity WHERE  StageName ='closed won' GROUP BY Account.Name HAVING COUNT(Id)>2];
        List<AggregateResult> AresultList = Scripting_5_Part_2.createAccountOppPro();
        System.assert(ArList.size()>=0);
    }
    
    @isTest
    public static void catchTest(){
        List<Account> ArList = [SELECT Name FROM Account];
        List<AggregateResult> AresultList = Scripting_5_Part_2.createAccountOppPro();
    }  
    
    @isTest
    public static void opportunity10Test(){
        
        Scripting_6_Part_2.opportunity10();
    }
    
    @isTest
    public static void leadVsProductTest(){
        List<Lead> leadList = Scripting_7_Part_2.leadVsProduct();
        //System.assert(!leadList.isEmpty());
        }
    
	@isTest
    public static void Lead20Test(){
        Scripting_8_Part_2.Lead20();
    }
    
}