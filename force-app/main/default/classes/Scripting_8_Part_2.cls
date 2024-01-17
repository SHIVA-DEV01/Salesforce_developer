public class Scripting_8_Part_2 {
    public static void Lead20() {
        try{
        //Create a Script to find out all the users in the systems who are having more than 20 Leads allocated[Owner] to them in month of feb 2019
        List<sobject> useList = [Select CreatedBy.Name from Lead Where Calendar_Month(CreatedDate)=7 Group by CreatedBy.Name having count(id)>20];
        System.debug(useList);
        }
        catch(DmlException e){
            System.debug('Dml Exception '+e);
        }
        catch(QueryException e){
            System.debug('QueryException '+e);
        }
        catch(Exception e){
            System.debug('Exception ' + e);
        }
    }
}