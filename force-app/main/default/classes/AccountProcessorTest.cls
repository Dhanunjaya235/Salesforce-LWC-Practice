@isTest
public class AccountProcessorTest {
    @testSetup
    static void setupTestData() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        List<Contact> testContacts = new List<Contact>();
        for (Account acc : testAccounts) {
            for (Integer j = 0; j < 5; j++) {
                testContacts.add(new Contact(FirstName = 'Test', LastName = 'Contact ' + j, AccountId = acc.Id));
            }
        }
        insert testContacts;
    }

    @isTest
    static void testCountContacts() {
        List<Id> accountIds = new List<Id>();
        for (Account acc : [SELECT Id FROM Account]) {
            accountIds.add(acc.Id);
        }

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        List<Account> updatedAccounts = [SELECT Id, Number_Of_Contacts__c FROM Account];
        for (Account acc : updatedAccounts) {
            System.assertEquals(5, acc.Number_Of_Contacts__c, 'The Number_Of_Contacts__c field should be 5 for each account');
        }
    }
}