public with sharing class ContactController3 {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsBornAfter(Date birthDate) {

        return [SELECT FirstName, LastName, Email
                FROM Contact
                WHERE BirthDate > :birthDate
                WITH SECURITY_ENFORCED];
    }
}
