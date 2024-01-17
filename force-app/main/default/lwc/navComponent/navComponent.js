import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class NavComponent extends LightningElement {

    navigateToHomePage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            }
        });
    }

    navigateToContactPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'list'
            }
        });
    }

    navigateToAccountPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
    }
}