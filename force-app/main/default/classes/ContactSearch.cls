public with sharing class ContactSearch {

    public static List<Contact> searchForContacts(String lastName, String postalCode){
        return [SELECT Id, Name FROM Contact WHERE LastName=:lastName and MailingPostalCode=:postalCode];
    }
}