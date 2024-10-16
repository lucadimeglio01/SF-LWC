import { LightningElement, wire } from 'lwc';
import FirstName_FIELD from '@salesforce/schema/Contact.FirstName';
import LastName_FIELD from '@salesforce/schema/Contact.LastName';
import Email_FIELD from '@salesforce/schema/Contact.Email';
import getContacts from '@salesforce/apex/ContactController.getContacts';
// import { reduceErrors } from 'c/ldsUtils';

const COLUMNS = [
    { label: 'Account FirstName', fieldName: FirstName_FIELD.fieldApiName, type: 'text' },
    { label: 'Account LastName', fieldName: LastName_FIELD.fieldApiName, type: 'text' },
    { label: 'Account Email', fieldName: Email_FIELD.fieldApiName, type: 'text' }
];

export default class ContactList extends LightningElement {

    columns = COLUMNS;
    @wire(getContacts)
    contacts;

    // get errors() {
    //     return (this.contacts.error) ?
    //         reduceErrors(this.contacts.error) : [];
    // }

}