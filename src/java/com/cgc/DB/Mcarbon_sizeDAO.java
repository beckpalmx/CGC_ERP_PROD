/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanMcarbon_size;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class Mcarbon_sizeDAO {
    private int returnvalue;
    public int insert(DataBeanMcarbon_size dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO m_carbon_size(size_id,name_t,remark,create_by,create_date,size_order) values(?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setInt(1, dataBean.getSize_id());
            p.setString(2, dataBean.getName_t());
            p.setString(3, dataBean.getRemark());
            p.setString(4, dataBean.getBy());
            p.setTimestamp(5, dataBean.getDate());            
            p.setInt(6, dataBean.getSize_order());
            returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return returnvalue;
    }
    public int  update(DataBeanMcarbon_size dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE m_carbon_size SET name_t=?,remark=?,update_by=?,update_date=?,size_order=? where size_id = ? and delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getName_t());
            p.setString(2, dataBean.getRemark());
            p.setString(3, dataBean.getBy());
            p.setTimestamp(4, dataBean.getDate());  
            p.setInt(5, dataBean.getSize_order());
            p.setInt(6, dataBean.getSize_id());
            returnvalue = p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return returnvalue;
    }
    public int  updateDel(DataBeanMcarbon_size dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //String sql = "UPDATE m_carbon_size SET delete_flag = 'Y' ,delete_by = ? , delete_date = ? where size_id=?";
        String sql = "DELETE FROM m_carbon_size where size_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            //p.setString(1, dataBean.getBy());
            //p.setTimestamp(2, dataBean.getDate());
            p.setInt(1, dataBean.getSize_id());
            returnvalue =p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return returnvalue;
    }



}
