public class TodoTriggerHandler{
    public static void validateDueDate(List<Todo__c> todos){
        for (Todo__c todo : todos){
            if (todo.Due_Date__c != null && todo.Due_Date__c < Date.today()){
                todo.addError('Due Date cannot be set in the past.');
            }
        }
    }

    public static void checkWhetherAFieldIsChangedOrNot(List<Todo__c> todos, Map<Id, Todo__c> oldTodoMap){
        for (Todo__c todo : todos){
            Todo__c oldTodo = oldTodoMap.get(todo.Id);
            System.debug(oldTodo);
            // Example check: Ensure the priority cannot be downgraded
            if (todo.Title__c == oldTodo.Title__c && todo.Description__c == oldTodo.Description__c && todo.Status__c == oldTodo.Status__c && todo.Due_Date__c == oldTodo.Due_Date__c){
                todo.addError('You are updating the Todo without making any changes');
            }
        }
    }

}