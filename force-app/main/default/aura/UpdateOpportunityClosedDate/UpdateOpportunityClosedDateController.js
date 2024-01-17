({
  updateOpportunity : function(component, event, helper) {
    var recId=component.get("v.recordId");
    console.log('In Controller'+recId);
    helper.updateCloseDate(component,event,recId);
    
},
openModel: function(component, event, helper) {
    // Set isModalOpen attribute to true
    component.set("v.isModalOpen", true);
 },

 closeModel: function(component, event, helper) {
    // Set isModalOpen attribute to false  
    component.set("v.isModalOpen", false);
 },
  });