package fr.ubordeaux.ao;

import java.util.HashSet;
import java.util.Set;

public class Contact {
    private static int nextId = 1;
    private int id;
    private String firstName;
    private String secondName;
    private Address address;
    private Set<Mail> mails;
    private Set<PhoneNumber> phones;

    public Contact(String firstName, String secondName, Address address) {
        this.id = Contact.nextId++;

        if (!isNameValid(firstName)) {
            throw new IllegalArgumentException("Paramètre invalide");
        }
        this.firstName = firstName;

        if (!isNameValid(secondName)) {
            throw new IllegalArgumentException("Paramètre invalide");
        }
        this.secondName = secondName;

        this.address = address;

        mails = new HashSet<Mail>();

        phones = new HashSet<PhoneNumber>();
    }

    public int id() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void changeAddress(Address newAddress) {
        this.address = newAddress;
    }

    public Address getAddress() {
        return address;
    }

    public void addMail(Mail mail) {
        if(!mails.contains(mail))
            mails.add(mail);
        else
            throw new IllegalArgumentException("Email existant");
    }

    public void removeMail(Mail mail) {
        mails.remove(mail);
    }

    public Set<Mail> getMails() {
        Set<Mail> mailz = new HashSet<Mail>();
        mailz.addAll(mails);
        return mailz;
    }

    public void addPhoneNumber(PhoneNumber phone) {
        phones.add(phone);
    }

    public void removePhoneNumber(PhoneNumber phone) {
        phones.remove(phone);
    }

    public Set<PhoneNumber> getPhoneNumbers() {
        Set<PhoneNumber> phonez = new HashSet<PhoneNumber>();
        phonez.addAll(phones);
        return phonez;
    }

    private boolean isNameValid(String str){
        return str.length() <= 64 ;
    }

    @Override
    public String toString() {
        return "Contact: [id=" + id + ", firstName=" + firstName + ", secondName=" + secondName + ", address=" + address
                + ", mails=" + mails + ", phones=" + phones + "]";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Contact other = (Contact) obj;
        return this.id == other.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
    /* hashCode renvoie un int différent pour chaque valeur
     * equals check par référence ( == ) et donc a rédefinir pour la plupart des objets
     */
}