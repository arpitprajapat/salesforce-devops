import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import EMPLOYEES_IN_PROJECTS_OBJECT from '@salesforce/schema/Employees_in_Projects__c';
// import SUBJECT_FIELD from '@salesforce/schema/Employees_in_Projects__c.Subject__c';  
// import PROJECT_FIELD from '@salesforce/schema/Employees_in_Projects__c.Project__c'; 

export default class EmplnProjectCreator extends LightningElement {
    @track subjectId;
    @track projectId = '';
    @track successMsg = '';
    @track errorMsg = '';

    handleSubjectChange(event) {
        this.subjectId = event.detail.recordId;
        this.resetMessages();
    }

    handleProjectChange(event) {
        this.projectId = event.detail.recordId;
        this.resetMessages();
    }

    get isSaveDisabled() {
        return !this.subjectId || !this.projectId;
    }

    handleSave() {
        const fields = {};
        fields[SUBJECT_FIELD.fieldApiName] = this.subjectId;
        fields[PROJECT_FIELD.fieldApiName] = this.projectId;

        const recordInput = { apiName: EMPLOYEES_IN_PROJECTS_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(() => {
                this.successMsg = 'Record created successfully!';
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'EmplnProject record saved',
                    variant: 'success'
                }));
                this.subjectId = '';
                this.projectId = '';
            })
            .catch(error => {
                this.errorMsg = 'Error: ' + error.body.message;
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                }));
            });
    }

    resetMessages() {
        this.successMsg = '';
        this.errorMsg = '';
    }
}