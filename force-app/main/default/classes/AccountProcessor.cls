public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        for (AggregateResult result : [
            SELECT AccountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            contactCountMap.put((Id)result.get('AccountId'), (Integer)result.get('contactCount'));
        }

        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : contactCountMap.keySet()) {
            accountsToUpdate.add(new Account(
                Id = accountId,
                Number_Of_Contacts__c = contactCountMap.get(accountId)
            ));
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}