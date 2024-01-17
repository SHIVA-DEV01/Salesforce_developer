@isTest
public class LeadBatchClassTest {

    @isTest
    public static void updateLead(){
        lead ld = new Lead();
        ld.LastName = 'New Lead';
        ld.Company = 'Google';
        ld.Status = 'open - Not Contacted';
        ld.LeadSource = 'web';
        Test.startTest();
        Insert ld;
        LeadBatchClass lBC = new LeadBatchClass();
        database.executeBatch(lBC);
        Test.stopTest();
        List<Lead> ldList = [Select Rating from Lead where id =: ld.Id];
        system.assertEquals('Warm', ldList[0].Rating);
        
    }
    
}