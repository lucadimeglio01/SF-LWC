/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class ContactController2Test {

    // Il metodo @testSetup viene usato per preparare i dati di test una volta e riutilizzarli in più metodi di test
    @testSetup
    static void setupTestData() {
        // Creiamo dei contatti di esempio
        Contact contact1 = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'john.doe@example.com');
        Contact contact2 = new Contact(FirstName = 'Jane', LastName = 'Doe', Email = 'jane.doe@example.com');
        Contact contact3 = new Contact(FirstName = 'Johnny', LastName = 'Smith', Email = 'johnny.smith@example.com');
        Contact contact4 = new Contact(FirstName = 'Juan', LastName = 'Pepp', Email = 'juan.pepp@example.com');
        
        // Inseriamo i contatti nel database
        insert contact1;
        insert contact2;
        insert contact3;
        insert contact4;
    }

    // Metodo di test per verificare che la ricerca restituisca risultati corretti
    @isTest
    static void testSearchContact() {
        // 1. Invocare il metodo searchContact con una stringa di ricerca che dovrebbe restituire risultati
        List<Contact> results = ContactController2.searchContact('Doe');
        
        // 2. Verificare che la lista contenga i contatti previsti (dovrebbe contenere 2 contatti: John e Jane Doe)
        System.assertEquals(2, results.size(), 'La ricerca dovrebbe restituire 2 contatti');

        // 3. Assicurarsi che i nomi dei contatti siano corretti
        Set<String> expectedContactNames = new Set<String>{'John Doe', 'Jane Doe'};
        System.debug('Contatti "Doe": ');
        for (Contact c : results) {
            System.assert(expectedContactNames.contains(c.Name), 'Il contatto trovato non è quello atteso: ' + c.Name);
            System.debug(c.Name);
        }
    }


    // Metodo di test per verificare che una ricerca senza risultati funzioni correttamente
    @isTest
    static void testSearchContactNoResults() {
        // Ricerca per un nome che non esiste
        List<Contact> results = ContactController2.searchContact('Nonexistent');
        
        // Verificare che la lista sia vuota
        System.assertEquals(0, results.size(), 'La ricerca dovrebbe restituire 0 contatti');
        System.debug('Lista dei Contatti: ');
        for (Contact c : results){
            System.debug(c.Name);
        }
    }

    // Metodo di test per verificare che la ricerca con una stringa vuota funzioni correttamente
    @isTest
    static void testSearchContactEmptyString() {
        // Ricerca con stringa vuota
        List<Contact> results = ContactController2.searchContact('');
        
        // Dato che la query usa il LIKE '%', una stringa vuota potrebbe restituire tutti i contatti
        // Se vuoi che restituisca 0 contatti in produzione, potresti dover gestire questo caso nel controller Apex
        // Qui ci aspettiamo che vengano restituiti tutti e 3 i contatti creati
        System.assertEquals(4, results.size(), 'La ricerca con stringa vuota dovrebbe restituire tutti i contatti');
        System.debug('Lista dei Contatti: ');
        for (Contact c : results){
            System.debug(c.Name);
        }
    }
}