/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import com.cgc.Util.UtiDatabase;
import java.sql.SQLException;

/**
 *
 * @author Beckpalmx No7
 */
public class Check_MRawmat_Price {

    private final UtiDatabase objuti = new UtiDatabase();

    public void generater_transaction_process(String date_from, String date_to, String process_id, String table, String doc_type, String r, String username) throws Exception {
        try (Connection con = new DBConnect().openNewConnection()) {
            ResultSet rs ;
            PreparedStatement p ;
            String SQL_MAIN, SQL ;
            String currentYear = date_to.substring(6, 10);
            System.out.println("Start Process process");
            try {
                
                SQL = " select * from vproduct where pgroup_id in ('RAW') order by runno ";
                
                p = con.prepareStatement(SQL);
                rs = p.executeQuery();
                while (rs.next()) {
                    
                    SQL_MAIN = "select count(product_id) as num from " + table + " where product_id ='" + rs.getString("product_id") + "'"
                            + " and pgroup_id = '" + rs.getString("pgroup_id") + "'"
                            + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                    
                    System.out.println("SQL_MAIN = " + SQL_MAIN);
                    
                    if (objuti.numRowdatabase(SQL_MAIN) == 0) {
                        
                        SQL_MAIN = "INSERT INTO " + table + " (pgroup_id,price_year,iodine,product_id,lot_no,create_by,create_date) values(?,?,?,?,?,?,?)";
                        //System.out.println("Insert = " + SQL_MAIN);
                        p = con.prepareStatement(SQL_MAIN);
                        p.setString(1, rs.getString("pgroup_id"));
                        p.setString(2, currentYear);
                        p.setString(3, rs.getString("iodine"));
                        p.setString(4, rs.getString("product_id"));
                        p.setString(5, rs.getString("lot_no"));
                        p.setString(6, username);
                        p.setTimestamp(7, new Timestamp(new java.util.Date().getTime()));
                        p.executeUpdate();
                        
                    } else {
                        
                        SQL_MAIN = "update " + table + " set pgroup_id=?,price_year=?,iodine=?,product_id=?,lot_no=?,update_by=?,update_date=? "
                                + " where product_id ='" + rs.getString("product_id") + "'"
                                + " and pgroup_id = '" + rs.getString("pgroup_id") + "'"
                                + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                        
                        //System.out.println("Update SQL_MAIN product = " + SQL_MAIN);
                        p = con.prepareStatement(SQL_MAIN);
                        p.setString(1, rs.getString("pgroup_id"));
                        p.setString(2, currentYear);
                        p.setString(3, rs.getString("iodine"));
                        p.setString(4, rs.getString("product_id"));
                        p.setString(5, rs.getString("lot_no"));
                        p.setString(6, username);
                        p.setTimestamp(7, new Timestamp(new java.util.Date().getTime()));
                        p.executeUpdate();
                    }
                }
                
            } finally {
                try {
                    System.out.println("Close Final");
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }
                
            }
        }
        System.out.println("End Process process ");
    }
}
