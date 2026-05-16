// import { LightningElement, track, api } from 'lwc';
// import searchAccounts from '@salesforce/apex/AccountMultiLookupCtrl.searchAccounts';

// export default class AccountMultiLookupCtrl extends LightningElement {
//     @track searchKey = '';
//     @track searchResults = [];
//     @track selectedRecords = [];
//     @track showDropdown = false;

//     @api
//     get selectedIds() {
//         return this.selectedRecords.map(r => r.recordId);
//     }

//     handleSearchKeyChange(event) {
//         this.searchKey = event.target.value;
//         if (this.searchKey && this.searchKey.length >= 2) {
//             this.fetchAccounts();
//         } else {
//             this.showDropdown = false;
//             this.searchResults = [];
//         }
//     }

//     fetchAccounts() {
//         searchAccounts({ searchKey: this.searchKey })
//             .then(result => {
//                 const selectedIds = new Set(this.selectedIds);
//                 const notSelected = result.filter(
//                     r => !selectedIds.has(r.recordId)
//                 );
//                 this.searchResults = notSelected;
//                 this.showDropdown = this.searchResults.length > 0;
//             })
//             .catch(error => {
//                 // eslint-disable-next-line no-console
//                 console.error('Error while searching accounts', error);
//             });
//     }

//     handleRowSelect(event) {
//         const recId = event.currentTarget.dataset.id;
//         const rec = this.searchResults.find(r => r.recordId === recId);
//         if (!rec) return;

//         this.selectedRecords = [...this.selectedRecords, rec];

//         this.searchKey = '';
//         const input = this.template.querySelector('lightning-input');
//         if (input) {
//             input.value = '';
//         }

//         this.searchResults = [];
//         this.showDropdown = false;

//         this.fireSelectionEvent();
//     }

//     handleRemove(event) {
//         const recId = event.target.name;
//         this.selectedRecords = this.selectedRecords.filter(
//             r => r.recordId !== recId
//         );
//         this.fireSelectionEvent();
//     }

//     fireSelectionEvent() {
//         const ids = this.selectedIds;
//         this.dispatchEvent(
//             new CustomEvent('selection', {
//                 detail: { selectedIds: ids, selectedRecords: this.selectedRecords }
//             })
//         );
//     }

//     // buttons
//     handleCancel() {
//         this.selectedRecords = [];
//         this.searchResults = [];
//         this.searchKey = '';
//         const input = this.template.querySelector('lightning-input');
//         if (input) {
//             input.value = '';
//         }
//         this.showDropdown = false;
//         this.fireSelectionEvent();
//     }

//     handleDone() {
//         // parent can handle 'done' event if needed
//         this.dispatchEvent(
//             new CustomEvent('done', {
//                 detail: { selectedIds: this.selectedIds, selectedRecords: this.selectedRecords }
//             })
//         );
//     }
// }





// import { LightningElement, track, api } from 'lwc';
// import searchAccounts from '@salesforce/apex/AccountMultiLookupCtrl.searchAccounts';
// import saveSelectedAccounts from '@salesforce/apex/AccountMultiLookupCtrl.saveSelectedAccounts'; 

// export default class SearchBar extends LightningElement {  
//     @track searchKey = '';
//     @track searchResults = [];
//     @track selectedRecords = [];
//     @track showDropdown = false;
    
//     @api recordId; 

//     get selectedIds() {
//         return this.selectedRecords.map(r => r.recordId);
//     }

//     handleSearchKeyChange(event) {
//         this.searchKey = event.target.value;
//         if (this.searchKey.length >= 2) {
//             this.fetchAccounts();
//         } else {
//             this.showDropdown = false;
//             this.searchResults = [];
//         }
//     }

//     fetchAccounts() {
//         searchAccounts({ searchKey: this.searchKey })
//             .then(result => {
//                 const selectedIds = new Set(this.selectedIds);
//                 this.searchResults = result.filter(r => !selectedIds.has(r.recordId));
//                 this.showDropdown = this.searchResults.length > 0;
//             })
//             .catch(error => console.error('Search error:', error));
//     }

