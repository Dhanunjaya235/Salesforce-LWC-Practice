import { LightningElement, track, wire } from 'lwc';
import getTodos from '@salesforce/apex/TodosController.getTodos';
import deleteTodo from '@salesforce/apex/TodosController.deleteTodo';
import LightningConfirm from 'lightning/confirm';
import { NavigationMixin } from 'lightning/navigation';
import TODO_SELECTED_CHANNEL from '@salesforce/messageChannel/Todo_Selected__c';
import { MessageContext, publish, releaseMessageContext, subscribe } from 'lightning/messageService';

export default class TodoList extends NavigationMixin(LightningElement) {
    todos = [];
    error;
    todoId;
    todoName;
    @wire(MessageContext) messageContext;

    async handleLoad() {
        try {
            this.todos = await getTodos();
            console.log(this.todos, 'todos')
            this.error = undefined;
        } catch (error) {
            this.todos = [];
            this.error = error;
        }
    }

    connectedCallback() {
        this.handleLoad();
    }

    async handleDelete(event) {
        this.todoId = event.target.id;
        this.todoName = event.target.name;
        const result = await LightningConfirm.open({
            message: 'Are you sure you want to delete this todo?',
            variant: 'headerless',
            label: 'this is the aria-label value'
        });
        if (result) {
            try {
                await deleteTodo({ name: this.todoName, isAura: true });
                this.handleLoad();
            } catch (error) {
                console.log(error);
            }
        } else {
            console.log('User cancelled', event.target.name);
        }
    }

    async handleEdit(event) {
        this.todoName = event.target.name;
        this.todoId = event.target.dataset.id
        const payload = {
            todoName: this.todoName,
            todoId: this.todoId
        }
        setTimeout(() => {
            publish(this.messageContext, TODO_SELECTED_CHANNEL, payload)
        }, 1000);
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Create_ToDo'
            },
            state: {
                todoname: this.todoName,
                todoId: this.todoId
            }
        })
    }

}