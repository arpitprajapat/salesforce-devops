import { LightningElement } from 'lwc';
export default class PublisherComponent extends LightningElement {

    name = '';
    handleChange(event){
        this.name = event.target.value;
        console.log(this.name);

    }

    handleClick(event){
        
    }

}