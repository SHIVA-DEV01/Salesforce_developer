import { LightningElement, api, wire, track } from 'lwc';
import getstoreId from '@salesforce/apex/B2B_Grame_Product_Handler.getstoreId';

export default class B2B_Game_Product_Show extends LightningElement {
    products;
    connectedCallback(){
        console.log('In connected call back >>>>>> ');

        getstoreId({})
        .then(result => {
            console.log('result >>>>>>>> ', result);
            this.products = result.product;
        })
        .catch(error => {
            console.log('Error >>> ', error);
        })
    }
    
}