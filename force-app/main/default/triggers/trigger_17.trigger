trigger trigger_17 on Contact (before update, after update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        Trigger.New[0].Title = 'Test2';
       
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
        Contact con = new Contact();
        con.id = (Trigger.New[0]).Id;
        con.Title = 'Test1';
        update con;
    }
}