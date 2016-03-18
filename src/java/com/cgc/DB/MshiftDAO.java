/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanMshift;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class MshiftDAO {
    private int returnvalue;
    public int insert(DataBeanMshift dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mshift(shift_id,name_t,remark) values(?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getShift_id());
            p.setString(2, dataBean.getName_t());
            p.setString(3, dataBean.getRemark());
            //p.setTimestamp(4, dataBean.getDate());
            //p.setString(5, dataBean.getBy());
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
    public int  update(DataBeanMshift dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mshift SET name_t=?,remark=? where shift_id = ? and delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getName_t());
            p.setString(2, dataBean.getRemark());
            //p.setTimestamp(3, dataBean.getDate());
            //p.setString(4, dataBean.getBy());
            p.setString(3, dataBean.getShift_id());
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
    public int  updateDel(DataBeanMshift dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mshift SET delete_flag = 'Y' where shift_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            //p.setString(1, dataBean.getBy());
            //p.setTimestamp(2, dataBean.getDate());
            p.setString(1, dataBean.getShift_id());
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
