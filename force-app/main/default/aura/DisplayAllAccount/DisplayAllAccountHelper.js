({
    showAccount : function(component, event, helper) {
        var action = component.get('c.fetchAccountInfo');

        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.accOption', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    
    showContact : function(component, event, helper) {
        var ConAccID = component.get("v.selectedAccount");

        var action = component.get("c.fetchContact");
        action.setParams({
            "accId": ConAccID
        });
        action.setCallback(this, function(actionResult) {
            component.set('v.conOption', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    },

    showOpportunity : function(component, event, helper) {
        var OppAccID = component.get("v.selectedAccount");

        var action = component.get("c.fetchOpportunity");
        action.setParams({
            "accId": OppAccID
        });
        action.setCallback(this, function(actionResult) {
            component.set('v.oppOption', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})