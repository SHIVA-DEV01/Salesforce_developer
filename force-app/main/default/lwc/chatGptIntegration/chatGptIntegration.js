import { LightningElement} from 'lwc';

import getQueryData from '@salesforce/apex/ChatGPTController.getQueryData';

export default class ChatGptIntegration extends LightningElement {
    searchTerm = '';
    showSpinner = false
    responseData;
    queriesList = [];
    answersList = [];
    showQueriesList = false;
    showAnswersList = false;
    showhome = true;

    handleKeyDown(event, flag) {
        console.log('OUTPUT : ',event.keyCode);

        if (event.keyCode === 13 || flag === true) {
            // Perform search when the Enter key is pressed
            this.searchTerm = this.template.querySelector('.input-field').value;
            this.queriesList.push(this.searchTerm);
            this.showQueriesList = true;
            this.showSpinner = true;
            getQueryData({ searchString: this.searchTerm })
                .then(result => {
                    this.showSpinner = false
                    let response = JSON.parse(JSON.stringify(JSON.parse(result)));
                    console.log('OUTPUT : ', response.choices[0].message.content);
                    if (response.error) {
                        this.responseData = response.error.message;
                    } else if (response.choices[0].message.content) {
                        this.responseData = response.choices[0].message.content;
                        this.answersList.push(this.responseData);
                        this.showAnswersList = true;
                        console.log('OUTPUT : ',this.responseData);
                    }
                    // console.log('ss', JSON.stringify(this.responseData))
                })
                .catch(error => {
                    this.showSpinner = false
                    console.log('error is ' + error)
                    error.forEach(currentItem => {
                       console.log('OUTPUT : ',currentItem);
                    });
                })
        }

    }

    handleSubmit(){
        this.handleKeyDown('zsdsa',true);
    }
}