import { LightningElement, wire } from 'lwc';
import  {registerListener}  from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
import getAccountdata from '@salesforce/apex/AccountPubSub.getAccountdata';
export default class AccountSubscriber extends LightningElement {

    AccountValue = [];
    accData = [];
@wire(CurrentPageReference) pageRef;

    connectedCallback()
    {
        registerListener('Account Pub',this.createAccountView,this)
    }

    createAccountView(data){
        console.log('Data in child>>>',data);
        
        this.AccountValue = data;
        console.log('Account Value:>>>>>',this.AccountValue);
        getAccountdata({acc : this.AccountValue})
        .then(result => {
            console.log('Apex result',result);
            this.accData = result;


        })
        .catch((error)=>{
            console.log('Show error in the Child Component or Subscriber end');
        })
    }

}