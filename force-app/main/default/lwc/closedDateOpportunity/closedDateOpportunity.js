import { LightningElement,track,api } from 'lwc';

import updateOpportunityCloseDate from '@salesforce/apex/displayobject.updateOpportunityCloseDate';

export default class ClosedDateOpportunity extends LightningElement {

    @api recordId;
    closeDate;
    @track open=false;
    openModel(){
        console.log('hii');
        this.open=true;
    }
    closeModel(){
        this.open=false;
    }
    oppdate(event){
        this.closeDate=event.target.value;
        console.log(this.closeDate);
    }
    updateDate(){
        console.log('in js');
        updateOpportunityCloseDate({optId:this.recordId , closedate:this.closeDate})
        .then(result=>{
            if(result==true){
                console.log('successfull');
            }
            this.open=false;
        });
    }


}