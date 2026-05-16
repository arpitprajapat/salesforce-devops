import { LightningElement, wire } from 'lwc';
import getAccList from '@salesforce/apex/wireDemoClass.getAccList';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Account Id', fieldName: 'Id' },
];

export default class WireDemo extends LightningElement {
    columns = columns;
    data = [];

    @wire(getAccList)
    wiredAccount({ data, error }) {
        if (data) {
            this.data = data;
        } else if (error) {
            console.error("Error fetching accounts: ", error);
        }
    }
}