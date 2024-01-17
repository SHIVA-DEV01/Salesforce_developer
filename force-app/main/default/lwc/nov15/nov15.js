import { LightningElement } from 'lwc';
import getObject from '@salesforce/apex/EngagementGraphController.getObject';

export default class Nov15 extends LightningElement {
        value = 'inProgress';

    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress bhvrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrberhbvhirivjirnervncinernciurehncueri iruencueri ceruincreu iurehnc rueijnc9urein creuinc9reionc ', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}