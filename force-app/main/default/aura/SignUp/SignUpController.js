({
    togglePassword : function(component, event, helper) {
        if(component.get("v.showpassword",true)){
            component.set("v.showpassword",false);
        }else{
            component.set("v.showpassword",true);
        }
        
       

        
        
        
    },
    
    
    
    
    handleClick : function (cmp, event, helper) {

 var a = cmp.get("v.username");
         var otp = cmp.get("v.OTP");
         var gen = cmp.get('v.Gen');

                var b = cmp.get("v.password");
        if(a==null && b==null && otp==null){
            alert("Please enter username & password");
        }
        else if(otp!=gen){
                        alert("Incorrect OTP");

        }
        
        
        else{
             

    var action=cmp.get("c.insertData");
    action.setParams({"username":a ,"password":b});
    action.setCallback(this,function(a){});
        console.log("SignUp Successfull"+a);
        alert("SignUp Successfull")

        
        
        $A.enqueueAction(action);
        }
        

    },
    
    
    

      sendDetails: function(component,event,helper) {
        console.log('In controller');
        
        helper.sendDetailsToApex(component);
    },
    
    
    
    
    
    
    
    
    
    
})