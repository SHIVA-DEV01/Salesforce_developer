import { LightningElement , api} from 'lwc';

export default class OpportunityTable extends LightningElement {
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
}