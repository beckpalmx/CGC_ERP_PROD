
import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author beckpalmx
 */
public class Check_Document_System {

    public static void main(String args[]) {

        Show_Data();
    }

    private static void Show_Data() {
        try {
            DBConnect dbConnect = new DBConnect();
            UtiDatabase DBUtil = new UtiDatabase();
            ResultSet rs;
            ResultSet rs1;
            String Select_Data;
            String Table_Not_Include = "'d_job_order_header','d_job_order_detail'";
            Connection con = dbConnect.openTestConnection();
            Connection con1 = dbConnect.openTestConnection();

            //Select_Data = "SELECT table_name FROM information_schema.tables "
            //+ "WHERE table_schema='public' and table_name like 'd%' AND table_name not in (" + Table_Not_Include + ")";
            
            Select_Data = " SELECT * FROM information_schema.columns "
                    + "where column_name = 'doc_date' and table_name like 'd%' AND table_name not in (" + Table_Not_Include + ")";

            PreparedStatement p;
            PreparedStatement p1;
            p = con.prepareStatement(Select_Data);
            System.out.println("Select_Data = " + Select_Data);
            rs = p.executeQuery();
            int T = 1;
            while (rs.next()) {
                System.out.println(rs.getString(3));
                T++;
                System.out.println("rec_count = " + T);
            }

        } catch (Exception ex) {
            System.out.println("ERROR = " + ex);
        }
    }

}
