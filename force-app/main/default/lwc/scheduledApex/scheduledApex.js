import { LightningElement, track } from 'lwc';
import executeScheduledExample from '@salesforce/apex/AsynchronousApexExecutor.executeScheduledExample';

export default class ScheduledApex extends LightningElement {

    @track scheduledJobId;
    @track scheduledjobName = '';
    @track scheduledjobDate = '';
    @track scheduledjobTime = '';

    @track toastlabel = '';
    @track toastvariant = '';
    @track toastmessage = '';


    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    get isFormFilled() {
        return !(this.scheduledjobName && this.scheduledjobDate && this.scheduledjobTime);
    }

    get isDateChosen() {
        return !(Boolean(this.scheduledjobDate));
    }
    get currentDate() {
        const today = new Date();
        return today.toISOString().split('T')[0];
    }

    get currentTime() {
        const now = new Date();
        return now.toTimeString().split(' ')[0].substring(0, 5); // Format as HH:MM
    }

    get minTime() {
        if (this.scheduledjobDate === this.currentDate) {
            return this.currentTime;
        }
        return '00:00'; // No restriction for future dates
    }
    async handleScheduledApex() {
        console.log(this.scheduledjobName);
        console.log(this.scheduledjobDate);
        console.log(this.scheduledjobTime);

        const [hours, minutes] = this.scheduledjobTime.split(':');

        const datechosen = new Date(this.scheduledjobDate);

        const day = datechosen.getDate();
        const month = datechosen.getMonth() + 1;
        const year = datechosen.getFullYear();

        console.log(minutes, hours, day, month, year)
        const crobJobExpression = `0 ${minutes === '00' ? 0 : minutes} ${hours === '00' ? 0 : hours} ${day} ${month} ? ${year}`

        console.log(crobJobExpression, 'crobJobExpression')

        executeScheduledExample({ cronExp: crobJobExpression, jobName: this.scheduledjobName })
            .then((response) => {
                console.log(response, 'response')
                this.scheduledJobId = response;
                this.toastvariant = 'success';
                this.toastlabel = 'Scheduled Job';
                this.toastmessage = `Scheduled Apex Job ${this.scheduledjobName} With Job ID ${this.scheduledJobId} Successfully`;
            }).catch((error) => {
                console.log(error);
                this.toastvariant = 'error';
                this.toastlabel = 'Error Occured';
                this.toastmessage = error.body.message;
            }).finally(() => {
                setTimeout(() => {
                    this.toastvariant = '';
                    this.toastlabel = '';
                    this.toastmessage = '';
                }, 100)
            })

    }

}