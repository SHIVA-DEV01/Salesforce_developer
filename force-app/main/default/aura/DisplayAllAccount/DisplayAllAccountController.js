({
    myAction : function(component, event, helper) {
        helper.showAccount(component, event, helper);
    },
    changeAction : function(component, event, helper){
        helper.showContact(component, event, helper);
        helper.showOpportunity(component, event, helper);
    }
})