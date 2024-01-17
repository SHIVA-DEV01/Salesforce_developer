import { LightningElement, track } from 'lwc';
export default class IntegrationWithSalesforce extends LightningElement {
    @track repos;

    async handleFetch() {
        let endPoint = "https://cloudanalogy-64d-dev-ed.lightning.force.com/services/apexrest/api/getAttachments";
        const response = await fetch(endPoint, {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer 00D5g00000D8fOK!AQgAQN4D72y5n.iPpcCB9lv7P.5Hshfb8.czk4.7f7xfuFRzZaPIL5QAXc93QZZ1Y3eXHFTqqv_1Cd8jnmRMP8TRvltzVwZa',
            }
        });
        const repos = await response.json();
        this.repos = repos;
        // console.log(repos);
    }
}