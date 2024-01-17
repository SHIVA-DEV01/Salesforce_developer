({
    togglePassword : function(component, event, helper) 
    {
        if(component.get("v.showpassword",true)){
            component.set("v.showpassword",false);
        }else{
            component.set("v.showpassword",true);
        }
            
    },
    
    
    
    
    handleClick : function (cmp, event, helper) 
    {
        var action=cmp.get("c.sendVf");
        var Uname = cmp.get("v.Username");
        var otp = cmp.get("v.OTP");
        var pass = cmp.get("v.Password");
        var Gen = cmp.get("v.Gen");

        action.setParams({
            username : Uname,
            password : pass
        });
        

        if(Uname==null && pass==null && otp==null)
        {
            alert("Please enter username & password");
        }
        else if(otp!=Gen){
                        alert("Incorrect OTP");

        }
        
        
        else{
            action.setCallback(this, function(a){
                alert(a.getReturnValue());
                cmp.set("v.Logedin",false);
                cmp.set("v.showData",true);
                console.log("islogedin="+cmp.get("v.Logedin"));
                console.log('The field list is :'+JSON.stringify(a.getReturnValue()));
            });

            cmp.set("v.ShowHeader",'True');
            cmp.set("v.uname",'');
            cmp.set("v.pass",'');
            alert("Login Successfull");

            }   
            $A.enqueueAction(action);
            

        
        
        


    },
    
    
    
    
        handleUrlChange : function(component, event, helper) 
        {
        var imageUrl = component.get("v.image");
       
        var newMapAttributes = {"src": imageUrl};
        component.find("imgDiv").set("v.HTMLAttributes",newMapAttributes);
        },
    
    
    
        sendDetails: function(component,event,helper) {
        console.log('In controller');
        helper.sendDetailsToApex(component);
},
})