public class Scripting8 {
    public static List<Account> accendingOrder(){
        List<Account> accList = [Select Name from Account order by Name asc Limit 10];
        for(Account i : accList){
            System.debug(i);
        }
        return accList;
        
    }
}