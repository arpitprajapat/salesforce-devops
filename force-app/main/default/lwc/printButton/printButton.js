import { LightningElement } from 'lwc';

export default class PrintButton extends LightningElement {
    handlePrint() {
        window.print(); // open browser print dialog
    }
}