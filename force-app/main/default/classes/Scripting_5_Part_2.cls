public class Scripting_5_Part_2 {
    public static List<AggregateResult> createAccountOppPro(){
        try{
        list<Account> acclist=new list<Account>();
        list<Opportunity> opplist=new list<Opportunity>();
        list<Product2> prolist=new list<Product2>();
        for(integer i=0;i<10;i++){
            Account acc=new Account(Name='Tom '+i);
            for(integer j=0;j<5;j++){
                Opportunity opp=new Opportunity(
                Name='opportunity'+j,
                StageName='Closed Won',
                CloseDate= Date.parse('02/23/2023'),
                AccountId=acc.id
                );
            opplist.add(opp);}
            	
         	acclist.add(acc);
                    }
        for(integer k=0;k<10;k++){
                    Product2 pro=new Product2(Name='Tom Product',
                                            Family='footwear');
                        prolist.add(pro);
            
        }
        insert acclist;
        insert opplist;
        insert prolist;
        list<AggregateResult> AggregateList=[SELECT COUNT(Id), Account.Name FROM Opportunity WHERE  StageName ='closed won' GROUP BY Account.Name HAVING COUNT(Id)>2];
        system.debug(AggregateList);
        return AggregateList;

        }
        catch(DmlException e){
            System.debug('DmlExcxeption hit');
        }
        catch(QueryException e){
            System.debug('QueryException hit');
        }
        catch(Exception e){
            System.debug('Exception hit');
        }
        return null;
    }
}