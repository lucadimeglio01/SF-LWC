public with sharing class ContactController2 {
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContact(String contactName){
        return [ SELECT Name FROM Contact WHERE Name LIKE : ('%' + contactName + '%') ];
    }
}