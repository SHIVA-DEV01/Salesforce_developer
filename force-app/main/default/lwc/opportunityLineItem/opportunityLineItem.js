import { LightningElement,api,track,wire } from 'lwc';
import getProduct from '@salesforce/apex/OpportunityForm.getProduct';
import createPriceBook from '@salesforce/apex/OpportunityForm.createPriceBook';
import createNewPriceBokEntry from '@salesforce/apex/OpportunityForm.createNewPriceBokEntry';
import createNewOppSaveLater from '@salesforce/apex/OpportunityForm.createNewOppSaveLater';
import createNewProduct from '@salesforce/apex/OpportunityForm.createNewProduct';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OpportunityLineItem extends LightningElement {

    lstSelected = [];
    selected = [];
    @track selectitems = [];
    temp = [];
    options = [];
    priceBookData;
    @api item;
    @api item1 = {};
    @api name;
    @api close_date;
    @api stage_name;
    @api account_id;
    data = {};
    isShowModal = false;
    name;
    showButton = false;
    priceBookId;
    isShowModal1 = false;

    handleChange(event){
        
        this.lstSelected = event.detail.value;
        console.log(event.detail.value);
    }

    createPriceBook(){
       
        this.isShowModal = true;
        getProduct({})
        .then(result =>{
            console.log('In create Products::::>>>',result);

            // this.options.lable = result.lable;
            // this.options.value = result.value;
            this.options = result;
            console.log('Temp:::>>>',this.temp);
            console.log('Option:::>>>',this.options);
            // temp = [];
            // result.forEach(element => {
            //     this.options.label = element.label;
            //     this.options.value = element.value;
            //     temp1 = {};
            //     temp1.label = element.label;
            //     temp1.value = element.value;
            //     temp.push(temp1);
                
            //     console.log(element,this.options);
            // });
            
            
        })
        .catch(error => {
            console.log('error:::::>>',error);
        });
        
        console.log(this.options);
        

    }

    handlePricebookEntry(event){
        console.log('Price book Entry ::: >>>',event.target.value);
        this.priceBookId = event.target.value;
    }

    handleSavePriceBook(){
        console.log('Work in progress');
        if(this.lstSelected.length > 0){
        createPriceBook({priceName:this.data.priceBookData})
            .then(result =>{
                console.log('Create Price Book :::>>>>',result);
            })
            .catch(error =>{
                console.log('error :::::>>>>',error);
            });
            this.isShowModal =false;
        console.log('lstSelected',this.lstSelected.length);
        // if(this.lstSelected.length > 0){
            this.showButton = true;
            console.log('in if',this.lstSelected);
        } 

    }

    handleback(){
        this.isShowModal =false;
        // console.log('lstSelected',this.lstSelected.length);
        // if(this.lstSelected.length > 0){
        //     this.showButton = true;
        //     console.log('in if',this.lstSelected);
        // } 
    }

    hideModalBox(){
        this.isShowModal =false;
        this.isShowModal1 =false;
    }

    handlePriceBookName(event){
        console.log('In handle Price Book Name',event.target.value);
        this.data.priceBookData = event.target.value;
    }

    handleQuantity(event){
        
        this.data.QuantityData = event.target.value;
        console.log(this.data.QuantityData);
        console.log('Item::::>>>',this.item);
    }

    handleUnitPrice(event){
        console.log(this.temp);
        this.data.unitPriceData = event.target.value;
        console.log(this.data.unitPriceData);
        console.log(this.name , this.close_date , this.stage_name , this.account_id);
    }

    handleCreateProduct(){
    this.isShowModal = false;
    this.isShowModal1 = true;
    }

    handleProductName(event){
        this.data.productName = event.target.value;
    }

    handleSaveProduct(){
        console.log('In save Product function');
        if(this.data.productName != null ){
            createNewProduct({productName:this.data.productName})
        .then(result =>{
            console.log('Result in product::::>>>',result);
            if(result.size()>0){
                this.options.push(result);
                const evt = new ShowToastEvent({
                    title: 'Toast Success',
                    message: 'Product are successfully Created',
                    variant: 'success',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
            }
            
            console.log('Result in product::::>>>',this.options);
        })
        .catch(error => {
            console.log('error :::::>>>>',error);
        })
        this.isShowModal1 = false;
        this.isShowModal = true;
        }
        
    }

    handleBackProduct(){
        this.isShowModal1 = false;
        this.isShowModal = true;
    }

    saveData(){
        if(this.item != null){
            console.log('In if save section');
            createNewPriceBokEntry({proList:this.lstSelected,priceBookId:this.priceBookId,oppId:this.item,quantity:this.data.QuantityData , unitPrice:this.data.unitPriceData})
            .then(result =>{
                console.log('Create Price Book :::>>>>',result);
                if(result == 'Success'){
                    const evt = new ShowToastEvent({
                        title: 'Toast Success',
                        message: 'Opportunity Product are successfully Created',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
            }
            })
            .catch(error =>{
                console.log('error :::::>>>>',error);
            })
        }
        else{
            console.log('In else save later section');
            createNewOppSaveLater({proList:this.lstSelected,priceBookId:this.priceBookId,name:this.name,close_Date:this.close_date,stage_Name:this.stage_name,account_Id:this.account_id,quantity:this.data.QuantityData , unitPrice:this.data.unitPriceData})
            .then(result =>{
                console.log('Create Price Book :::>>>>',result);
                if(result == 'Success'){
                        const evt = new ShowToastEvent({
                            title: 'Toast Success',
                            message: 'Opportunity and Opportunity Product are successfully Created',
                            variant: 'success',
                            mode: 'dismissable'
                        });
                        this.dispatchEvent(evt);
                }
            })
            .catch(error =>{
                console.log('error :::::>>>>',error);
            })
        }
        
    }

}