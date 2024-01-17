({
        getColumnAndAction : function(component) {
            var ty = component.get('v.you');
            if(ty == true){
            var actions = [
                {label: 'Edit', name: 'edit'},
                {label: 'Delete', name: 'delete'},
                {label: 'View', name: 'view'}
            ];}
            else{
                var actions = [
                    {label: 'View', name: 'view'}
                ];
            }
            console.log(ty);
            component.set('v.columns', [
                {label: 'Name', fieldName: 'Name', type: 'text'},
                {label: 'AccountNumber', fieldName: 'AccountNumber', type: 'text'},
                {label: 'Industry', fieldName: 'Industry', type: 'text'},
                {label: 'Phone', fieldName: 'Phone', type: 'phone'},
                {type: 'action', typeAttributes: { rowActions: actions } } 
            ]);
        },
         
        getAccounts : function(component, helper) {
            var action = component.get("c.getAccounts");
            var pageSize = component.get("v.pageSize").toString();
            console.log("called");
            var pageNumber = component.get("v.pageNumber").toString();
            action.setParams({
                'pageSize' : pageSize,
                'pageNumber' : pageNumber
            });
            action.setCallback(this,function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var resultData = response.getReturnValue();
                    
                    console.log("ln31 "+resultData.Name);
                    
                    if(resultData.length < component.get("v.pageSize")){
                        component.set("v.isLastPage", true);
                    } else{
                        component.set("v.isLastPage", false);
                        component.set("v.data", resultData);
                    }
                    component.set("v.dataSize", resultData.length);
                    
            }
            });
            $A.enqueueAction(action);
        },
         
        viewRecord : function(component, event) {
            component.set("v.isView",true);
           var row = event.getParam('row');
            var recordId = row.Id;
            
            var data=component.get("v.data")
            data.forEach(element => {
                         
                if(element.Id==recordId){
                 
                component.set("v.Account",element);
                
            }
            });
        },
         
        deleteRecord : function(component, event) {
            //var action = event.getParam('action');
            var row = event.getParam('row');
            console.log("helper"+action);
            console.log("helper"+row.Id);
            var action = component.get("c.deleteAccount");
            action.setParams({
                'acc': row
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS" ) {
                    var rows = component.get('v.data');
                    var rowIndex = rows.indexOf(row);
                    rows.splice(rowIndex, 1);
                    component.set('v.data', rows);
                    /*var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "The record has been delete successfully."
                    });
                    toastEvent.fire();*/
    
                }
            });
            $A.enqueueAction(action);
        },
         
        editRecord : function(component, event) {
            component.set('v.isEdit',true);
            var row = event.getParam('row');
            var recordId = row.Id;
            var data=component.get("v.data")
            data.forEach(element => {
                         
                if(element.Id==recordId){
                 
                component.set("v.Account",element);
                console.log('Account name'+component.get("v.Account.Id"));
                
            }
            });
                },
      
    })