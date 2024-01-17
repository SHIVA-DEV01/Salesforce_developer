import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import insertAccountMethod from '@salesforce/apex/lwcApexController.insertAccountMethod';
import getObject from '@salesforce/apex/EngagementGraphController.getObject';


export default class CreateNewAccount extends LightningElement {
    @track accountid;
    @track error;    
    @track getAccountRecord={
        Name:'',       
        Phone:'',  
        Type:'', 
        Website:'',         
        Site:''
              
    };   
 
   
    nameInpChange(event){
       this.getAccountRecord.Name = event.target.value;
       getObject({recId:'0015i00000QthyuAAB',filter:2022,ownerValue:'0055i000003idw7AAA',LastMonths:6})
       .then(result=>{console.log('results:::>>> ',result);})

     }
 
     phoneInpChange(event){
       this.getAccountRecord.Phone = event.target.value;

    }
    
     typeInpChange(event){
        this.getAccountRecord.Type = event.target.value;

      }
 
      websiteInpChange(event){
        this.getAccountRecord.Website = event.target.value;
      }
 
      accSiteChange(event){
        this.getAccountRecord.Site = event.target.value;
        //window.console.log(this.getAccountRecord.Type);
      }
          
    
      saveAccountAction(){
        this.showToast();
        window.console.log('before save' + this.createAccount);
        insertAccountMethod({accountObj:this.getAccountRecord})
        .then(result=>{this.getAccountRecord={};})

      }


      showToast(){
        const event = new ShowToastEvent({
            title: 'Toast message',
            message: 'Toast Message',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    
    
    }