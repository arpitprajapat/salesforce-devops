// import { LightningElement, wire, api } from 'lwc';
// import getCasesByContactIdApexMethod from '@salesforce/apex/ContactCaseControllerClass.getCasesByContactIdApexMethod';

// export default class ContactCases extends LightningElement {
//     @api recordId;
//     cases;
//     error;

//     columns = [
//         {
//             label: 'Case Number / Component Name',
//             fieldName: 'caseUrl',
//             type: 'url',
//             typeAttributes: {
//                 label: { fieldName: 'CaseNumber' },
//                 target: '_blank'
//             },
            
//             cellAttributes: {
//                 style: 'text-decoration: underline dotted;text-underline-offset: 2px; color: #0070d2; font-weight: normal;'
//             }
//         },
//         {
//             label: 'Status',
//             fieldName: 'Status',
//             type: 'text'
//         },
//         {
//             label: 'Case Origin',
//             fieldName: 'Origin',
//             type: 'text'
//         },
//         {
//             label: 'Comp Origin',
//             fieldName: 'CompOrigin__c',
//             type: 'text'
//         },
//         {
//             label: 'Web Name',
//             fieldName: 'SuppliedName',
//             type: 'text'
//         },
//          {
//             label: 'Web Phone',
//             fieldName: 'SuppliedPhone',
//             type: 'text'
//         },
//          {
//             label: 'Web Email',
//             fieldName: 'SuppliedEmail',
//             type: 'text'
//         },
//          {
//             label: 'Web Company',
//             fieldName: 'SuppliedCompany',
//             type: 'text'
//         },
//          {
//             label: 'Type',
//             fieldName: 'Type',
//             type: 'text'
//         },
//          {
//             label: 'Case Reason',
//             fieldName: 'Reason',
//             type: 'text'
//         },
//          {
//             label: 'Product',
//             fieldName: 'Product__c',
//             type: 'text'
//         },
//          {
//             label: 'Engineering Req Number',
//             fieldName: 'EngineeringReqNumber__c',
//             type: 'text'
//         },
//          {
//             label: 'Subject',
//             fieldName: 'Subject',
//             type: 'text'
//         },
//          {
//             label: 'Description',
//             fieldName: 'Description',
//             type: 'text'
//         },
//         {
//             label: 'Potential Liability',
//             fieldName: 'PotentialLiability__c',
//             type: 'text'
//         },
//         {
//             label: 'SLA Violation',
//             fieldName: 'SLAViolation__c',
//             type: 'text'
//         } ,
//     ];
//     @wire(getCasesByContactIdApexMethod, { contactId: '$recordId' })
//     wiredCases({ data, error }) {
//         if (data) {
//             this.cases = data.map(row => ({
//                 ...row,
//              //   caseUrl: `/lightning/r/Case/${row.Id}/view`
//                 caseUrl: `/lightning/r/${row.RecordType === 'Case' ? 'Case' : 'Component__c'}/${row.Id}/view`
               
//             }));
//              console.log('----line 51------'+ JSON.stringify(data));
//              console.log('----line 52 ------'+this.cases);
//             this.error = undefined;
//         } else if (error) {
//             this.error = error;
//             this.cases = undefined;
//             console.log('----line 57------'+ this.error);

//         }
//     }
// }




import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getCasesByContactIdApexMethod from '@salesforce/apex/ContactCaseControllerClass.getCasesByContactIdApexMethod';

export default class ContactCases extends NavigationMixin(LightningElement) {
    @api recordId;
    cases;
    error;

    columns = [
        {
            label: 'Case Number / Component Name',
            fieldName: 'caseUrl',
            type: 'url',
            typeAttributes: {
                label: { fieldName: 'CaseNumber' },
                target: '_blank'
            },
            cellAttributes: {
                style: 'text-decoration: underline dotted;text-underline-offset: 2px; color: #0070d2; font-weight: normal;'
            }
        },
        { label: 'Status', fieldName: 'Status', type: 'text' },
        { label: 'Case Origin', fieldName: 'Origin', type: 'text' },
        { label: 'Comp Origin', fieldName: 'CompOrigin__c', type: 'text' },
        { label: 'Web Name', fieldName: 'SuppliedName', type: 'text' },
        { label: 'Web Phone', fieldName: 'SuppliedPhone', type: 'text' },
        { label: 'Web Email', fieldName: 'SuppliedEmail', type: 'text' },
        { label: 'Web Company', fieldName: 'SuppliedCompany', type: 'text' },
        { label: 'Type', fieldName: 'Type', type: 'text' },
        { label: 'Case Reason', fieldName: 'Reason', type: 'text' },
        { label: 'Product', fieldName: 'Product__c', type: 'text' },
        { label: 'Engineering Req Number', fieldName: 'EngineeringReqNumber__c', type: 'text' },
        { label: 'Subject', fieldName: 'Subject', type: 'text' },
        { label: 'Description', fieldName: 'Description', type: 'text' },
        { label: 'Potential Liability', fieldName: 'PotentialLiability__c', type: 'text' },
        { label: 'SLA Violation', fieldName: 'SLAViolation__c', type: 'text' }
    ];

    @wire(getCasesByContactIdApexMethod, { contactId: '$recordId' })
    wiredCases({ data, error }) {
        if (data) {
            this.cases = data.map(row => ({
                ...row,
                caseUrl: `/lightning/r/${row.RecordType === 'Case' ? 'Case' : 'Component__c'}/${row.Id}/view`
            }));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.cases = undefined;
        }
    }

    handleViewAll() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'View_All_Cases_Components' // ⚠️ make sure this custom tab exists
            },
            state: {
                c__recordId: this.recordId
            }
        });
    }
}