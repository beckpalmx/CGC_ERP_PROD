
import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.cgc.Util.UtiDatabase;

/* 

 import java.sql.*;
 */
public class Test_Carbon_IO {

    public static void main(String args[]) {

        Show_Data();

        /*         
         Timer myTimer;
         myTimer = new Timer();
         myTimer.schedule(new TimerTask() {
         @Override
         public void run() {

         Encode();

         }
         }, 0, 10000);
         */
    }

    private static void Show_Data() {
        try {
            DBConnect dbConnect = new DBConnect();
            UtiDatabase DBUtil = new UtiDatabase();
            ResultSet rs;
            ResultSet rs1;
            Connection con = dbConnect.openTestConnection();
            Connection con1 = dbConnect.openTestConnection();
            String Select_Data = "select month,year,burn_no,sum(to_number(weight,'9999999.99')) as weight from vd_carbon_burn_in_detail "
                    + "group by month,year,burn_no order by month,year,burn_no";
            PreparedStatement p;
            PreparedStatement p1;
            p = con.prepareStatement(Select_Data);
            System.out.println("Select_Data = " + Select_Data);
            rs = p.executeQuery();
            int T = 1;
            while (rs.next()) {

                System.out.println("month = " + rs.getString("month"));
                System.out.println("burn_no = " + rs.getString("burn_no"));

                System.out.println("year = " + rs.getString("year"));
                System.out.println("weight = " + rs.getString("weight"));

                String SQL_Find = "select count(runno) as num from t_transaction_carbon_io_ratio where doc_month = '"
                        + rs.getString("month") + "' and doc_year = '" + rs.getString("year") + "'";
                System.out.println("1 SQL_Find = " + SQL_Find);

               // int rec_count = DBUtil.numRowdatabase(SQL_Find);
                //System.out.println("rec_count = " + rec_count);
                
                T++;
                System.out.println("rec_count = " + T);
            }

        } catch (Exception ex) {
            System.out.println("ERROR = " + ex);
        }
    }
}
