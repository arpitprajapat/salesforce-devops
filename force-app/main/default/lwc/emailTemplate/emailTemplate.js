import { LightningElement, track } from 'lwc';

export default class EmailTemplate extends LightningElement {
  @track selectedStep = 'step1';

  handleStepChange(event) {
    this.selectedStep = event.target.value;
  }
}