import { LightningElement, track } from 'lwc';
import executeQueuableExample from '@salesforce/apex/AsynchronousApexExecutor.executeQueuableExample';
import executeFutureMethodExample2 from '@salesforce/apex/AsynchronousApexExecutor.executeFutureMethodExample2';
import executeFutureMethodExample1 from '@salesforce/apex/AsynchronousApexExecutor.executeFutureMethodExample1';
export default class AsynchronousApex extends LightningElement {


    handleFuturemethod() {
        console.log("handleFuturemethod")
        executeFutureMethodExample1();
        executeFutureMethodExample2();
    }


}