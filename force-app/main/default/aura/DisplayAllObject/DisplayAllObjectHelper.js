({
    selectAllSobjects : function(component,event) {
        //console.log('IN');
        var action=component.get('c.getAllSobject');
        action.setCallback(this,function(response){
            console.log('IN Set');
            var state=response.getState();
            if(state==="SUCCESS"){
                //console.log('IN Set');
                component.set('v.SobjectList',response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

    },
    selectAllSobjectsFields:function(component,event){
        console.log('IN all field');
        var stype=component.find('sobjName').get('v.value');
        var action=component.get('c.getAllField');
        action.setParams({'sobjname':stype});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                //console.log('IN Set');
                component.set('v.FieldList',response.getReturnValue());
            }

        });
        $A.enqueueAction(action);
        

    },
    getFieldDetail:function(component,event){
        console.log('IN field');
        var action=component.get('c.getFieldType');
        var stype=component.find('sobjName').get('v.value');
        var field=component.find('sobjField').get('v.value');
        console.log(stype+':'+field);
        action.setParams({'sobjfield':field,'sobjName':stype});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                //console.log('IN Set');
                component.set('v.DataType',response.getReturnValue());
            }

        });
        $A.enqueueAction(action);

       
        
    }

})