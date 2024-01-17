import { LightningElement, api, wire} from 'lwc';
// import { getRecord } from 'lightning/uiRecordApi';

// const FIELDS = ['Account.NotesAndAttachments'];
import getOpportunities from '@salesforce/apex/AccountChart.getAccountOppCon';

export default class AudioTestSound extends LightningElement {
    @api recordId;
    resultData=[{}];
    currentAudio = null;

    connectedCallback() {
        console.log('OUTPUT : ',this.recordId);
        getOpportunities({recordId : this.recordId})
        .then(result => {
            console.log('OUTPUT :',result);
            this.resultData = result;
        })
        .catch(error => {
                console.log(' Weather error  !!!!!!! ', error);
            })
    }

    handlePlay(currentAudio) {
        // Pause all other audio elements except the current one
        const audioElements = this.template.querySelectorAll('audio');
        audioElements.forEach((audio) => {
            if (audio !== currentAudio && !audio.paused) {
                audio.pause();
            }
        });
    }

    handlePause() {
        // Do any cleanup or handling needed when audio is paused
    }
    renderedCallback(){
        let audioElement = this.template.querySelectorAll('audio');
        console.log('audioElements >>>> ',audioElement);
        audioElement.forEach((audio) => {
            console.log('OUTPUT : audio ');
            audio.addEventListener('play', this.handlePlay.bind(this, audio));
        });
    }
}