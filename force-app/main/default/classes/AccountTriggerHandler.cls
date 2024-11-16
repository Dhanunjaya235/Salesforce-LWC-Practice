public with sharing class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accounts){
        for(Account acc:accounts){
            if(acc.ShippingState != acc.BillingState){
                acc.ShippingState = acc.BillingState;
            }
        }
    }
    
    public static void AddressMatch(List<Account> accounts){
        for(Account acc:accounts){
            if(acc.Match_Billing_Address__c == True){
                acc.ShippingPostalCode=acc.BillingPostalCode;
            }
        }
    }
}