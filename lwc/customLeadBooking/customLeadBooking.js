import { LightningElement, api, track } from 'lwc';
import getLead from '@salesforce/apex/RealEstateLeadController.getLead';
import getProjects from '@salesforce/apex/RealEstateLeadController.getProjects';
import getTowers from '@salesforce/apex/RealEstateLeadController.getTowers';
import getTowerInventory from '@salesforce/apex/RealEstateLeadController.getTowerInventory';

export default class LeadPropertySelector extends LightningElement {

    @api recordId;
    @track lead = {};
    @track projectOptions = [];
    @track towers = [];
    @track floors = [];
    @track selectedUnit;

    selectedProjectId;
    selectedTowerId;

    get isEditMode() {
        return this.recordId != null;
    }

    connectedCallback() {
        if (this.isEditMode) {
            getLead({ leadId: this.recordId })
                .then(data => this.lead = data);
        }

        getProjects().then(data => {
            this.projectOptions = data.map(p => ({
                label: p.Name,
                value: p.Id
            }));
        });
    }

    handleLeadChange(event) {
        this.lead[event.target.dataset.field] = event.target.value;
    }

    handleProjectChange(event) {
        this.selectedProjectId = event.detail.value;
        getTowers({ projectId: this.selectedProjectId })
            .then(data => this.towers = data);
    }

    handleTowerSelect(event) {
        this.selectedTowerId = event.target.value;
        getTowerInventory({ towerId: this.selectedTowerId })
            .then(data => {
                this.floors = data.floors.map(f => {
                    f.units.forEach(u => {
                        u.cssClass = 'unit ' +
                            (u.status === 'Available' ? 'available' :
                             u.status === 'Blocked' ? 'blocked' : 'booked');
                    });
                    return f;
                });
            });
    }

    handleUnitClick(event) {
        const unitId = event.currentTarget.dataset.id;
        const unit = this.findUnit(unitId);
        if (unit.status !== 'Available') return;
        this.selectedUnit = unit;
    }

    findUnit(id) {
        for (let f of this.floors) {
            const match = f.units.find(u => u.unitId === id);
            if (match) return match;
        }
        return null;
    }
}