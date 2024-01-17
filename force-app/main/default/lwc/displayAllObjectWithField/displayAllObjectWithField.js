import { LightningElement,track } from 'lwc';
import fetchAccount from '@salesforce/apex/fetchAllobject.getAllSobject';
import fetchfields from '@salesforce/apex/fetchAllobject.getAllField';

export default class DisplayAllObjectWithField extends LightningElement {


    @track acc=[];
    @track con;
    message;
    msg;
    @track opp;
    connectedCallback(){
    fetchAccount()
    .then(result => {
        for(const key in result){
           
           this.acc.push({key:key,value:result[key]});
        }

    })
    }


    contactFetch(event){
        this.message = event.target.value;
        console.log("the message is "+this.message);
        fetchfields({objectName : this.message})

        .then(result => {
            console.log("the result is"+result);
        this.con =result ;
     
        })
        .catch(error =>{
        this.error = error;
        })





    
 
    }


}