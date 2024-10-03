import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import searchContact from '@salesforce/apex/ContactController2.searchContact';
// mi permette di navigare tra le pagine (per arrivare al contatto selezionato)

export default class LwContact2 extends NavigationMixin (LightningElement) {
    contactName = '';
    contacts = [];

    // gestore input
    inputHandle(event){
        this.contactName = event.target.value;

        // check sulle dimensioni della stringa
        if (this.contactName.length > 0){
            this.searchContacts();
        } else {
            this.contacts = [];
        }
    }

    // invoca la query della classe apex
    searchContacts(){
        searchContact({ contactName : this.contactName})
        // .then per stabilire cosa deve fare il metodo quando la ricerca dei contatti ha successo
        // assegno il risultato (result) alla variabile contacts (la lista)
        .then(result => 
            { this.contacts = result; })
        // .catch per gestire l'eventuale fallimento ricerca contatti
        // contacts avrà lista vuota
        .catch(error => 
            { this.contacts = [];
                console.error('Error during contact research', error);
            });
    }

    // gestore click contatto
    contactHandle(event){
        // dal data-id dell'HTML recupero l'id del contatto
        const contactId = event.target.dataset.id;

        // navigazione alla pagina dei dettagli del contatto 
        this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
            attributes: {
                recordId: contactId, // id del Contatto
                objectApiName: 'Contact', // oggetto su Salesforce 
                actionName: 'view' // azione = visualizzare i dettagli del record
            }
        });
    }

}