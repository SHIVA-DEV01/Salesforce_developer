import LightningDatatable from 'lightning/datatable';
import imageTableControl from './anotherComponentTable.html';
export default class NewComponentTable extends LightningDatatable {


    static customType = {
        image: {
            template: imageTableControl
        }
    };


}