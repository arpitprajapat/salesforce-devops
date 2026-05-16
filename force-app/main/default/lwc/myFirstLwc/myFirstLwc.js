import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class MyFirstLwc extends LightningElement {

    myTitle = "salesforce developer";

    //connectedCallback() { 

        // variable -> var , let , const

        // var name = "salesforce";  // var ka scope inside the funtion hota hai
        // if(this.myTitle){
        // window.alert("name by var : "+name);
        
        // if(this.myTitle){
        //     let name = "salesforce developer";  // let ka scope inside the block hota hai
        // window.alert("name by let : "+name);
        // }

        // if(this.myTitle){
        //     const name = "apex";                    // const ka scope inside the block hota hai
        //     window.alert("name by const : "+name);
        // }

        // mutable assignment  changeble 

        // var name = "hector";      // it can be change
        // name ="fortuner";
        // window.alert("name is "+name);

        // let name = "seltos";   // it can be change
        // name = "verna";
        // window.alert("name is : "+name);

        // const name = "kia";     // it's constant
        // name="amaze";
        // window.alert("name is "+name);
        // }

// handleClick(){
//     window.alert("Heyyyyyy");
// }

// 1st Function
handleClick(){
    this.showToast(this.myTitle);   // pass Argument
}

// 2nd Function
showToast(FirstFunctionArgument){   // recieve parameter
    const event = new ShowToastEvent({
    title:FirstFunctionArgument,
    message:'Developers',
    variant: 'brand',
      })
    this.dispatchEvent(event);
    }
}