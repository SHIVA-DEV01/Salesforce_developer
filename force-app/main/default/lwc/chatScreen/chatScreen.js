// chatScreen.js
import { LightningElement, track, api } from 'lwc';
import sendTextMessage from '@salesforce/apex/WhatsAppUtils.sendTextMessage';
import getWARecords from '@salesforce/apex/WhatsAppUtils.getWARecords';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';

export default class ChatScreen extends LightningElement {
    @track messages = [];

    subscription = {};
    @api channelName = '/event/BBDEC__Test_Event__e';

    @track newMessage = '';
    @api recordId;
    customer_number;

    async connectedCallback() {

        await getWARecords({ recordId: this.recordId })
            .then(result => {
                console.log('OUTPUT : ', result);
                this.customer_number = result.customer_number;
                console.log('OUTPUT : ', this.customer_number);
                result.wAMessageRecord.BBDEC__MessageContext__c.split(";").forEach(currentItem => {
                    if (currentItem.at(-1) == 'U') {
                        this.messages.push({
                            id: this.messages.length + 1,
                            text: currentItem.substring(0, currentItem.length - 1),
                            isSentByUser: true
                        });
                    } else {
                        this.messages.push({
                            id: this.messages.length + 1,
                            text: currentItem.substring(0, currentItem.length - 1),
                            isSentByUser: false
                        });
                    }

                    console.log('OUTPUT :', currentItem);
                });

            })
            .catch(error => {
                console.log(' error  !!!!!!! ', error);
            })

        this.handleSubscribe();
    }

    handleInputChange(event) {
        this.newMessage = event.target.value;
    }

    sendMessage() {
        console.log('OUTPUT : this.newMessage  ',this.newMessage);
        sendTextMessage({ messageContent: this.newMessage, toPhone: '917007691632' })
            .then(result => {
                console.log('OUTPUT :', result);
            })
            .catch(error => {
                console.log('error  !!!!!!! ', error);
            })

        if (this.newMessage.trim() !== '') {
            this.messages.push({
                id: this.messages.length + 1,
                text: this.newMessage,
                isSentByUser: true
            });
            this.newMessage = '';
        }
    }

    handleSubscribe() {
        try {
            // Callback invoked whenever a new event message is received
            const thisReference = this;
            const messageCallback = function (response) {
                console.log('New message received 1: ', JSON.stringify(response));
                console.log('New message received 2: ', response);

                var obj = JSON.parse(JSON.stringify(response));
                console.log('New message received 4: ', obj.data.payload.BBDEC__Message__c);
                console.log('New message received 4: ', obj.data.payload.BBDEC__Phone__c);
                if (obj.data.payload.BBDEC__Phone__c == thisReference.customer_number) {
                    thisReference.messages.push({
                        id: thisReference.messages.length + 1,
                        text: obj.data.payload.BBDEC__Message__c,
                        isSentByUser: false
                    });
                    // const chatContainer = thisReference.refs.chatContainer
                    // console.log('chatContainer.offsetHeight => ', chatContainer.offsetHeight);
                    // window.scrollTo(window.innerWidth, window.innerHeight);
                    console.log('LINE 92 SCROLLED ');
                }

                thisReference.dispatchEvent(evt);
            };
            console.log('OUTPUT : ', messageCallback);
            // Invoke subscribe method of empApi. Pass reference to messageCallback
            subscribe(this.channelName, -1, messageCallback).then(response => {
                // Response contains the subscription information on subscribe call
                console.log('Subscription request sent to: ', JSON.stringify(response.channel));
                this.subscription = response;
            });
        } catch (error) {
            console.error('error in handleSubscribe methods : ', error);
        }
    }

    // getMessageClass(message) {
    //     return message.isSentByUser ? 'user-message' : 'other-message';
    // }


}