/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanMjob_type_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class Mjob_type_detailDAO {
    private int returnvalue;
    public int insert(DataBeanMjob_type_detail dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mjob_type_detail(job_type_id,job_type_desc,remark,create_date,create_by) values(?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getJob_type_id());
            p.setString(2, dataBean.getJob_type_desc());
            p.setString(3, dataBean.getRemark());
            p.setTimestamp(4, dataBean.getDate());
            p.setString(5, dataBean.getBy());
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
    public int  update(DataBeanMjob_type_detail dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mjob_type_detail SET job_type_desc=?,remark=?,update_date=?,update_by=? where job_type_id = ? and delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getJob_type_desc());
            p.setString(2, dataBean.getRemark());
            p.setTimestamp(3, dataBean.getDate());
            p.setString(4, dataBean.getBy());
            p.setString(5, dataBean.getJob_type_id());
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
    public int  updateDel(DataBeanMjob_type_detail dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mjob_type_detail SET delete_flag = 'Y',delete_by=?,delete_date=? where job_type_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getBy());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getJob_type_id());
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