//     handleRowSelect(event) {
//         const recId = event.currentTarget.dataset.id;
//         const rec = this.searchResults.find(r => r.recordId === recId);
//         if (!rec) return;

//         this.selectedRecords = [...this.selectedRecords, rec];
//         this.searchKey = '';
//         this.searchResults = [];
//         this.showDropdown = false;
//         this.fireSelectionEvent();
//     }

//     handleRemove(event) {
//         const recId = event.target.name;
//         this.selectedRecords = this.selectedRecords.filter(r => r.recordId !== recId);
//         this.fireSelectionEvent();
//     }

//     fireSelectionEvent() {
//         this.dispatchEvent(new CustomEvent('selection', {
//             detail: { selectedIds: this.selectedIds, selectedRecords: this.selectedRecords }
//         }));
//     }

//     handleCancel() {
//         this.selectedRecords = [];
//         this.searchKey = '';
//         this.searchResults = [];
//         this.showDropdown = false;
//         this.fireSelectionEvent();
//     }

//     handleDone() {
//         console.log('Record ID:', this.recordId);
//         console.log('Selected IDs:', this.selectedIds);
        
//         if (!this.recordId) {
//             alert(' No parent record found');
//             return;
//         }
        
//         if (this.selectedIds.length === 0) {
//             alert(' Please select at least one account');
//             return;
//         }

//         saveSelectedAccounts({ 
//             parentId: this.recordId, 
//             accountIds: this.selectedIds 
//         })
//         .then(result => {
//             console.log('SAVED:', result);
//             alert(result);
//             window.close();
//         })
//         .catch(error => {
//             console.error(' Error:', error);
//             alert('Error: ' + (error.body ? error.body.message : error.message));
//         });
//     }
// }






import { LightningElement, track, api } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountMultiLookupCtrl.searchAccounts';
import saveSelectedAccounts from '@salesforce/apex/AccountMultiLookupCtrl.saveSelectedAccounts';

export default class SearchBar extends LightningElement {
    @track searchKey = '';
    @track searchResults = [];
    @track selectedRecords = [];
    @track showDropdown = false;
    
    @api recordId;  // From VF

    get selectedIds() {
        return this.selectedRecords.map(r => r.recordId);
    }

    handleSearchKeyChange(event) {
        this.searchKey = event.target.value;
        if (this.searchKey.length >= 1) {
            this.fetchAccounts();
        } else {
            this.showDropdown = false;
            this.searchResults = [];
        }
    }

    fetchAccounts() {
        searchAccounts({ searchKey: this.searchKey })
            .then(result => {
                const selectedIds = new Set(this.selectedIds);
                this.searchResults = result.filter(r => !selectedIds.has(r.recordId));
                this.showDropdown = this.searchResults.length > 0;
            })
            .catch(error => console.error('Search error:', error));
    }

    handleRowSelect(event) {
        const recId = event.currentTarget.dataset.id;
        const rec = this.searchResults.find(r => r.recordId === recId);
        if (!rec) return;

        this.selectedRecords = [...this.selectedRecords, rec];
        this.searchKey = '';
        const input = this.template.querySelector('lightning-input');
        if (input) input.value = '';
        this.searchResults = [];
        this.showDropdown = false;
    }

    handleRemove(event) {
        const recId = event.target.name;
        this.selectedRecords = this.selectedRecords.filter(r => r.recordId !== recId);
    }

    handleCancel() {
        window.close();
    }

    handleDone() {
        //  PRIORITY: @api recordId → URL param → Path
        let recordId = this.recordId;
        
        if (!recordId) {
            const urlParams = new URLSearchParams(window.location.search);
            recordId = urlParams.get('id');
        }
        
        if (!recordId) {
            recordId = window.location.pathname.split('/')[1];
        }
        
        console.log('Final recordId:', recordId);

        if (!recordId || recordId.length < 15) {
            alert(' No valid record ID found');
            return;
        }
        
        if (this.selectedIds.length === 0) {
            alert(' Please select accounts');
            return;
        }

        saveSelectedAccounts({ parentId: recordId, accountIds: this.selectedIds })
            .then(result => {
                alert(result);
                window.close();
            })
            .catch(error => {
                alert(+ (error.body ? error.body.message : error.message));
            });
    }
}