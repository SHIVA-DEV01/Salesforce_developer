import { LightningElement,wire } from 'lwc';
import getAccountData from '@salesforce/apex/TestWireController.testWireMethod';

export default class TestWire extends LightningElement {
    accountData;

    // Pass the account Id to the Apex method using the wire decorator
    @wire(getAccountData)
    wiredAccountData({ error, data }) {
      if (data) {
        // Retrieve the account data from the wire result
        this.accountData = data;
        console.log('Data >>>>>>>>> ', data);
      } else if (error) {
        // Handle any errors
        console.log(error);
      }
    }
}