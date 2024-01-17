import { LightningElement, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

export default class CustomCheckoutMethod extends LightningElement {
    // Get the record Id from the page URL using NavigationMixin
    connectedCallback() {
        const pageReference = this.getPageReference();
        if (pageReference && pageReference.attributes) {
            this.recordId = pageReference.attributes.recordId;
        }
        console.log("In side connected call back ::::: ");
    }
}