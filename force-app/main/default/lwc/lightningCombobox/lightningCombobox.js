import { LightningElement, track } from 'lwc';
export default class LightningCombobox extends LightningElement {
    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
            { label: 'New1', value: 'new1' },
            { label: 'In Progress1', value: 'inProgress1' },
            { label: 'Finished1', value: 'finished1' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
    disableVar = false;
    @track combobox;
    isDropdownVisible = false;
    // renderedCallback(){
    //     console.log('remder:::::::::::::::');
    //     this.combobox = this.template.querySelector('.combobox').classList;        
    //     window.addEventListener('scroll', this.handleScroll(this.combobox));
    //     console.log('ln 24::::::::::',myStaticStyles);
    //     Promise.all([
    //         loadStyle( this, myStaticStyles)
    //         ]).then(() => {
    //             console.log( 'Files loaded' );
    //         })
    //         .catch(error => {
    //             console.log( error.body.message );
    //     });
    // }

    // connectedCallback() {
    //     // Attach the scroll event listener when the component is connected to the DOM
    //     window.addEventListener('scroll', this.handleScroll);
    // }
    renderedCallback(){
        let combobox = this.template.querySelector("[data-id='Controlling Picklist Type']");
        // console.log('this.template.querySelector'+ this.template.querySelector("[data-id='Controlling Picklist Type']"));
        // console.log('Output >>> '+ combobox);
        window.addEventListener('scroll', (event) => {
            this.handleScroll({
                event: event,
                customParameter: combobox
            });
        });
    }

    // disconnectedCallback() {
    //     // Remove the scroll event listener when the component is disconnected from the DOM
    //     window.removeEventListener('scroll', this.handleScroll);
    // }
    handleScroll(combobox) {
        try {
            console.log('In handleScroll'+ combobox);
            this.isDropdownVisible = false;
            // if (this.template) {
            // const combobox = this.template.querySelector('.combobox');
            // if (combobox) {
            //     combobox.closeDropdown();
            // }
        // }
        } catch (error) {
            console.log(error);
        }

    }
}