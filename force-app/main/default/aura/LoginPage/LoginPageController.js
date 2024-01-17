({
    userLogin : function(component, event, helper) {
        
        var email = component.get("v.Username");
        var upass = component.get("v.Password");
        var action = component.get("c.getDetails");
        var act = component.get("c.PermissionSet");

        act.setCallback(this, function(a){
            console.log(email);
            
            if(email == a.getReturnValue()){
                console.log( a.getReturnValue());
                component.set('v.you',true);
                
            }
            else{
                component.set('v.you',false);
            }
            helper.getColumnAndAction(component);
            helper.getAccounts(component, helper);
            
            

        })

        
        
        action.setParams({
            uname : email,
            password :upass
        });
        
        action.setCallback(this, function(a){
            alert(a.getReturnValue());
            if(a.getReturnValue()=='success'){
                
                component.set('v.hide',true);
            }
            console.log('The field list is :'+JSON.stringify(a.getReturnValue()));
        });
        component.set("v.uname",'');
        component.set("v.pass",'');
        $A.enqueueAction(action);
        $A.enqueueAction(act);

    },



    doInit : function(component, event, helper) {  
        console.log('hiii') ;     
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
    } ,
     openModel: function(component, event, helper) {
      // Set isModalOpen attribute to true
      component.set("v.isModalOpen", true);
   },
    openProfile:function(component){
        component.set("v.profile",true);
    },
  
   closeModel: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.isModalOpen", false);
   },
    closeProfile: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.profile",false);
   },
  
   submitDetails: function(component, event, helper) {
      
      var action=component.get("c.insertAccount");
       console.log("in submit");
       
       action.setParams({'acc':component.get("v.Accounts")});
       console.log(component.get("v.Accounts.Name"));
                         action.setCallback(this,function(a){
                         helper.getAccounts(Component,helper);
                        });
       component.set('v.isModalOpen', false);
             $A.enqueueAction(action);
   },
    getProfile : function(cmp){
        cmp.set("v.profile",true);
        var action=cmp.get("c.getProfileDetails");
        console.log("wsjbd"+cmp.get("v.email"));
        action.setParams({"email":cmp.get("v.email")});
        action.setCallback(this,function(a){
            console.log("returned value"+a.getReturnValue().Name);
                           cmp.set("v.User",a.getReturnValue());
            
                           });
                            $A.enqueueAction(action);
    },
    EditProfile : function(cmp){
        cmp.set("v.isEditProfile",true);
    },
    submitEditProfile: function(component, event, helper) {
      
      var action=component.get("c.EditProfile1");
       console.log("in editor");
   
       action.setParams({'Id':component.get("v.User.Id"),
                         'Name':component.get("v.User.Name"),});
      action.setCallback(this,function(a){
                         
      });  
       component.set("v.isEditProfile",false);
        console.log("close"+component.get("v.isEditProfile"));
             $A.enqueueAction(action); 
     },
    closeEditProfile : function(component, event, helper) {
      component.set("v.isEditProfile",false);
   },
    closeViewAccount : function(component, event, helper) {
      component.set("v.isView",false);
   },
     closeEditAccount : function(component, event, helper) {
      component.set("v.isEdit",false);
   },
    
    
    submitEditDetails:function(component, event, helper) {
      
      var action=component.get("c.EditAccountDetail");
       console.log("in edit account");
       
       action.setParams({'Acc':component.get("v.Account")});
       console.log(component.get("v.Account.Name"));
                         action.setCallback(this,function(a){
                        });
       component.set('v.isEdit', false);
             $A.enqueueAction(action);
        helper.getAccounts(component, helper);
        
   },
   
      


})