trigger Trigger_1 on Account (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        Trigger_handler.employeeIsEqualContact(Trigger.new);
        Trigger_handler.employeesGreaterThan100(Trigger.New);
    }
}