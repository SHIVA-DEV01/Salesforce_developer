({
    ShowProfile : function(cmp, event, helper) {
        var action=cmp.get("c.ProfileRec");
        var UserName = cmp.get("v.userNameHeader");

        action.setParams({
            emailName : UserName
        });

        action.setCallback(this, function(a){
            
            cmp.set("v.GetData",a.getReturnValue());
        })
        cmp.set("v.ProfileDetail",true);
        $A.enqueueAction(action);
    },

    closeModel : function(cmp, Event, helper){
        cmp.set("v.ProfileDetail", false);
    },

    LogoutDetails : function(cmp, E, H){

        alert('are you sure you want to log out')
       
         var returnUrl='https://cloudanalogy-2f1-dev-ed.lightning.force.com/BBDEC/WebApplication.app'; 
         // paste your login page link here, where you want to come back
        window.location.href=returnUrl;
        

    }

})