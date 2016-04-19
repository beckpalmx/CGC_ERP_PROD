/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanT_transaction_stock;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Beck
 */
public class T_transaction_stockDAO {

    private String SQL;
//ทำการบันทึกข้อมูลลง Transection Stock
    public void InsertT_transaction_stock(DataBeanT_transaction_stock dataBean,Connection con) throws Exception {
        //DBConnect objcon = new DBConnect();
        //Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        SQL = (dataBean.getDoc_type().equals("-")|| dataBean.getProcess_id().equals("PR_022"))
                ?"INSERT INTO t_transaction_stock "
                + "(doc_no,process_id,location_id,product_id,wh_in,doc_type,weight,create_date,create_by,job_id,weight_withdraw,doc_date,wh_id) "
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"
                :"INSERT INTO t_transaction_stock "
                + "(doc_no,process_id,location_id,product_id,wh_out,doc_type,weight,create_date,create_by,job_id,weight_withdraw,doc_date,wh_id) "
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        
        System.out.println("T_Transaction_Stock = " + SQL);
        
        try {
                p = con.prepareStatement(SQL);
                p.setString(1, dataBean.getDoc_id());
                p.setString(2, dataBean.getProcess_id());
                p.setString(3, dataBean.getLocation_id());
                p.setString(4, dataBean.getProduct_id());
                p.setString(5, (dataBean.getDoc_type().equals("-") || dataBean.getProcess_id().equals("PR_022"))?dataBean.getWh_in():dataBean.getWh_out());
                p.setString(6, dataBean.getDoc_type());// เป็น + หรือ - เท่านั้น
                p.setString(7, dataBean.getWeight());
                p.setTimestamp(8, dataBean.getDate());
                p.setString(9, dataBean.getBy());
                p.setString(10, dataBean.getJob_id());
                p.setString(11,dataBean.getWeight_withdraw());
                p.setString(12, dataBean.getDoc_date());
                p.setString(13, (dataBean.getDoc_type().equals("-") || dataBean.getProcess_id().equals("PR_022"))?dataBean.getWh_in():dataBean.getWh_out());
                p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            /*if (con != null) {
                con.close();
            }*/
        }
    }
}
