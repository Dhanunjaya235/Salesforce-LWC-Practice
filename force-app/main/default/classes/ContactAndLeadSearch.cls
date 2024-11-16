public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String searchTerm) {
        List<List<SObject>> searchResults = [FIND :searchTerm IN NAME FIELDS RETURNING 
                                             Contact(Id, FirstName, LastName), 
                                             Lead(Id, FirstName, LastName)];
        return searchResults;
    }
}