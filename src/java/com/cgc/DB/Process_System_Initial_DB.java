
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

//import com.cgc.bean.DataBean_Transaction_Process;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author beck
 */
public class Process_System_Initial_DB {

    /**
     *
     * @param date_from
     * @param date_to
     * @throws Exception
     */
    public void generater_transaction_process(String date_from, String date_to) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs;
        String Table_Not_Include = "'d_job_order_header','d_job_order_detail','d_header_analyze','d_running_doc_id'";
        String SQL_Table_name;

        /*
         SQL_Table_name = " SELECT table_name FROM information_schema.tables "
         + " WHERE table_schema='public' and table_name like 'd%' "
         + " AND table_name not in ('d_job_order_header','d_job_order_detail') ";
         */
        SQL_Table_name = " SELECT table_name FROM information_schema.columns "
                + "where column_name = 'doc_date' and table_name like 'd%' AND table_name not in (" + Table_Not_Include + ")";

        String SQL_Del;
        PreparedStatement p = null;
        rs = con.createStatement().executeQuery(SQL_Table_name);
        int Tab_No = 0;
        while (rs.next()) {
            Tab_No++;
            System.out.println("Table No. " + Tab_No + " Table Name : " + rs.getString("table_name"));

            SQL_Del = "delete from " + rs.getString("table_name")
                    + " where doc_date not like '%2559' or doc_date is null ";
            //+ " where to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') AND to_date(format_date('" + date_to + "'),'YYYY-MM-DD'); ";
            //+ " ALTER SEQUENCE seq_" + rs.getString("table_name") + " RESTART WITH 1 ; ";

            System.out.println(SQL_Del);
            delete(SQL_Del, con, p);
        }

    }

    private void delete(String SQL_DEL, Connection con, PreparedStatement p) throws Exception {
        try {
            System.out.println("Delete : " + SQL_DEL);
            p = con.prepareStatement(SQL_DEL);
            p.executeUpdate();
            p.clearParameters();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            System.out.println("OK");
        }
    }
}
