import { LightningElement,api,track,wire } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import createOpportunity from '@salesforce/apex/OpportunityForm.createOpportunity';
import nameLabel from '@salesforce/label/c.ForEmptyFields';
import dateLabel from '@salesforce/label/c.Date';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const regex = /^[a-zA-Z\s]+(?:[-:%/\\()\u2122.+][a-zA-Z0-9\s]+)*$/;

export default class OpportunityForm extends LightningElement {

    @api objectName = 'Opportunity';
    @api fieldName = 'StageName';
    @track fieldLabel;
    @api recordTypeId;
    @api value;
    @track options;
    apiFieldName;
    data = {};
    value;

    @api val1 = {};
   // @api val2 ={};
    
    isShowModal = false;
    isShowModal2 = false;
    isShowModal3 = false;

    display1 = true;
    display2 = false;
    display3 = false;
    @api oppId;

    nameVali;

    bool1 = false;
    bool2 = false;
    bool3 = false;

    @api name;
    @api close_Date;
    @api stage_Name;
    @api accountId;

    
    displaybutton = false;
    

    @wire(getObjectInfo, { objectApiName: '$objectName' })
    getObjectData({ error, data }) {
        if (data) {
            if (this.recordTypeId == null)
                this.recordTypeId = data.defaultRecordTypeId;
            this.apiFieldName = this.objectName + '.' + this.fieldName;
            this.fieldLabel = data.fields[this.fieldName].label;
            
        } else if (error) {
            // Handle error
            console.log('==============Error  ');
            console.log(error);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: '$apiFieldName' })
    getPicklistValues({ error, data }) {
        if (data) {
            // Map picklist values
            this.options = data.values.map(plValue => {
                return {
                    label: plValue.label,
                    value: plValue.value
                };
            });

        } else if (error) {
            // Handle error
            console.log('==============Error  ' + error);
            console.log(error);
        }
    }

    todaysDate(){
        return today.getDate();
    }

    handleNameChange(event){
        console.log('Name:::>>>',event.detail.value);
        console.log('regex.test(x):::::>>>>',regex.test(event.detail.value));
        this.nameVali = regex.test(event.detail.value);
        console.log('test',this.test);
         //     Mess = this.template.querySelector(".Mess");
    // if(this.value != 'foo') {
    //     Mess.set('validity', {valid:false, badInput :true});
    //     Mess.showHelpMessageIfInvalid();

    // }

    let nameCmp = this.template.querySelector(".NameInput");



    if(!this.nameVali){
        nameCmp.setCustomValidity(nameLabel);
        this.displaybutton =  false;
    }
    else{
        nameCmp.setCustomValidity("");
        this.value = event.detail.value;
        this.data.name = event.detail.value;
        this.bool1 = true;
        if(this.bool1 && this.bool2 && this.bool3){
            this.displaybutton =  true;
        }
    }
    nameCmp.reportValidity();
    console.log(nameLabel);

            
    }

    handleDateChange(event){
        console.log('Date:::>>>',event.detail.value);
        var today = new Date();
        let dateCmp = this.template.querySelector(".DataInput");
        // console.log('Date target::::>>>',event.target.value);
        if(event.detail.value == null){
            this.data.close_Date = 'Date';
            this.bool2 = false;
            this.displaybutton =  false;
        }
        else if(new Date(event.detail.value).getTime() < today.getTime()){
            
            this.bool2 = false;
            dateCmp.setCustomValidity(dateLabel);
            this.displaybutton =  false;
            console.log('stype:::',typeof this.data.close_Date);
            console.log('stype:::',new Date(event.detail.value).getTime());
        } else{
            this.data.close_Date = event.detail.value.toString();
            dateCmp.setCustomValidity('');
            this.bool2 = true;
            if(this.bool1 && this.bool2 && this.bool3){
                this.displaybutton =  true;
            }
        }
        dateCmp.reportValidity();


    }

    handlePickListChange(event) {
        this.data.stage_Name = event.detail.value;
        this.bool3 = true;
        if(this.bool1 && this.bool2 && this.bool3){
            this.displaybutton =  true;
        }
        else{
            this.displaybutton =  false;
        }
        console.log('Picklist:::>>>',event.detail.value);

        
    }

    handleAccountChange(event) {
        // this.rec.AccountId = event.target.value;
        this.data.accountId = event.target.value;
        console.log('Account id:::>>>>>',event.target.value);
    }

    // handlePriceBookName(event){
    //     this.data.priceBookName = event.detail.value;
    //     console.log('Price Book Name ::: >>>',this.data.priceBookName);
    // }

    handleSaveButton(){
        
        // if(regex.test(this.data.name)){
        //     console.log('After click save button Name::::>>>>',this.data);
        // }
        // else{
        //     console.log('Enter valid Name');
        // }
        console.log('After click save button Name::::>>>>',this.data);
        this.isShowModal = true ; 
        
    }

    hideModalBox(){
        this.isShowModal = false;
        this.isShowModal2 = false;
    }

    // name: this.data.name,
    //                     close_Date: this.data.close_Date,
    //                     accountId : this.data.accountId,
    //                     stage_Name : this.data.stage_Name
    handleSaveOpp(){
        createOpportunity({farMap:this.data})
            .then(result =>{
                console.log('In create Opportunity::::>>>',result);
                this.oppId = result;
                if(result != null){
                    const evt = new ShowToastEvent({
                        title: 'Toast Success',
                        message: 'Opportunity is successfully Created',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                }
            })
            .catch(error => {
                console.log('error:::::>>',error);
            });
        this.isShowModal = false;
        // this.isShowModal2 = true;
        this.display1 = false;
        this.display2 = true;
    }

    handleSaveLaterOpp(){
        this.isShowModal = false;
        // this.isShowModal2 = true;
        this.display1 = false;
        this.display3 = true;
        this.name = this.data.name;
        this.close_Date = this.data.close_Date;
        this.stage_Name = this.data.stage_Name;
        this.accountId = this.data.accountId;
        this.oppId = null;
    }

    // handleCreatePriceBook(){
    //     this.isShowModal2 = false;
    //     this.val1.name = this.data.name;
    //     this.isShowModal3 = true;

    // }

    // handlePriceBookSave(){
    //     console.log(this.data.priceBookName);
        
    // }

}