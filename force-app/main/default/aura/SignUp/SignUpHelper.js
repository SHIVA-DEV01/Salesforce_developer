({
    sendDetailsToApex: function(component,event,helper) {
    var num1 = Math.floor(Math.random() * 10000);
    var num = num1.toString();
    var a = component.get("v.username");
    console.log(typeof num);
    console.log(num);
    var sendVf1 = component.get("c.sendVf");
    sendVf1.setParam("emailget",a);
    component.set("v.Gen",num);
    sendVf1.setParam("v" , num);
    console.log('In helper');
    sendVf1.setCallback(this, function(response){
    var state = response.getState();
    if(state == 'SUCCESS'){
       
    }
    });
    $A.enqueueAction(sendVf1);  
    }
    })