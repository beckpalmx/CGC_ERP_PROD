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
public class Transfer_MRawmat_Price {

    private final UtiDatabase objuti = new UtiDatabase();

    public void generater_transaction_process(String date_from, String date_to, String process_id, String table, String doc_type, String r, String username) throws Exception {
        try (Connection con = new DBConnect().openNewConnection()) {
            ResultSet rs ;
            PreparedStatement p ;
            PreparedStatement p1 ;
            String SQL_MAIN, SQL ;
            String currentYear = date_to.substring(6, 10);
            String previousYear = Integer.toString((Integer.parseInt(currentYear) - 1));
            System.out.println("currentYear = " + currentYear);
            System.out.println("previousYear = " + previousYear);
            System.out.println("Warehouse Start Process process");
            try {
                
                SQL = " select * from " + table + " where pgroup_id = 'RAW' and price_year = '" + previousYear + "' and delete_flag <> 'Y' order by runno ";
                System.out.println("First SQL = " + SQL);
                p = con.prepareStatement(SQL);
                rs = p.executeQuery();
                
                while (rs.next()) {
                    
                    SQL_MAIN = "select count(product_id) as num from " + table
                            + " where product_id = '" + rs.getString("product_id") + "'"
                            + " and pgroup_id = '" + rs.getString("pgroup_id") + "'"
                            //+ " and iodine = '" + rs.getString("iodine") + "'"
                            + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                    
                    //System.out.println("SQL_MAIN = " + SQL_MAIN);
                    //System.out.println("count_loop = " + count_loop);
                    //count_loop++;
                    if (objuti.numRowdatabase(SQL_MAIN) == 0) {
                        
                        //System.out.println("count = " + count);
                        //count++;
                        SQL_MAIN = "INSERT INTO " + table
                                + " (pgroup_id,price_year,iodine,product_id,lot_no"
                                + ",price_month_1,price_month_2,price_month_3"
                                + ",price_month_4,price_month_5,price_month_6"
                                + ",price_month_7,price_month_8,price_month_9"
                                + ",price_month_10,price_month_11,price_month_12"
                                + ",create_by,create_date) "
                                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                        
                        //System.out.println("Insert = " + SQL_MAIN);
                        p1 = con.prepareStatement(SQL_MAIN);
                        p1.setString(1, rs.getString("pgroup_id"));
                        p1.setString(2, currentYear);
                        p1.setString(3, rs.getString("iodine"));
                        p1.setString(4, rs.getString("product_id"));
                        p1.setString(5, rs.getString("lot_no"));
                        p1.setString(6, rs.getString("price_month_1"));
                        p1.setString(7, rs.getString("price_month_2"));
                        p1.setString(8, rs.getString("price_month_3"));
                        p1.setString(9, rs.getString("price_month_4"));
                        p1.setString(10, rs.getString("price_month_5"));
                        p1.setString(11, rs.getString("price_month_6"));
                        p1.setString(12, rs.getString("price_month_7"));
                        p1.setString(13, rs.getString("price_month_8"));
                        p1.setString(14, rs.getString("price_month_9"));
                        p1.setString(15, rs.getString("price_month_10"));
                        p1.setString(16, rs.getString("price_month_11"));
                        p1.setString(17, rs.getString("price_month_12"));
                        p1.setString(18, username);
                        p1.setTimestamp(19, new Timestamp(new java.util.Date().getTime()));
                        p1.executeUpdate();
                        
                    } else {
                        
                        SQL_MAIN = "update " + table + " set pgroup_id=?,price_year=?,iodine=?,product_id=?,lot_no=?,update_by=?,update_date=? "
                                + " where product_id = '" + rs.getString("product_id") + "'"
                                + " and pgroup_id = '" + rs.getString("pgroup_id") + "'"
                                //+ " and iodine = '" + rs.getString("iodine") + "'"
                                + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                        
                        //System.out.println("Update SQL_MAIN product = " + SQL_MAIN);
                        p1 = con.prepareStatement(SQL_MAIN);
                        p1.setString(1, rs.getString("pgroup_id"));
                        p1.setString(2, currentYear);
                        p1.setString(3, rs.getString("iodine"));
                        p1.setString(4, rs.getString("product_id"));
                        p1.setString(5, rs.getString("lot_no"));
                        p1.setString(6, username);
                        p1.setTimestamp(7, new Timestamp(new java.util.Date().getTime()));
                        p1.executeUpdate();
                        
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
