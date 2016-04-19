
import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.apache.commons.codec.binary.Base64;



/* 

 import java.sql.*;
 */
public class pw_encode64_util {

    public static void main(String args[]) {
        Encode();
        /*
         Timer myTimer;
         myTimer = new Timer();
         myTimer.schedule(new TimerTask() {
         @Override
         public void run() {

         Encode();

         }
         }, 0, 10);
         */
    }

    private static void Encode() {
        try {
            DBConnect dbConnect = new DBConnect();
            ResultSet rs;
            Connection con = dbConnect.openTestConnection();
            String Select_UserAcc = "select runno,emp_id,username,password from muser_account limit 1";
            String Update_UserAcc = "";
            PreparedStatement p;
            PreparedStatement p1;
            String user = "Y2dj", password = "c3lzdGVtYWRtaW4=";
            p = con.prepareStatement(Select_UserAcc);
            System.out.println("Select_UserAcc = " + Select_UserAcc);
            rs = p.executeQuery();

            String Enter_Text_Encode = "-";

            byte[] text_encode = Base64.encodeBase64(Enter_Text_Encode.getBytes());

            //System.out.println("text_encode = " + new String(text_encode));
            while (rs.next()) {

                //byte[] user_encode = Base64.encodeBase64(rs.getString("username").getBytes());
                //byte[] pass_encode = Base64.encodeBase64(rs.getString("password").getBytes());
                byte[] user_encode = Base64.decodeBase64(user.getBytes());
                byte[] pass_encode = Base64.decodeBase64(password.getBytes());

                //System.out.println("username = " + rs.getString("username") + " | " + new String(user_encode));
                //System.out.println(rs.getString("username"));
                //System.out.println(rs.getString("runno"));
                System.out.println(new String(user_encode) + " | " + new String(pass_encode));
                //System.out.println(rs.getString("password") + " | " + new String(pass_encode));

            }

        } catch (Exception ex) {
            System.out.println("ERROR");
        }

    }

}
