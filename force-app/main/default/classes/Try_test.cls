public class Try_test {
    public static void main(){
        try{
            Account acc = new Account();
            acc.BillingCity = 'Shiva';
            Insert acc;
        }
        catch(DmlException e){
            System.debug(e.getMessage());
        }
        catch(Exception e){
            System.debug(e);
		}
	}
}