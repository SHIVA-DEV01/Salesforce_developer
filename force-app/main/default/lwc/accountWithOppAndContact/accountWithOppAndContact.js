import { LightningElement,api,track } from 'lwc';
import fetchAccountInfo from '@salesforce/apex/DispalyAllAccount.fetchAccountInfo';
import fetchContact from '@salesforce/apex/DispalyAllAccount.fetchContact';
import fetchOpportunity from '@salesforce/apex/DispalyAllAccount.fetchOpportunity';
export default class AccountWithOppAndContact extends LightningElement {

    @track options;
    @track conOptions;

    @track oppOptions;
    constructor(){
        super();
        fetchAccountInfo()
        .then(result=>{
        this.options = result;
        })
    }



    selectionChangeHandler(event){
        fetchContact({accId:event.target.value})
        .then(result=>{console.log(result);
            this.conOptions = result;
            })
        fetchOpportunity({accId:event.target.value})
        .then(result=>{console.log(result);
            this.oppOptions = result;
            })

    }





}