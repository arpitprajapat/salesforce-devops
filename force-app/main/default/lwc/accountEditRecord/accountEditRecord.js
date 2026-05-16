import { LightningElement, wire, track } from 'lwc';
 import getAccounts from '@salesforce/apex/AccountControllerInlineEdit.getAccounts';
 import updateAccounts from '@salesforce/apex/AccountControllerInlineEdit.updateAccounts';
 import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    { label: 'Account Name', fieldName: 'Name', editable: true },
    { label: 'Industry', fieldName: 'Industry', editable: true },
    { label: 'Phone', fieldName: 'Phone', editable: true, type: 'phone' }
];

export default class AccountsforDataTable extends LightningElement {
    @track accounts;
 @track draftValues = [];
   data = [];
    columns = COLUMNS;
    @wire(getAccounts)
    wiredAccounts({ data, error }) {
        if (data) {
            this.accounts = data;
            console.log('---line 21---',this.accounts);
        } else if (error) {
            this.showToast('Error', 'Error loading data', 'error');
        }
    }
    handleSave(event) {
        const updatedFields = event.detail.draftValues;

        updateAccounts({ accountsToUpdate: updatedFields })
            .then(() => {
                this.showToast('Success', 'Records updated successfully', 'success');
                this.draftValues = [];
                return this.refreshData();
            })
            .catch(error => {
                this.showToast('Error', 'Error updating records', 'error');
            });
    }

    refreshData() {
        return getAccounts()
            .then(data => {
                this.accounts = data;
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}