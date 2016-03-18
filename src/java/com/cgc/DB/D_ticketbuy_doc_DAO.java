/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_ticketbuy_doc;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beckpalmx No7
 */
public class D_ticketbuy_doc_DAO {
    private int Returnvalue;

    public int insert(DataBeanD_ticketbuy_doc dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_ticketbuy_doc "
                + "(doc_id,doc_date,doc_time,doc_type,remark,create_date,update_date,create_by) "
                + "values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getDoc_time());
            p.setString(4, dataBean.getDoc_type());
            p.setString(5, dataBean.getRemark());
            p.setTimestamp(6, dataBean.getDate());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_ticketbuy where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_ticketbuy set doc_date=?,doc_type=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2,dataBean.getDoc_type());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_ticketbuy_doc dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_ticketbuy_doc set  doc_date=?,doc_time=?,doc_type=?,remark=?,update_date=?,update_by=?,complete_flag=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getDoc_time());
            p.setString(3, dataBean.getDoc_type());
            p.setString(4, dataBean.getRemark());
            p.setTimestamp(5, dataBean.getDate());
            p.setString(6, dataBean.getBy());
            p.setString(7, dataBean.getComplete_flag());            
            p.setString(8, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_ticketbuy where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_ticketbuy set doc_date=?,doc_type=?,update_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2,dataBean.getDoc_type());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getComplete_flag());                
                p.setString(5, dataBean.getDoc_id());
                p.executeUpdate();
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_ticketbuy_doc dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_ticketbuy_doc set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_ticketbuy set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }
}
