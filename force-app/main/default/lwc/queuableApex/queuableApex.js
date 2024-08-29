import { LightningElement, track } from 'lwc';
import executeQueuableExample from '@salesforce/apex/AsynchronousApexExecutor.executeQueuableExample';

export default class QueuableApex extends LightningElement {

    @track queuableJobId;
    async handleQueuableApex() {
        console.log("handleQueuableApex")
        this.queuableJobId = await executeQueuableExample();
        console.log(this.queuableJobId, "Queuable Apex Example Job ID");
    }
}