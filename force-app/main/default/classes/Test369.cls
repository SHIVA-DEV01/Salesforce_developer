public class Test369 {
    public static void test_369(){
        Map<id,Account> accMap = new Map<id,Account>();
		List<Account> accList = [Select id, Name from Account];
		set<id> accSet = new set<id>();
        for(Account acc: accList){
            accSet.add(acc.Id);
            
        }
        for(id acc1 : accSet){
            for(Account acc: accList){
                if(acc1 == acc.Id){
                    accMap.put(acc1,acc);
                }
            }
        }
        
        for(id idMap: accMap.keySet()){

        }
        for(id idSet: accSet){
            System.debug(accMap.get(idset));
        }
        
        System.debug(accMap);
		System.debug(accList);
		System.debug(accSet);
    }
}