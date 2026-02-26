import { LightningElement, api, wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createLead from '@salesforce/apex/PropflowLeadController.createLead';
import { IsConsoleNavigation, getFocusedTabInfo, setTabHighlighted } from 'lightning/platformWorkspaceApi';



export default class PropflowLeadCreate extends NavigationMixin(LightningElement) {

    leadData = {};
    budget = 50;
    timeline = 6;
    isConsole = false;

    @wire(IsConsoleNavigation) isConsoleNavigation;

    unitOptions = [
        { label: '1 BHK', value: '1BHK' },
        { label: '2 BHK', value: '2BHK' },
        { label: '3 BHK', value: '3BHK' },
        { label: 'Villa', value: 'Villa' }
    ];

    visitOptions = [
        { label: 'Not Scheduled', value: 'Not Scheduled' },
        { label: 'Scheduled', value: 'Scheduled' },
        { label: 'Completed', value: 'Completed' }
    ];

    handleChange(event) {
        this.leadData[event.target.dataset.field] = event.target.value;
    }

    handleCheckbox(event) {
        this.leadData[event.target.dataset.field] = event.target.checked;
    }

    handleBudget(event) {
        this.budget = event.target.value;
    }

    handleTimeline(event) {
        this.timeline = event.target.value;
    }

    saveLead() {
        createLead({
            leadRec: this.leadData,
            budget: this.budget,
            timeline: this.timeline
        })
        .then(result => {
            alert('Lead created successfully');

            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: result,
                    actionName: 'view'
                }
            });
        })
        .catch(error => {
            alert(error.body?.message || error.message);
        });
    }

    async cancel() {
        console.log('this.isConsoleNavigation---'+this.isConsoleNavigation);

        if (!this.isConsoleNavigation) {
            return;
        }
        const { tabId } = await getFocusedTabInfo();
        console.log('tabId---'+tabId);
        await closeTab(tabId);
    }
}