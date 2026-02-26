import { LightningElement, api,wire,track } from 'lwc';
export default class CreateSiteVisitSub extends LightningElement {

    @api fromSites;
    @track successmessage;
    @track errormessage;
    @track showmessage = false;
    handleSuccess() {
        console.log('this.fromSites----'+this.fromSites);
        this.showmessage = true;
        this.successmessage = 'Site Visit created successfully';
        if(!this.fromSites) {
             console.log('enter-if---');
            // Create a CustomEvent with a name and data in the 'detail' property
            const event = new CustomEvent('handlesuccess', {
                detail: true
            });

            // Dispatch the event
            this.dispatchEvent(event)
        }
    }

    handleError(event) {
        this.errormessage = event.detail.message;
        if(!this.fromSites) {
            // Create a CustomEvent with a name and data in the 'detail' property
            const event = new CustomEvent('handleerror', {
                detail: event.detail.message
            });

            // Dispatch the event
            this.dispatchEvent(event)
        }
    }
}