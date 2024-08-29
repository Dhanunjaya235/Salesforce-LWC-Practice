import { LightningElement } from 'lwc';
import executeFutureMethodExample2 from '@salesforce/apex/AsynchronousApexExecutor.executeFutureMethodExample2';
import executeFutureMethodExample1 from '@salesforce/apex/AsynchronousApexExecutor.executeFutureMethodExample1';
export default class FutureApex extends LightningElement {
    handleFuturemethod() {
        console.log("handleFuturemethod")
        executeFutureMethodExample1();
        executeFutureMethodExample2();
    }
}