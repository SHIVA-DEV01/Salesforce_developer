import { LightningElement,api} from 'lwc';

export default class HelloWorld extends LightningElement {

    @api firstName = 'Shiva';
    @api strTitle = 'Welcome in SalesForce';
    @api showImage = false;
    @api imgUrl = '';
    @api widt;
    @api heig;
}