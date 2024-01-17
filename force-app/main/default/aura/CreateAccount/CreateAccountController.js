({
    CreateAccount : function(component, event, helper) {
        var action = component.get('c.createAcc');
        action.setParams({
            "acc": component.get('v.AccountList')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {

 
                alert(response.getReturnValue()+ 'Your account successfully created');
                 
            }
        });
        $A.enqueueAction(action);
    }
})