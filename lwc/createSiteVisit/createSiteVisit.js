import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateSiteVisit extends LightningElement {
    @api recordId; // Lead Id
    @track isModalOpen = false;
    @track fromsites = false;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    handleSuccess() {
        console.log('enter----');
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Site Visit created successfully',
                variant: 'success'
            })
        );
        this.closeModal();

        // Optional: refresh page
        // eval("$A.get('e.force:refreshView').fire();");
    }

    handleError(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: event.detail,
                variant: 'error'
            })
        );
    }
}