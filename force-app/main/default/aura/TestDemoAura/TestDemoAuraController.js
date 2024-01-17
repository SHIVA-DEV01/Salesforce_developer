({
    doInit: function (component, event, helper) {
        var url = window.location.href;
        var code = getParameterByName('code');
        component.set('v.columns', [
            {label: 'Event name', fieldName: 'Name', type: 'text', editable: true},
            {label: 'Start Date', fieldName: 'StartDate',type: 'dateTime'},
            {label: 'End Date', fieldName: 'EndDate',type: 'dateTime'}]);
        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            console.log('Name which is pass by function', name);
            name = name.replace(/[\[\]]/g, '\\$&');
            console.log('Log in function after by name>>>>>', name.replace(/[\[\]]/g, '\\$&'));
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            console.log('===results==', results);
            if (!results) return null;
            if (!results[2]) return '';
            console.log('results[2]>>>>>>', results[2]);
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }

        var code = getParameterByName('code');
        console.log('code>>>>>', code);
        if (code !== undefined && code !== '' && code !== null) {
            var action = component.get('c.getAccessToken');
            
            action.setParams({
                'code': code
            });
            action.setCallback(this, function (response) {
                var status = response.getState();
                if (status === "SUCCESS") {
                    var accessToken = response.getReturnValue();
                    component.set("v.accessToken", accessToken);
                    component.set("v.access", accessToken != null ? 'action:approval' : 'utility:error');
                    
                    if(accessToken != null){
                        alert("Successfully Authenticated");
                    }                        
                    
                    

                }
            });

            $A.enqueueAction(action);
        }
        

    },

    showMessage: function (component, event, helper) {
        alert('Message from Lightning Component');
    },
    doAuth: function (component, event, helper) {
        var action = component.get("c.createAuthURL");
        

        action.setCallback(this, function (response) {
            var status = response.getState();
            if (status === "SUCCESS") {
                var authUrl = response.getReturnValue();
                window.location.href = response.getReturnValue();
                //console.log('code>>>>>>>',ApexPages.currentPage.getParameters().get('code'));
                //console.log(window.location.href);
                //console.log('AuthUrl',authUrl);
                
                
            }
        });

        $A.enqueueAction(action);
        //console.log('code>>>>>>>',ApexPages.currentPage.getParameters().get('code'))
    },

    doreAuth: function (component, event, hepler) {
        var action = component.get("c.regenerateAccessToken");
        console.log('In doreAuth');

        action.setCallback(this, function (response) {
            var status = response.getState();
            if (status === "SUCCESS") {
                console.log('accessToken return value',response.getReturnValue());
                var accessToken = response.getReturnValue();
                component.set("v.accessToken", accessToken);
                component.set("v.access", accessToken != null ? 'action:approval' : 'utility:error');

            }
        })

        $A.enqueueAction(action);

    },


    doGet: function (component, event, hepler) {
        console.log('In Do GET function');
        var token = component.get("v.accessToken");
        var action = component.get('c.getMethodwe');

        action.setParams({
            'token': token
        });
        // console.log('Action',action);
        action.setCallback(this, function (response) {
            console.log('response>>>>>', response);
            var status = response.getState();
            if (status == "SUCCESS") {
                var result = response.getReturnValue();
                let obj = [];
                result.forEach(element => {
                    let array = {};
                    array.Name = element.summary;
                    array.StartDate = element.start.dateTime;
                    array.EndDate = element.end.dateTime;
                    

                    obj.push(array);
                    // columns.push(array);
                    console.log('summary element>>>>>', element.start.dateTime);
                    console.log('obj>>>>>', obj);
                });
                console.log('Get Method is complete>>>', obj);
                // component.set('v.EventList', obj);
                component.set('v.data', obj);
            }
        });
        $A.enqueueAction(action);

    },

    doPost: function (component, event, hepler) {
        console.log('In Do Post function');
        var token = component.get("v.accessToken");
        var eve = component.get("v.EventInput");
        var action = component.get('c.postMethod');
        action.setParams({
            'token': token,
            'eve': eve
        });
        action.setCallback(this, function (response) {
            console.log('response>>>>>', response);
            var status = response.getState();
            if (status == "SUCCESS") {
                console.log('In post method')
            }
        });
        $A.enqueueAction(action);
    },

    doPut: function (component, event, hepler) {
        alert('Work in progress');
    }


})