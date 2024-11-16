public with sharing class AccountHandler {
    
    public static Account insertNewAccount(String name){
        try{
            Account acc = new Account(Name=name);
            insert acc;
            return acc;
        }catch(Exception e){
            return null;
        }
    }

}