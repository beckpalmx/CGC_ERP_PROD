/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanM_machine;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class MmachineDAO {
    private int returnvalue;
    public int insert(DataBeanM_machine dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mmachine(machine_id,name_t,remark,create_date,create_by) values(?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getMachine_id());
            p.setString(2, dataBean.getName_t());
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
    public int  update(DataBeanM_machine dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mmachine SET name_t=?,remark=?,update_date=?,update_by=? where machine_id = ? and delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getName_t());
            p.setString(2, dataBean.getRemark());
            p.setTimestamp(3, dataBean.getDate());
            p.setString(4, dataBean.getBy());
            p.setString(5, dataBean.getMachine_id());
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
    public int  updateDel(DataBeanM_machine dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mmachine SET delete_flag = 'Y',delete_by=?,delete_date=? where machine_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getBy());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getMachine_id());
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
