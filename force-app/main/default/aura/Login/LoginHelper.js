({
        sendDetailsToApex: function(component,event,helper) {
        var num1 = Math.floor(Math.random() * 10000);
        var num = num1.toString();
        var a = component.get("v.username");
        var sendVf = component.get("c.sendVf");
        sendVf.setParam("emailget",a);
        component.set("v.Gen",num);
        sendVf.setParam("v" , num);
        console.log('In helper');
        console.log(num)
        sendVf.setCallback(this, function(response){
        var state = response.getState();
        if(state == 'SUCCESS'){
        
        }
        });
        $A.enqueueAction(sendVf);  
        }
    })