package fr.ubordeaux.ao;

public class PhoneNumber {
    private int number;

    public PhoneNumber(int number) {
        if (!isNumberValid(number)) {
            throw new IllegalArgumentException("Paramètre invalide");
        }
        this.number = number;
    }

    public int getPhoneNumber() {
        return number;
    }

    private boolean isNumberValid(int num){
        return String.valueOf(num).matches("0[0-9]{9}") || 
        String.valueOf(num).matches("\\+33[0-9]{9}");
    }

}