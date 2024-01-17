({
  //  Action : function(component, event, helper) {
   //     var f = component.get('v.gg');
     //  component.set('v.gg1',f);
    //}

    invoke : function(Component, event, helper){
        var action = Component.get("c.show");
        action.setcallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                component.set("v.accData",result);
            }
        });

        $A.enqueueAction(action);
    }
})