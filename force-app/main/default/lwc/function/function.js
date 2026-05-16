import { LightningElement } from 'lwc';
export default class Function extends LightningElement {

myTitle = "function";

connectedCallback() {
    //code
    let CallFunction = this.myFunction(10,5);
    window.alert("CallFunction by arrow function:"+CallFunction);

}

// myFunction(dividend , divisor){
// return(dividend , divisor);
//     }

myFunction =(dividend , divisor) =>{
    return(dividend / divisor);

    }
}