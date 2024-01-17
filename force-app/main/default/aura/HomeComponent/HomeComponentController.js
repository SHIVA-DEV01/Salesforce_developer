({
    doInit : function(component, event, helper) {        
        helper.getColumnAndAction(component);
        helper.getAccounts(component, helper);
    },
     
    handleNext : function(component, event, helper) { 
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getAccounts(component, helper);
    },
     
    handlePrev : function(component, event, helper) {        
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getAccounts(component, helper);
    },
 
    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        switch (action.name) {
            case 'edit':
                helper.editRecord(component, event);
                break;
            case 'delete':
                helper.deleteRecord(component, event);
                break;
            case 'view':
                helper.viewRecord(component, event);
                break;
        }
    },
    
    
    
    
    
     searchKeyChange: function(component, event) {
        var searchKey = component.find("searchKey").get("v.value");
        console.log('searchKey:::::'+searchKey);
        var action = component.get("c.findByName");
        action.setParams({
            "searchKey": searchKey
        });
        action.setCallback(this, function(a) {
            component.set("v.data", a.getReturnValue());
        });
        $A.enqueueAction(action);
    }  ,
    createNewRecord: function(component,event,helper){
        helper.displayRecordCreateForm(component,event);
    },
    closeCreateFormModal: function(component,event,helper){
        component.set("v.displayCreateModalForm",false);
    },
        handleSuccess : function(component, event, helper) {
        component.set("v.displayCreateModalForm",false);
        var recId = event.getParam("id");
        console.log(recId);
        if(recId != undefined){
             alert('record successfully inserted');
            
        }else{
            
 			alert('some error occured during record insertion'); 
        }
       
    },
    
    
    
    
    
})