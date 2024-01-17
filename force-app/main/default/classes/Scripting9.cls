public class Scripting9 {
    public static List<String> reverseOrder(){
        List<Account> accList = [Select Name from Account];
		List<String> tempList = new List<String>();
		string str ;
		for (Account i: accList){
		str = i.Name;
    		tempList.add(str.reverse());
		}
		for (string j:tempList){
   			system.debug('Reverse order ---->  '+j); 
		}
        return tempList;

    }
}