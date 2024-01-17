import { LightningElement, track } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import styles from '@salesforce/resourceUrl/styles';

export default class CreditCardPage extends LightningElement {
    connectedCallback() {
        loadStyle(this, styles);
      }
}