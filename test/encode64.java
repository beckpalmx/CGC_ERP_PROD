
import org.apache.commons.codec.binary.Base64;

public class encode64 {

    public static void main(String args[]) {
        String UserID = "cgc", Password = "systemadmin";

        encode64(UserID, Password);

    }

    private static void encode64(String UserID, String Password) {
        try {

            byte[] user_encode = Base64.encodeBase64(UserID.getBytes());
            byte[] pass_encode = Base64.encodeBase64(Password.getBytes());

            System.out.println("username_encode = " + UserID + " | " + new String(user_encode));
            System.out.println("password_encode = " + Password + " | " + new String(pass_encode));

        } catch (Exception ex) {
            System.out.println("ERROR");
        }
    }
}
