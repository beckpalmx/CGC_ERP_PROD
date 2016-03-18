
import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/* 

 import java.sql.*;
 */
public class Regen_Line_No {

    public static void main(String args[]) {
        Run_Job();
    }

    private static void Run_Job() {
        try {
            DBConnect dbConnect = new DBConnect();
            ResultSet rs, rs1;
            String date_from = "20-02-2559";
            String date_to = "07-03-2559";

            Connection con = dbConnect.openTestConnection();
            String Select_Data = "select * from d_carbon_friction_header "
                    + " where to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') and to_date(format_date('" + date_to + "'),'YYYY-MM-DD')"
                    + " order by doc_id ";

            String Select_Detail_Data ;

            PreparedStatement p, p1;

            p = con.prepareStatement(Select_Data);

            System.out.println("Select_Data = " + Select_Data);

            rs = p.executeQuery();

            while (rs.next()) {

                int loop = 1;

                //System.out.println("Doc ID: " + rs.getString("doc_id") + " | " + rs.getString("doc_date"));
                Select_Detail_Data = "select * from d_carbon_friction_receive_detail_2 "
                        + " where doc_id = '" + rs.getString("doc_id") + "'" + " order by to_number(line_no,'999') ";
                p1 = con.prepareStatement(Select_Detail_Data);
                rs1 = p1.executeQuery();
                while (rs1.next()) {
                    System.out.println("Doc ID : " + rs1.getString("doc_id") + "loop : " + loop + " , " + " , " + rs1.getString("line_no") + " , " + rs1.getString("bag_no"));
                    loop++;
                }

            }

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

}
