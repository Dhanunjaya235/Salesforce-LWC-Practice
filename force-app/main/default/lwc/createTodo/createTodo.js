import { api, LightningElement, track, wire } from 'lwc';
import saveTodo from '@salesforce/apex/TodosController.saveTodo';
import updateTodo from '@salesforce/apex/TodosController.updateTodo';
import Toast from 'lightning/toast';
import ToastContainer from 'lightning/toastContainer';
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import TODO_SELECTED_CHANNEL from '@salesforce/messageChannel/Todo_Selected__c';
import { APPLICATION_SCOPE, MessageContext, subscribe } from 'lightning/messageService';
const FIELDS = [
    'Todo__c.Name',
    'Todo__c.Description__c',
    'Todo__c.Due_Date__c',
    'Todo__c.Status__c',
    'Todo__c.Title__c'
];

export default class CreateTodo extends NavigationMixin(LightningElement) {
    @track title;
    @track description;
    @track dueDate;
    @track status;


    @api todoName;
    @api todoId;

    subscription = null;


    @wire(CurrentPageReference)
    setCurrentPageReference(pageRef) {
        console.log(pageRef.state)
        // this.todoName = pageRef.state.c__todoName;
        // this.todoId = pageRef.state.c__todoId;
        // console.log(this.todoName, "this.todoname");
        // console.log(this.todoId, "this.todoId");
        // if (this.todoName) {
        //     getTodoByName({ name: this.todoName })
        //         .then((data) => {
        //             console.log(data, "getTodoByName");
        //             this.title = data.Title__c;
        //             this.description = data.Description__c;
        //             this.dueDate = data.Due_Date__c;
        //             this.status = data.Status__c;
        //         }).catch((error) => {
        //             console.log(error)
        //         })
        // }
    }


    @wire(getRecord, { recordId: '$todoId', fields: FIELDS })
    wiredTodo({ error, data }) {
        if (data) {
            this.title = getFieldValue(data, FIELDS[4]);
            this.description = getFieldValue(data, FIELDS[1]);
            this.dueDate = getFieldValue(data, FIELDS[2]);
            this.status = getFieldValue(data, FIELDS[3]);

        } else if (error) {
            console.error('Error fetching todo record:', error);
        }
    };

    @wire(MessageContext) messageContext;

    get isFormFilled() {
        return !(this.title && this.description && this.dueDate && this.status);
    }


    connectedCallback() {
        this.subcribeToMessageChannel();
        const toastContainer = ToastContainer.instance();
        toastContainer.maxShown = 5;
        toastContainer.toastPosition = 'top-right';
    }

    subcribeToMessageChannel() {
        this.subscription = subscribe(this.messageContext, TODO_SELECTED_CHANNEL, (message) => this.handleMessage(message), { scope: APPLICATION_SCOPE })
    }

    handleMessage(message) {
        this.todoName = message.todoName;
        this.todoId = message.todoId;
    }

    get cardTitle() {
        return this.todoName ? 'Edit Todo' : 'Create Todo';
    }

    get buttonLabel() {
        return this.todoName ? 'Update' : 'Create';
    }

    statusOptions = [
        { label: 'Not Started', value: 'Not Started' },
        { label: 'In Progress', value: 'In-Progress' },
        { label: 'Pending', value: 'Pending' },
        { label: 'Completed', value: 'Completed' }

    ];

    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleReset() {
        this.title = '';
        this.description = '';
        this.dueDate = '';
        this.status = '';
    }
    navigateToTodosPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Todos'
            }
        })
    }
    handleSave() {
        if (this.todoName) {
            updateTodo({
                title: this.title,
                description: this.description,
                status: this.status,
                dueDate: this.dueDate,
                name: this.todoName,
                isAura: true
            })
                .then((data) => {
                    Toast.show({
                        label: 'Success',
                        message: 'Updated ToDo Successfully',
                        mode: 'dismissible',
                        variant: 'success'
                    })
                    Toast.show({
                        label: 'Info',
                        message: 'Navigating To Todos Page',
                        mode: 'dismissible',
                        variant: 'info'
                    }, this)
                    this.navigateToTodosPage();
                }).catch((error) => {
                    console.log(error);
                    Toast.show({
                        label: 'Error',
                        message: error.body.message.split(',').pop().trim(),
                        mode: 'dismissible',
                        variant: 'error'
                    })
                })
        } else {
            saveTodo({
                title: this.title,
                description: this.description,
                status: this.status,
                dueDate: this.dueDate,
                isAura: true
            })
                .then((data) => {
                    Toast.show({
                        label: 'Success',
                        message: 'Created ToDo Successfully',
                        mode: 'dismissable',
                        variant: 'success'
                    })
                    Toast.show({
                        label: 'Info',
                        message: 'Navigating To Todos Page',
                        mode: 'dismissible',
                        variant: 'info'
                    })
                    this.navigateToTodosPage();
                }).catch((error) => {
                    console.log(error.body.message);
                    Toast.show({
                        label: 'Error',
                        message: error.body.message.split(',').pop().trim(),
                        mode: 'dismissible',
                        variant: 'error'
                    })
                })
        }
    }

}