import { LightningElement,api, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountHelper.getAccounts';
import { CurrentPageReference } from 'lightning/navigation';

export default class AccountDatatable extends LightningElement {




    @track tableData;
    @track error
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Id', fieldName: 'Id' },
    ];

    @wire(getAccounts)
    accountRecord({ data, error }) {
        if (data) {
            let accdata = JSON.parse(JSON.stringify(data));
            console.log('In if > ',accdata);
            this.tableData = accdata;
            //  console.log('Data from Apex > '+this.tableData);
        }
        else if(error) {
            this.error=error;
        }
    }

    strInput;

    @wire(CurrentPageReference)
    currentPageReference;

    connectedCallback() {
       
        console.log( 'c__strInput Param value is ' + this.currentPageReference.state.accId );
        this.strInput = this.currentPageReference.state.accId;
   
    }



//     strInput;

//     @wire(CurrentPageReference)
//     currentPageReference;

//     connectedCallback() {
       
//         console.log( 'c__strInput Param value is ' + this.currentPageReference.state.c__strInput );
//         this.strInput = this.currentPageReference.state.c__strInput;
   
//     }

// }


}