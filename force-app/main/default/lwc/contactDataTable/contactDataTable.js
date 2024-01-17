import { LightningElement, api, track} from 'lwc';

export default class ContactDataTable extends LightningElement {
    @api key;
    @api tablecolumns;
    @api title;
    @api tabledata;

    connectedCallback(){
        console.log('In contact Data Table component >>>> ', this.key);
    }

    get columns(){
        console.log('columns', this.tablecolumns, this.title);
        return this.tablecolumns;
    }

    get data(){
        console.log('this.tabledata', this.tabledata);
        return this.tabledata;
    }

    handleRowAction(event) {
        const actionName = event.target.value;

        const row = event.detail.row;
        console.log('event .....', actionName, '   ........ ..  ', row, this.template.querySelector("lightning-datatable"));
        if (event.detail.action.name === 'delete') {
            const selectedEvent = new CustomEvent('selected', { detail: 'delete' });
            // this.deleteSelectedRow(event.detail.row);
            this.dispatchEvent(selectedEvent);
        }

        

        // switch (actionName) {
        //     case 'google_search':
        //       if (row.Address__c !== null && row.Address__c !== undefined) {
        //         const mapUrl = 'https://www.google.com/search?q=' + row.Address__c;
        //         window.open(mapUrl, "_blank");
        //       }
        //       break;
        //     case 'google_maps':
        //       if (row.Address__c !== null && row.Address__c !== undefined) {
        //         const mapUrl = 'https://maps.google.com/?q=' + row.Address__c;
        //         window.open(mapUrl, "_blank");
        //       }
        //       break;
        //     case 'comp_reports':
        //       // console.log('--------Rentometer------');
        //       break;
        //     default:
        //   }
    }
}