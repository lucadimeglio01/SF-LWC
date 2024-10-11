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
public class TestClass {

    // Metodo per inserimento dati mock
    @TestSetup
    static void mockData(){
        Contact contact1 = new Contact(FirstName = 'Luca', LastName = 'Di Meglio', Email = 'lucadime11@gmail.com', Phone = '3315651295');
        Contact contact2 = new Contact(FirstName = 'Luchino', LastName = 'Di Meglio', Email = 'lucadime12@gmail.com');
        Contact contact3 = new Contact(FirstName = 'Luchetto', LastName = 'Di Meglio', Email = 'lucadime13@gmail.com');

        insert contact1;
        insert contact2;
        insert contact3;
    }



    // Metodo di test per verificare che la ricerca restituisca risultati corretti
    @isTest
    static void testSearchContact() {
        
        // 1. Invocazione del metodo (verificando risultato)
        // 2. Verifica della ricerca (System.assertEquals)
        // 3. Verifica nomi dei contatti (System.assert + (System.debug)) tramite un Set
        
        List<Contact> results = ContactController2.searchContact('Luc');
        
        System.assertEquals(3, results.size(), 'La ricerca dovrebbe restituire 3 contatti');

        Set<String> contactNames = new Set<String>{'Luca Di Meglio', 'Luchino Di Meglio', 'Luchetto Di Meglio'};
        System.debug('Risultato ricerca "Luc": ');
        for (Contact c : results){
            System.assert(contactNames.contains(c.Name), 'Il contatto trovato non è quello atteso: ' + c.Name);
            System.debug(c.Name);
        }
    }

    

    // Metodo di test per verificare che la ricerca di un contatto inesistente funzioni correttamente
    @isTest
    static void testSearchContact2(){
        
        List<Contact> results = ContactController2.searchContact('Nome a cazzo');

        System.assertEquals(0,results.size(), 'La ricerca dovrebbe restituire 0 contatti');

        System.debug('Risultato ricerca "Nome a cazzo": ');
        Integer contatore = 0;
        for (Contact c : results){
            if (c.Name != null){
                System.debug(c.Name);
            } else {
                contatore ++;
            }
        }
        if (contatore == 3 ){
            System.debug('La ricerca ha fornito 0 risultati.');
        }
    }



    // Metodo di test per verificare che una stringa vuota fornisca i risultati
    @isTest
    static void testSearchContact3(){

        List<Contact> results = ContactController2.searchContact('');

        System.assertEquals(3,results.size(),'La ricerca con stringa vuota dovrebbe restituire tutti i contatti');
        System.debug('Risultato ricerca con stringa vuota: ');
        for (Contact c : results){
            System.debug(c.Name);
        }
    }
}