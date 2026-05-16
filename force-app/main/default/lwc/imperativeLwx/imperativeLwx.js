import { LightningElement, track } from 'lwc';
import getAccountlist from '@salesforce/apex/imperativeAccountClass.getAccountlist';

export default class ImperativeLwc extends LightningElement {
    @track accounts;  
    @track error;     

    columns = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Account Id', fieldName: 'Id' }
    ];

    handleClick(event) {
        console.log('---line-- ');
        getAccountlist()
            .then(result => {
                console.log('line 17 result', result);
                this.accounts = result; 
                console.log('this-----', JSON.stringify(this.accounts));
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.accounts = undefined;
            })
    }
}