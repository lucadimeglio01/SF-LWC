import { LightningElement, api, wire} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAMEACC_FIELD from '@salesforce/schema/Account.Name';
import NUMBERACC_FIELD from '@salesforce/schema/Account.AccountNumber';

export default class AccountCreator extends LightningElement {

    objectApiName = ACCOUNT_OBJECT;
    fields = [NAMEACC_FIELD, NUMBERACC_FIELD];

    @api recordId;
    @wire(getRecord, { recordId: "$recordId", fields: [NAMEACC_FIELD] })
    account;

    handleSuccess(event){
        const evt = new ShowToastEvent({
            title: 'Account Created!',
            message: 'ID Account: ' + event.detail.id,
            variant: 'success'
        })
        this.dispatchEvent(evt);
    }
}