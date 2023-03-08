import { LightningElement,wire,track } from 'lwc';
import getAllLibraries from '@salesforce/apex/SearchingFunctions.getAllLibraries';
import getAllBooks from '@salesforce/apex/SearchingFunctions.getAllBooks';
import getAllUsers from '@salesforce/apex/SearchingFunctions.getAllUsers';
import searchables from '@salesforce/apex/SearchingFunctions.searchables';
import BOOK_ID_FIELD from '@salesforce/schema/Book__c.Id';
import BOOK_NAME_FIELD from '@salesforce/schema/Book__c.Name';
import AVAILABLE_COPIES_FIELD from '@salesforce/schema/Book__c.Available_Copies__c';
import TOTAL_COPIES_FIELD from '@salesforce/schema/Book__c.Total_Number_of_copies__c';
import USER_NAME_FIELD from '@salesforce/schema/Library_User_Accounts__c.Name';
import GENDER_FIELD from '@salesforce/schema/Library_User_Accounts__c.Gender__c';
const COLUMNS = [
    { label: 'Book Name', fieldName: BOOK_NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Available Copies', fieldName: AVAILABLE_COPIES_FIELD.fieldApiName, type: 'number' },
    { label: 'Total Copies', fieldName: TOTAL_COPIES_FIELD.fieldApiName, type: 'number' },
    { label: 'Book Id', fieldName: BOOK_ID_FIELD.fieldApiName, type: 'text' }
];
const USER_COLUMNS = [
    { label: 'User Name', fieldName: USER_NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'GENDER', fieldName: GENDER_FIELD.fieldApiName, type: 'text' },
];
export default class BookList extends LightningElement {
    searchTerm='';
    books;
    libraryId='';
  @track  value='';
  @track optionsArray=[];
    loaded = false;
    librarySelected=false;


	@wire(getAllLibraries)
    wiredLibraries({data,error}){
        if (data) {
            for(var key in data){
                console.log('this.obj '+JSON.stringify({label:key, value:data[key].Name}))
                this.optionsArray.push({label:data[key].Name, value:data[key].Id});
            } 
            this.loaded = true;
        } else if (error) {
        console.log(error);
        }
   }
/*
connectedCallback(){
    this.options();
}

    loadLibraries(){
    getAllLibraries().then(result => {
        dataSent=result;
        for (let i=0;i<dataSent.length;i++){
            optionsArray.push('{label:"'+dataSent[i].Name+'",value:"'+dataSent[i].Id+'"}');
        }
    })
    .catch(error => {
        this.error = error;
    });
}loadBooks(x){
    console.log('I tried');
    getAllBooks('a').then(result => {
        console.log('I got'+result);
    })
    .catch(error => {
        console.log('I didnt get');
        console.log(error);
        this.error = error;
    });
}
*/

handleChange(event){
    this.librarySelected=true;
    this.libraryId=event.detail.value;
    this.value=event.detail.value;
}

columns = COLUMNS;
@wire(getAllBooks, {libraryId: '$libraryId'})
books;

userColumns=USER_COLUMNS;
@wire(getAllUsers,{libraryId: '$libraryId'})
users;


@wire(searchables, {searchTerm: '$searchTerm',libraryId: '$libraryId'})
wiredResults({ error, data }) {
        if (data) {
            this.books=data.books;
            console.log(this.books);
            this.users = data.users;
        } else if (error) {
            this.error = error;
        }
    }
/* this.books=data.books;
this.users=data.users;
books;
*/
handleSearchTermChange(event) {
  //  window.clearTimeout(this.delayTimeout);
 // console.log("event"+event.target.value);
     this.searchTerm = event.target.value;
  //  this.delayTimeout = setTimeout(() => {
 //      this.searchTerm = searchTerm;
  //  }, 300);
}





}