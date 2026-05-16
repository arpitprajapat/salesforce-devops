import { LightningElement, wire,track} from 'lwc';
import getAccList from '@salesforce/apex/assignmentClass.getAccList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [ 
  { label: 'Select All', fieldName: 'Select All' },
     { label: 'Account id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' },
];
let i=0;
export default class PaginationTechdicer extends LightningElement {
    @track searchKey ='';
    page = 0; //initialize 1st page
    items = []; //contains all the records.
    data = []; //data  displayed in the table
    columns; //holds column info.
    startingRecord = 1; //start record position per page
    endingRecord = 0; //end record position per page
    pageSize = 5; //default value we are assigning
    totalRecountCount = 0; //total record count received from all retrieved records
    totalPage = 0; //total number of page is needed to display all records
 
     @wire(getAccList)
    getAccList({ error, data }) {
        if (data) {
            this.items = data;
            this.totalRecountCount = data.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
            //here we slice the data according page size
            this.data = this.items.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns; 
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
            this.showToast(this.error, 'Error', 'Error'); //show toast for error
        }
    }

    handleSearch(event) {
    this.searchKey = event.target.value.toLowerCase();
    console.log('---line 42----', this.searchKey );

    if (this.searchKey) {
        console.log('--line 45---',this.searchKey);
        this.data = this.items.filter(acc =>

            acc.Name.toLowerCase().includes(this.searchKey)
           
        );

        }
    }
    previousHandler() {
        if (this.page > 1) {           // 10 > 1 , 9>1 ,8>1 , 7>1 , 6>1 , 5>1 , 4>1 , 3>1 , 2>1 
            console.log('--lline 43--',this.page);
            this.page = this.page - 1;     //  10-1 , 9-1 , 8-1 ,7-1 , 6-1 ,5-1 , 4-1 ,3-1 , 2-1 = 1
            console.log('--line 45--',this.page);
            this.displayRecordPerPage(this.page);
        }
    }
 
    clickHandler() {
        if((this.page < this.totalPage) && this.page !== this.totalPage){
        
            this.page = this.page + 1;  // page 0+1 = 1 , 1+1=2 , 2+1=3 , 3+1=4 , 4+1=5 , 5+1=6 , 6+1=7, 7+1=8 , 8+1=9 , 9+1=10  
            console.log('--line 54--',this.page);

            this.displayRecordPerPage(this.page);            
        }             
    }
 
    //this method displays records page by page
    displayRecordPerPage(page){
        console.log('--line 62 page--',page);  // 1
         
        this.startingRecord = ((page -1) * this.pageSize)              
              console.log('-line 65  this.startingRecord--',this.startingRecord);  

        this.endingRecord = (this.pageSize * page)
                console.log('-line 68 this.endingRecord--',this.endingRecord);    

        this.endingRecord = (this.endingRecord > this.totalRecountCount)    
                             ? this.totalRecountCount : this.endingRecord; 
        console.log('--line 72  this.endingRecord---', this.endingRecord );
 
        this.data = this.items.slice(this.startingRecord, this.endingRecord)   
        console.log('--line 75 this.data---',this.data);
        
        this.startingRecord = this.startingRecord + 1;       // it will increment 0+1 
        console.log('--line 78 this.statingRecord---',this.startingRecord);
    }    
 
    showToast(message, variant, title) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}