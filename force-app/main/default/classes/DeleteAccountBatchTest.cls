@isTest
public class DeleteAccountBatchTest {
	@isTest
    public static void deleteAccountTest(){
        //List<Account> accList = TestDataFactory.accountDataFactory();
        //Insert accList;
        DeleteAccountBatch dAB = new DeleteAccountBatch();
        database.executeBatch(dAB);
        //System.assert(accList.size() == 0);
    }
}