/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TodosControllerTests {

    @TestSetup
    static void todosData(){
        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(new ToDo__c(Title__c='Title 1', Status__c='Pending', Description__c='Test description', Due_Date__c=System.today()));
        todos.add(new ToDo__c(Title__c='Title 2', Status__c='Pending', Description__c='Another test description', Due_Date__c=System.today()));

        insert todos;
    }

    @isTest
    static void testGetTodosWhenNoTodos() {
        // TO DO: implement unit test
        List<ToDo__c> todos = TodosController.getTodos();

        System.assertEquals(2, todos.size(), 'Expected 2 todos as we have adedd two todos in TestData');
    }

    @isTest
    static void testGetTodosWhenHavingTodos(){

        List<ToDo__c> allTodos = TodosController.getTodos();

        System.assertEquals(2, allTodos.size(), 'Expected 2 todos');
        System.assertEquals('Title 1', allTodos[0].get('Title__c'), 'Expected todo title as Title 1');
    }
    @isTest
    static void testGetTodoByName(){
        List<ToDo__c> allTodos = TodosController.getTodos();

        String todoName = allTodos[0].Name;
        ToDo__c todoByName = TodosController.getTodoByName(todoName);

        System.assertEquals(todoName, todoByName.get('Name'), 'Expected name of the inserted todo to be same');
    }
}