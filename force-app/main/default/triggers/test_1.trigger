trigger test_1 on Account (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        //System.debug(Trigger.New[0]);
        Test_apex_class.test_apex(Trigger.New[0]);
      //  for(Account acc: Trigger.New){
       //     System.debug(acc);
       // }
    }
}