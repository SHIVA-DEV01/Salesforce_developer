public with sharing class ErrorMessageInVfController {

    public Account acc{get;set;}

    public ErrorMessageInVfController(ApexPages.StandardController controller) {

        acc = new Account();

    }

 

    public void save(){

        if(acc.name == '' || acc.name == null){

       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Account name'));
       acc.name.adderror('Please enter Account name');
        
        }
        if(acc.phone == '' || acc.phone == null){

       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter Account phone'));
        }
    }

}