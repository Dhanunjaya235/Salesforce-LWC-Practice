public with sharing class AccountUtils {
    public AccountUtils() {

    }

    public static List<Account> accountsByState(String BillingState){
        return [SELECT Id,Name 
                FROM Account
                WHERE BillingState = :BillingState ];
    }
}