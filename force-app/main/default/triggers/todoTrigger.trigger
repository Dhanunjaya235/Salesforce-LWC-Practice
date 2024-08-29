trigger todoTrigger on ToDo__c(
    before insert, before update 
){
    if (Trigger.isBefore){
        if (Trigger.isUpdate){
            TodoTriggerHandler.checkWhetherAFieldIsChangedOrNot(Trigger.new, Trigger.oldMap);
        }
        if (Trigger.isInsert || Trigger.isUpdate){
            TodoTriggerHandler.validateDueDate(Trigger.new );
        }
    }
}