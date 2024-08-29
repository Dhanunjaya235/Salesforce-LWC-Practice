import { LightningElement, wire } from 'lwc';
// import {} from '@salesforce/apex/'
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import NAME from '@salesforce/schema/User.Name';
import EMAIL_FIELD from '@salesforce/schema/User.Email';
export default class TestLightningWebComponent extends LightningElement {
    userId = Id;

    @wire(getRecord, {
        recordId: '$userId',
        fields: [NAME],
        optionalFields: [EMAIL_FIELD]
    })
    record;

    get recordStr() {
        console.log(this.record)
        return this.record ? JSON.stringify(this.record.data, null, 2) : '';
    }
}