import { LightningElement, track } from 'lwc';
export default class SampleLWC extends LightningElement {
    @track dropdownOptions = ['Select Customer'];
    @track selectedOption = 'Select Customer';
    @track accCode = '';
    @track startDate = '';
    @track endDate = '';

    handleDropdownChange(event) {
        this.selectedOption = event.target.value;
        // Call an Apex method to fetch the account number based on the selected option
        // and update the accCode property
    }

    handleStartDateChange(event) {
        this.startDate = event.target.value;
    }

    handleEndDateChange(event) {
        this.endDate = event.target.value;
    }

    handleGoClick() {
        // Validate inputs if needed
        // Perform any additional actions before redirecting
        // Redirect to an external page with the provided parameters
        window.open(`/external-page-url?acccode=${encodeURIComponent(this.accCode)}&sdate=${encodeURIComponent(this.startDate)}&edate=${encodeURIComponent(this.endDate)}`);
    }
}