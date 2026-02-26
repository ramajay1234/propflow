import { LightningElement, api, wire, track } from 'lwc';
import getLicenses from '@salesforce/apex/PropFlowLicenseController.getLicenses';


export default class PropflowLanding extends LightningElement {
    @api appTitle = 'PropFlow CRM';
    logoUrl = '/resource/SFCloudApps';

    
    @track licenses;
    @track error;

    // Columns for lightning-datatable
    columns = [
        { label: 'Customer Name', fieldName: 'SFCloudApps__Customer_Name__c' },
        { label: 'Customer ID', fieldName: 'SFCloudApps__CustomerId__c' },
        { label: 'License Type', fieldName: 'SFCloudApps__License_Type__c' },
        { label: 'Expiry Date', fieldName: 'SFCloudApps__ExpiryDate__c', type: 'date' },
        { label: 'Sales', fieldName: 'SFCloudApps__PropFlowCRM__c', type: 'checkbox' },
        { label: 'Projects', fieldName: 'SFCloudApps__PropFlowProjects__c', type: 'checkbox' },
        { label: 'Maintenance', fieldName: 'SFCloudApps__PropFlowMaintenance__c', type: 'checkbox' },
    ];

    @wire(getLicenses)
    wiredLicenses({ error, data }) {
        if (data) {
            this.licenses = data;
            console.log('data----'+JSON.stringify(this.licenses));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.licenses = undefined;
        }
    }
}