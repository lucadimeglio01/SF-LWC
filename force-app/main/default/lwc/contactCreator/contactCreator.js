/*
Use lightning-record-form to create a Lightning web component that allows you to create contact records.

Tip: Remember that JavaScript is a case-sensitive programming language. Be careful to use uppercase and lowercase letters correctly.

Create a Lightning web component:
Name: contactCreator
Base component: lightning-record-form
- Fields to include: FirstName, LastName, Email

Implement an event handler:
Name: handleSuccess
Event: onsuccess
Action: Show the Id of the created contact in a toast message
Add the component to the Working with Data page

Use the contactCreator component to create a contact:
First name: Lisa
Last name: Jones
Email: ljones@developer.com
*/

import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

export default class ContactCreator extends LightningElement {
    objectApiName = CONTACT_OBJECT;
    fields = [NAME_FIELD, LASTNAME_FIELD, EMAIL_FIELD];
    handleSuccess(event){
        const toastEvent = new ShowToastEvent({
            title: "Account created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}