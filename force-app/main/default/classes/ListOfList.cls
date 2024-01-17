public class ListOfList {
    public static void test(){
        	List<Account> sOj = [Select id, Name,(Select id, Name from Contacts) from Account];
        system.debug(sOj);
					/*for(Account a : sOj){
    					for(Contact c: sOj.Contacts){
       					 system.debug(c);
    				}
				}
			System.debug(sOj);*/
    }
}