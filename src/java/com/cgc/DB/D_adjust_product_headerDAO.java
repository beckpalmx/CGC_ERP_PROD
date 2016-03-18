/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_adjust_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Beckpalmx No7
 */
public class D_adjust_product_headerDAO {

    private int Returnvalue;

    public int insert(DataBeanD_adjust_product_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            String sql = "insert into d_adjust_product_header "
                    + "(doc_id,doc_date,doc_time,doc_type,remark,create_date,update_date,create_by) "
                    + "values(?,?,?,?,?,?,?,?)";
            PreparedStatement p;
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
                sql = "select count(doc_id) as num from d_adjust_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_adjust_product_detail set doc_date=?,doc_type=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    //p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getDoc_type());
                    p.setString(3, dataBean.getBy());
                    p.setString(4, dataBean.getDoc_id());
                    p.executeUpdate();
                    update_sum_header(dataBean);
                }
            } finally {
                try {
                    //p.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }

            }
        }
        return Returnvalue;
    }

    public int update(DataBeanD_adjust_product_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        try (Connection con = dbConnect.openNewConnection()) {
            String sql
                    = "update d_adjust_product_header set  doc_date=?,doc_time=?,doc_type=?,remark=?,update_date=?,update_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
            PreparedStatement p;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getDoc_time());
                p.setString(3, dataBean.getDoc_type());
                p.setString(4, dataBean.getRemark());
                p.setTimestamp(5, dataBean.getDate());
                p.setString(6, dataBean.getBy());
                p.setString(7, dataBean.getDoc_id());
                Returnvalue = p.executeUpdate();
                sql = "select count(doc_id) as num from d_adjust_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_adjust_product_detail set doc_date=?,doc_type=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    //p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getDoc_type());
                    p.setString(3, dataBean.getBy());
                    p.setString(4, dataBean.getDoc_id());
                    p.executeUpdate();
                    update_sum_header(dataBean);
                }
            } finally {
                try {
                    //p.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }

            }
        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_adjust_product_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        try (Connection con = dbConnect.openNewConnection()) {
            String sqlheader = "update d_adjust_product_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
            String sqldetail = "update d_adjust_product_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
                    //p.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }
            }
        }
    }

    public void update_sum_header(DataBeanD_adjust_product_header dataBean) throws Exception {

        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            PreparedStatement p;
            
            String total_weight = "";
            
            String sql = "select sum(to_number(weight,'9999999.99')) as weight from d_adjust_product_detail where doc_id = '" + dataBean.getDoc_id() + "'";
            
            System.out.println("sql = " + sql);
            
            ResultSet rs = con.createStatement().executeQuery(sql);
            while (rs.next()) {
                total_weight = rs.getString("weight");
            }
            
            String sql_update = "update d_adjust_product_header set total_weight_adjust=? where doc_id = ? and delete_flag <> 'Y' ";
            p = con.prepareStatement(sql_update);
            p.setString(1, total_weight);
            p.setString(2, dataBean.getDoc_id());
            p.executeUpdate();
        }
    }
}
