import { LightningElement } from 'lwc';
import getFieldSet from '@salesforce/apex/DynamicForm.getFieldSet';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DynamicForm extends LightningElement {

    data = [];
    dataref = [];
    pickListData = [];
    connectedCallback(){
        console.log('In Connected Call Back');
        getFieldSet({})
            .then(result =>{
                if (result) {
                    let temp = [];
                    let temp1 = [];
                    let temp2 = [];
                    result.forEach(r => {
                        if(r.fieldApi == 'REFERENCE'){
                            temp.push({
                                label : r.label,
                                dataType : r.dataType,
                                fieldApi : r.fieldApi,
                                id : r.id
    
                            })
                        }
                        else if(r.fieldApi == 'PICKLIST'){
                            temp2.push({
                                label : r.label,
                                dataType : r.dataType,
                                fieldApi : r.fieldApi,
                                id : r.id,
                                // pickListValue : r.pickListValue
                            })
                            // console.log('FullData::::>>>',r);
                            // console.log('FullDataTemp::::>>>',temp2);
                        }
                        else if(r.label != undefined){
                            console.log('In else part');
                            temp1.push({
                                label : r.label,
                                dataType : r.dataType,
                                fieldApi : r.fieldApi,
                                id : r.id
                            })
                            // console.log('FullData::::>>>',r);
                        }
                        else if(r.label == undefined){
                            temp2.push({
                                pickListValue : r.pickListValue
                            })
                        }
                        
                        console.log('FullData::::>>>',r);
                        
                    });
                    this.data = temp;
                    this.dataref = temp1;
                    this.pickListData = temp2;
                    console.log('Results:::>>>>',this.data);
                    console.log('Results:::>>>>',this.dataref);
                    console.log('Results:::>>>>',this.pickListData.pickListValue);
                    
                }
                
                // this.data = result.dataType;
                // this.lable = result.Label;
                // console.log('Result of getFieldSet:::>>>>',result);
                // console.log('Result of data:::>>>>',this.data);
                // console.log('Result of lable:::>>>>',this.lable);

            })
            .catch(error => {
                console.log('error:::::>>',error);
            });

            


    }
    handleSuccess(){
        const evt = new ShowToastEvent({
            message: 'Your Opportunity Successfully created',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}