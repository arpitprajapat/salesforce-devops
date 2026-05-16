import { LightningElement, track } from 'lwc';
import UserInput from '@salesforce/apex/UserInputClass.UserInput';


const columns = [
    { label: 'Name', fieldName: 'Name'},
	{ label: 'Account id', fieldName: 'Id'},
    { label: 'Email', fieldName: 'Email'},
];

export default class TakeInputFromUser extends LightningElement {
    @track Name = '';  
	@track Email = '';
    @track data = [];
    @track error;  
	columns = columns;	

	handleClickName(event){
		console.log('---13----',event.target.value);
		this.Name = event.target.value;
	}
	handleClickEmail(event){
		console.log('----14---',event.target.value);
		this.Email = event.target.value;

	}

    handleClick(event) {
        console.log('--line 13--');
		console.log('-----Name ----',this.Name);
		console.log('---Email--',this.Email);

        UserInput({ Name: this.Name, Email: this.Email})
            .then(result => {

                console.log('--line 15-- result--', result);
				console.log('--line 15-- result--', JSON.stringify(result));
                this.data = result;

                this.error = undefined; 
            })
            .catch(error => {
                this.error = error;  	
                this.data = undefined;        
            });
    }
}