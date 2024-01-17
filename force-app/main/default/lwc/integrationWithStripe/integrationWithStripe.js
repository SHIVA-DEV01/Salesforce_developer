import { LightningElement } from 'lwc';

import createCustomer from '@salesforce/apex/StripePaymentController.createCustomer';
import getCardDetails from '@salesforce/apex/StripePaymentController.getCardDetails';
import paymentMethod from '@salesforce/apex/StripePaymentController.paymentMethod';
import paymentIntentMethod from '@salesforce/apex/StripePaymentController.paymentIntentMethod';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class IntegrationWithStripe extends LightningElement {

    arrayOfSavedCard=[];
    cardDetails = {
        'nameOnCard': '',
        'cardNumber': '',
        'cVV': '',
        'expiry': '',
        'firstName': '',
        'lastName': '',
        'email': ''
    };
    saveCardObject={
        'newCardPay':'false',
        'saveCardForPay': 'false'
    }
    successPayment=false;
    cardPayment=true;
    isPaymentSuccess;
    transactionId;
    selectedCardId;
    amountPaid;
    isNewPayment=false;

    connectedCallback(){
        this.getSavedCards();
    }

    handleChange(event){
        this.cardDetails[event.target.name] = event.target.value;
        console.log('Card Details '+this.cardDetails);

    }

    handleAmount(event){
        this.amountPaid= event.target.value;
    }

    handleChangeSaveCard(event){
        this.saveCardObject[event.target.name] = event.target.checked;
        this.isNewPayment=true;
    }

    handleSelectedCard(event) {

        this.selectedCardId = event.currentTarget.value;
        const cards = this.template.querySelectorAll('lightning-input[data-id="radio"]');
        cards.forEach(card => card.checked = event.currentTarget.value === card.value);
        this.saveCardObject.newCardPay = false;
        this.isNewPayment= false;

    }

    getSavedCards(){

        getCardDetails({})
        .then(result => {
            console.log('result for the card details >', result);
            result.data.forEach(element => {
                let cardResults = {
                    'last4': element.card.last4, 'cardNumber': '************' + element.card.last4, 'expMonth': element.card.exp_month, 'expYear': element.card.exp_year, 'expiry': element.card.exp_month + '/' + element.card.exp_year, 'cardID': element.card.fingerprint, 'cardBrand': this.cardType[element.card.brand], 'paymentMethodId': element.id, 'cardHolderName': element.billing_details.name
                };
                let found = this.arrayOfSavedCard.some(el => el.cardID === cardResults.cardID);
                if (!found) this.arrayOfSavedCard.push(cardResults);
    
            });
        })
        .catch(error => {
            console.log('Error ln 48>>', error);
        })
        
    }

    async handlePayment(){

        await createCustomer({firstName: this.cardDetails.firstName, lastName: this.cardDetails.lastName, email: this.cardDetails.email})
            .then(result => {
                console.log('result for customer creation>>', result);
            })
            .catch(error => {
                console.log('Error ln 249>>', error);
            })

           this.handleCardPayment();
        
    }

    handleCardPayment() {
        const cardRejex = "[0-9]{16}";
        const cvvRejex = "[0-9]{3}";
        const ExpiryRejex = "(0[1-9]|1[0-2])\/[0-9]{4}";
        if (this.saveCardObject.newCardPay && this.cardDetails.nameOnCard && this.cardDetails.cardNumber && this.cardDetails.cVV && this.cardDetails.expiry && this.cardDetails.cardNumber.match(cardRejex) && this.cardDetails.expiry.match(ExpiryRejex) && this.cardDetails.cVV.match(cvvRejex)) {
                let expiry = this.cardDetails.expiry.split('/');
                let payload = 'card[number]='+this.cardDetails.cardNumber+'&card[exp_month]='+expiry[0]+'&card[exp_year]='+expiry[1]+'&card[cvc]='+this.cardDetails.cVV+'&type=card';
                this.handlePaymentMethod(payload);
        }
        else if (this.selectedCardId !== null && this.selectedCardId !== undefined && !this.saveCardObject.newCardPay) {
            this.isLoading = true;
            console.log('In ln 233', JSON.stringify(this.selectedCardId));
            console.log('In line 239', this.saveCardObject.newCardPay);
            this.handlePaymentIntentMethod(JSON.stringify(this.selectedCardId));
        }
        else {
            this.setToastMessage('Required fields', 'Please fill the Required fields', 'error', 'dismissable');
        }
    }

    handlePaymentMethod(payload){
        paymentMethod({payload: payload})
            .then(result => {
                console.log('result for payment method creation>>', result);
                this.handlePaymentIntentMethod(result.id);

            })
            .catch(error => {
                console.log('Error ln 110>>', error);
                this.successPayment=true;
                this.isPaymentSuccess=false;
            })
    }

    handlePaymentIntentMethod(paymentMethodId){

        if(this.amountPaid && paymentMethodId){
        paymentIntentMethod({amount:this.amountPaid, paymentMethodId: paymentMethodId, saveForFuture: this.saveCardObject.saveCardForPay})
        .then(result => {
            console.log('result for payment intent creation>>', result);
            this.successPayment=true;
            this.isPaymentSuccess=true;

        })
        .catch(error => {
            console.log('Error ln 110>>', error);
            this.successPayment=true;
            this.isPaymentSuccess=false;
        })
        }
        else {
            this.setToastMessage('Required fields', 'This payment requires amount and Payment Method', 'error', 'dismissable');
        }
        
    }

    setToastMessage(toastTitle, toastMessage, toastVariant, toastMode) {
        const evt = new ShowToastEvent({
            title: toastTitle,
            message: toastMessage,
            variant: toastVariant,
            mode: toastMode
        });
        this.dispatchEvent(evt);
    }

    handleTryAgain(){
        this.handleGetCardDetails();
        this.cardDetails = {
            'nameOnCard': '',
            'cardNumber': '',
            'cVV': '',
            'expiry': '',
            'firstName': '',
            'lastName': '',
            'email': ''
        };
        this.saveCardObject = {
            'newCardPay':'false',
            'saveCardForPay': 'false'
        };
        this.cardPayment=true;
        this.successPayment=false;
        this.selectedCardId='';
        this.amountPaid='';
    }
}