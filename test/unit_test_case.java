
import javax.naming.*;
import javax.sql.*;
import java.sql.*;
import javax.naming.InitialContext;

public class unit_test_case {

    public static void main(String[] args) {
        try {

            String foo = "Not Connected";
            int bar = -1;

            String product_id = "";
            String name_t = "";

            Context ctx = new InitialContext();
            if (ctx == null) {
                throw new Exception("Boom - No Context");
            }

            DataSource ds
                    = (DataSource) ctx.lookup(
                            "java:comp/env/jdbc/CGCDB_ERP_DB");

            if (ds != null) {
                Connection conn = ds.getConnection();

                if (conn != null) {
                    foo = "Got Connection " + conn.toString();
                    Statement stmt = conn.createStatement();
                    ResultSet rst
                            = stmt.executeQuery("select * from m_fuel");
                    if (rst.next()) {
                        product_id = rst.getString("product_id");
                        name_t = rst.getString("name_t");
                        System.out.println(product_id + " " + name_t);
                    }
                    conn.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
    }
}
