package config;

import java.util.Random;

public class MailConfig {

    public static final String HOST_NAME = "smtp.gmail.com";
    public static final int TSL_PORT = 587;
    public static final String FROM_EMAIL = "breakmmo@gmail.com";
    public static final String FROM_PASSWORD = "twkzrmndkpzrxmyq";
    public static final String SUBJECT = "Reset password by G4";

    //Generate random password to send
    public static String generatePassword() {
        int leftLim = 33;
        int rightLim = 125;
        int passwordLength = 8;

        Random random = new Random();
        StringBuilder result = new StringBuilder(passwordLength);

        for (int i = 0; i < passwordLength; i++) {
            int randomChar = leftLim + (int) (random.nextFloat() * (rightLim - leftLim + 1));
            result.append((char) randomChar);
        }

        return result.toString();
    }

}
