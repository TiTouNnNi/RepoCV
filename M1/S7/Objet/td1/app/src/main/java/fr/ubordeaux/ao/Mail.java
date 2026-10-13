package fr.ubordeaux.ao;

public class Mail {
    private String mail;

    public Mail(String mail) {
        if (!isMailValid(mail)) {
            throw new IllegalArgumentException("Paramètre invalide");
        }
        this.mail = mail;
    }

    public String getMail() {
        return mail;
    }

    private boolean isMailValid(String mail){
       return mail.matches("[a-zA-Z]+@[a-zA-Z]+\\.[a-zA-Z]+");
    }

    @Override
    public String toString() {
        return "Mail [mail=" + mail + "]";
    }

}