({
    updateCloseDate : function(component,event,recId) {
        console.log('In helper');
        var closedate=component.get('v.CloseDate');
        //var recId=component.get('v.RecordId');
        var action=component.get('c.updateOpportunityCloseDate');
        action.setParams({'optId':recId,'closedate':closedate})
        console.log('RecordId:'+recId);
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                console.log('IN Set'+response.getReturnValue());
                if(response.getReturnValue()){
                    var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": "success",
            "mode": "dismisible",
            "title": "Success!",
            "message": "Close Date has been updated successfully."
        });
        toastEvent.fire();
        location.reload();    
                }
            }
        });
        $A.enqueueAction(action);
    }
})