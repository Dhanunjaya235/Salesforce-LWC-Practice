import { api, LightningElement } from 'lwc';
import Toast from 'lightning/toast';
import ToastContainer from 'lightning/toastContainer';

export default class ToastWrapper extends LightningElement {
    @api label;
    @api message;
    @api variant;
    @api mode;

    connectedCallback() {
        const toastContainer = ToastContainer.instance();
        toastContainer.maxShown = 5;
        toastContainer.toastPosition = 'top-right';
    }

    renderedCallback() {
        console.log("renderedcallback in toast wrapper")
        console.log(this.mode, this.label, this.message, this.variant, 'values')
        if (this.label && this.message && this.mode && this.variant) {
            console.log('All values are available')
            Toast.show({
                label: this.label,
                message: this.message,
                mode: this.mode,
                variant: this.variant
            })
        }
    }
}