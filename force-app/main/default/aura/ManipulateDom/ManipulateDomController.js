({
	handleClick : function(component, event, helper) {
		try{
            //var buttonElement = document.querySelector('[name="myButton"]');
       // var buttonElements = document.getElementsByName("Opportunity.BBDEC__Change_Close_Date");
       //buttonElements.style.Color = 'lightblue';
               var buttonElements = document.getElementsByTagName("myButton");
            buttonElements.style.backgroundColor = 'red';
            console.log('BUTTONELEMENTS >>>>> '+ buttonElements.innerHTML);
        
        
        //$A.util.addClass(buttonElements, 'changeMe');
        }catch(error){
            console.log('ERROR >>> '+ error);
        }
	}
})