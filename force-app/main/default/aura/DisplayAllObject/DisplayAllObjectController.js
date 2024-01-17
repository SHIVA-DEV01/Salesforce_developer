({
    fillSobjectList : function(component, event, helper) {
        //console.log('IN');
        helper.selectAllSobjects(component,event);

    },
    fillSobjectFieldList:function(component,event,helper){
        console.log('IN flist');
        helper.selectAllSobjectsFields(component,event);
    },
    showFieldDetails:function(component,event,helper){
        console.log('In show');
        helper.getFieldDetail(component,event);
    }
})