@isTest
public class LeadProcessorTest {
    @isTest static void testLeadProcessorBatch() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leadList.add(new Lead(FirstName = 'Test', LastName = 'Lead ' + i, Company = 'Test Company'));
        }
        insert leadList;
        Test.startTest();
        LeadProcessor batch = new LeadProcessor();
        Database.executeBatch(batch);
        Test.stopTest();
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead];
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'The LeadSource should be updated to Dreamforce');
        }
    }
}
