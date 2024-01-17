public class JavaScript_DemoV1Ctrl {
     public List<Account> getIDs;
     public string accIds{get;set;}    
     public JavaScript_DemoV1Ctrl(ApexPages.StandardSetController controller){
         System.debug('Get Selected>>>>');
         getIDs = controller.getSelected();
         accIds = '';  
         for(Account acc : getIDs){
            accIds += acc.Id + ','; 
             System.debug('Account ID : '+accIds);
         }
         accIds = accIds.removeEnd(','); 
        System.debug('Account id without ,>>>>>>'+accIds);
         PageReference pg = new PageReference( '/lightning/n/accountDatatable?accId='+accIds);
         pg.setRedirect( true );
         // pg.getParameters().put('c__strInput', 'testing');
         // System.debug('parameter:::::::::>>>'+pg);
        
     } 

        

   // public PageReference openLightningComponent() {
        
     //   PageReference pg = new PageReference( 'lightning/o/Account/list' );
     //   pg.setRedirect( true );
      //  pg.getParameters().put( 'c__strInput', 'testing' );
      //  return pg;
        
    //}
}