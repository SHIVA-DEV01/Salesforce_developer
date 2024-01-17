trigger Test_Help on Contact (Before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        Test_Class.test_423(Trigger.New);
    }
}