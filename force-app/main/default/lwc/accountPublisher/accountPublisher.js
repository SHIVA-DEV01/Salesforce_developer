import { LightningElement, wire } from 'lwc';
import getAccountInfo from '@salesforce/apex/AccountPubSub.getAccountInfo';
import {fireEvent}  from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class AccountPublisher extends LightningElement {


    viewAccounts;

    @wire(getAccountInfo)
    accountData({error,data})
    {
        if(data)
        {
            console.log('Account data',data);
            this.viewAccounts=data;

        }
        else if(error)
        {
            console.log('Account error in Account Publisher');
        }
    }


    @wire(CurrentPageReference) pageRef;

    handleChange(event){
        console.log('event id:',event.currentTarget.dataset.id);
        let accountIds = event.currentTarget.dataset.id;
        fireEvent(this.pageRef,'Account Pub',accountIds);
    }


}