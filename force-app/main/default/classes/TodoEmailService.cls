global class TodoEmailService implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        try{
            // Parse email body to get the Todo details
            String[] emailBodyLines = email.plainTextBody.split('\n');
            Map<String, String> todoDetails = new Map<String, String>();

            for (String line : emailBodyLines){
                if (line.contains(':')){
                    String[] keyValue = line.split(':');
                    if (keyValue.size() == 2){
                        todoDetails.put(keyValue[0].trim(), keyValue[1].trim());
                    }
                }
            }

            System.debug(todoDetails.get('Title'));
            System.debug(todoDetails.get('Description'));
            System.debug(todoDetails.get('Status'));
            System.debug(todoDetails.get('DueDate'));

            // Create a new Todo record
            ToDo__C newTodo = new ToDo__c(
                Title__c = todoDetails.get('Title'), 
                Status__c = todoDetails.get('Status'), 
                Description__c = todoDetails.get('Description'), 
                Due_Date__c = Date.valueOf(todoDetails.get('DueDate'))
            );
            insert newTodo;

            result.success = true;
        } catch (Exception e){
            System.debug('exception');
            System.debug(e);
            result.success = false;
            result.message = 'Failed to create Todo: ' + e.getMessage();
        }
        System.debug(result);
        return result;
    }

}