public with sharing class TodosController{
    public TodosController(){
    }

    @AuraEnabled
    public static List<ToDo__c> getTodos(){
        return [SELECT Name, Title__c, Status__c, Description__c, Due_Date__c
                FROM todo__c];
    }

    @AuraEnabled
    public static ToDo__c getTodoByName(String name){
        System.debug(name);
        return [SELECT Name, Title__c, Status__c, Description__c, Due_Date__c
                FROM todo__c
                WHERE Name = :name
                limit 1];
    }

    @AuraEnabled
    public static ToDo__c getTodoByID(String id){
        System.debug(id);
        return [SELECT Name, Title__c, Status__c, Description__c, Due_Date__c
                FROM todo__c
                WHERE ID = :id
                limit 1];
    }

    @AuraEnabled
    public static ToDo__c saveTodo(String title, String description, String status, Date dueDate, Boolean isAura){
        try{
            ToDo__c todo = new ToDo__c(
                Title__c = title, 
                Description__c = description, 
                Status__c = status, 
                Due_Date__c = dueDate
            );
            insert todo;
            return todo;
        } catch (Exception e){
            if (isAura){
                throw new AuraHandledException(e.getMessage());
            } else{
                throw new CustomTodoException(e.getMessage());
            }
        }
    }

    @AuraEnabled
    public static void deleteTodo(String name, Boolean isAura){
        try{
            delete [SELECT Id
                    from ToDo__c
                    where Name = :name];
        } catch (Exception e){
            if (isAura){
                throw new AuraHandledException(e.getMessage());
            } else{
                throw new CustomTodoException(e.getMessage());
            }
        }
    }

    @AuraEnabled
    public static void updateTodo(String title, String description, String status, Date dueDate, String name, Boolean isAura){
        try{
            ToDo__c existingTodo = getTodoByName(name);
            existingTodo.Title__c = title;
            existingTodo.Description__c = description;
            existingTodo.Status__c = status;
            existingTodo.Due_Date__c = dueDate;

            update existingTodo;
        } catch (Exception e){
            if (isAura){
                throw new AuraHandledException(e.getMessage());
            } else{
                throw new CustomTodoException(e.getMessage());
            }
        }
    }

}