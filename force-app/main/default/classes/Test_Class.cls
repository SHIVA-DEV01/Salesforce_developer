public class Test_Class {
    public static void test_423(List<Contact> conList){
        if(conList.size()>0){
            List<Contact> conList1 = [Select id, LastName from Contact where LastName =:conList[0].LastName];
            List<Contact> conList2 = new List<Contact>();
            for(Contact con : conList){
                for(Contact con1 : conList1){
                    if(con.LastName == con1.LastName){
                        conList2.add(con1);
                        
                    }
                }
            }
            if(conList2.size()>0){
            delete conList2;
            }
        }
    }
    
    public static void createAccount(List<Account> accList){
        List<Contact> conList = [Select id, LastName from Contact where AccountId =: accList];
        List<Contact> conList1 = new List<Contact>();
        if(accList.size()>0){
        for(Account acc : accList){
            for(Contact con: conList){
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                conList1.add(con);
            }            
        }
            if(conList.size()>0){
            Update conList1;
            }
        }
    }
    
    public static void salesRepresentative(List<Account> accList){
        if(accList.size()>0){
            
            for(Account acc: accList){
                acc.Sales_Representative__c = acc.CreatedBy.Name;
                
            }
        }
    }
        /*public static void updateAccountName(List<Contact> conList){
        if(conlist.size()>0)
        {
        Account acc = [Select id,Name from Account where id =: conList];
        if()
        acc.Name = acc.Name + ' ' + conList[0].LastName;
        Update acc;
    }
    
            if(conList.size() != Null){
            Account acc = [Select id,Name from Account where id =: conList];
            acc.Name = acc.Name.remove(conList[0].LastName);
            Update acc;
        }
        }*/
}