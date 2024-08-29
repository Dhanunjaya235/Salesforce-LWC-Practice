@RestResource(urlMapping = '/Todos/*')
global with sharing class TodoRestResource{
    public TodoRestResource(){
    }

    @HttpGet
    global static void getTodos(){

        RestRequest rr = RestContext.request;
        RestResponse res = RestContext.response;

        String todoId = rr.params.get('id');
        System.debug(todoId + ' params');
        String todoIdUrl = rr.requestURI.substring(rr.requestURI.lastIndexOf('/') + 1);
        System.debug(todoIdUrl + ' url part');
        List<Todo__c> result;

        try{
            if (todoId != null && todoId != ''){
                ToDo__c todo = TodosController.getTodoByID(todoId);
                result = new List<ToDo__c>{ todo };
            } else if (todoIdUrl != null && todoIdUrl != '' && todoIdUrl != 'Todos'){
                ToDo__c todo = TodosController.getTodoByID(todoIdUrl);
                result = new List<ToDo__c>{ todo };
            } else{
                result = TodosController.getTodos();
            }

            res.statuscode = 200;
            res.addHeader('Content-Type', 'application/json');
            res.responseBody = Blob.valueOf(JSON.serialize(result));
            // return;
        } catch (Exception e){
            System.debug('Error deserializing request: ' + e.getMessage());
            res.addHeader('Content-Type', 'application/json');
            res.statusCode = 400;
            res.responseBody = Blob.valueOf('{"error": "' + e.getMessage().replace('"', '\\"') + '"}');
            return;
        }
    }

    @HttpPost
    global static void addTodo(){
        RestRequest req = RestContext.request;
        RestResponse rr = RestContext.response;
        String jsonString = req.requestBody.toString();

        Todo data;
        try{
            data = (Todo)JSON.deserialize(jsonString, Todo.class);
            System.debug('Deserialized data: ' + data);
        } catch (Exception e){
            System.debug('Error deserializing request: ' + e.getMessage());
            rr.addHeader('Content-Type', 'application/json');
            rr.statusCode = 400;
            rr.responseBody = Blob.valueOf('{"error": "Invalid request body"}');
            return;
        }

        try{
            ToDo__c result = TodosController.saveTodo(data.title, data.description, data.status, data.dueDate, false);
            rr.addHeader('Content-Type', 'application/json');
            rr.statusCode = 201; // Created
            rr.responseBody = Blob.valueOf(JSON.serialize(result));
        } catch (Exception e){
            System.debug('Exception in saving Todo: ' + e.getMessage());
            rr.addHeader('Content-Type', 'application/json');
            rr.statusCode = 400;
            rr.responseBody = Blob.valueOf('{"error": "' + e.getMessage().replace('"', '\\"') + '"}');
        }
    }

    global class Todo{
        public String title;
        public String status;
        public String description;
        public Date dueDate;

    }

}