import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
// Import Bear object fields
import LIBRARY_OF_BOOK_FIELD from '@salesforce/schema/Book__c.Library__c';
import GENRE_FIELD from '@salesforce/schema/Book__c.Genre__c';
import AVAILABLE_COPIES_FIELD from '@salesforce/schema/Book__c.Available_Copies__c';
import TOTAL_COPIES_FIELD from '@salesforce/schema/Book__c.Total_Number_of_copies__c';
const bookFields = [LIBRARY_OF_BOOK_FIELD,GENRE_FIELD,AVAILABLE_COPIES_FIELD,TOTAL_COPIES_FIELD];
export default class BookTable extends LightningElement {
	@api recordId;
	@wire(getRecord, { recordId: '$recordId', fields: bookFields })
  book;
  get libraryId() {
    return getFieldValue(this.book.data, LIBRARY_OF_BOOK_FIELD);
}
}