trigger Test_Help1 on Account (Before insert) {
   /* if(Trigger.isAfter && Trigger.isUpdate){
        Test_Class.createAccount(Trigger.New);
    } */
    if(Trigger.isBefore && Trigger.isInsert){
        Test_Class.salesRepresentative(Trigger.New);
    }
}