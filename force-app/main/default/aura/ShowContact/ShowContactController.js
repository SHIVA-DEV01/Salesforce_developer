({
    doInit : function(component, event, helper) {
        component.set('v.columns',[
            
            {label: 'First Name', fieldName: 'FirstName', type: 'text'},
            {label: 'Last Name', fieldName: 'LastName', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'}
            
        ]);
        var action=component.get("c.show");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                
                var result=response.getReturnValue();
                component.set("v.data",result);
            }
        });
        $A.enqueueAction(action);
    },
})