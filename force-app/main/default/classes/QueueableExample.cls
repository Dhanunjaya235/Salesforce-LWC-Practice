public with sharing class QueueableExample implements Queueable {
    public QueueableExample() {

    }
    public void execute(QueueableContext context) {
        // Your asynchronous code here
        System.debug('This is running in the Queueable context.');
    }
}