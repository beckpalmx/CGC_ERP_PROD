/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBean_MData_export;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class Mdata_exportDAO {

    private int returnvalue;

    public int insert(DataBean_MData_export dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mdata_export"
                + "(export_id,name_t,lookup_name,param_name,param_value,param_from,param_value_from,order_by,complete_flag,retro_flag,cancel_flag,remark,create_date,create_by) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getExport_id());
            p.setString(2, dataBean.getName_t());
            p.setString(3, dataBean.getLookup_name());
            p.setString(4, dataBean.getParam_name());
            p.setString(5, dataBean.getParam_value());
            p.setString(6, dataBean.getParam_from());
            p.setString(7, dataBean.getParam_value_from());
            p.setString(8, dataBean.getOrder_by());
            p.setString(9, dataBean.getComplete_flag());
            p.setString(10, dataBean.getRetro_flag());
            p.setString(11, dataBean.getCancel_flag());
            p.setString(12, dataBean.getRemark());
            p.setTimestamp(13, dataBean.getDate());
            p.setString(14, dataBean.getBy());
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

    public int update(DataBean_MData_export dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mdata_export SET "
                + "name_t=?,lookup_name=?,param_name=?,param_value=?,param_from=?,param_value_from=?,order_by=?,complete_flag=?,retro_flag=?,cancel_flag=?,remark=?,update_date=?,update_by=?"
                + " where export_id = ? and status = 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getName_t());
            p.setString(2, dataBean.getLookup_name());
            p.setString(3, dataBean.getParam_name());
            p.setString(4, dataBean.getParam_value());
            p.setString(5, dataBean.getParam_from());
            p.setString(6, dataBean.getParam_value_from());
            p.setString(7, dataBean.getOrder_by());
            p.setString(8, dataBean.getComplete_flag());
            p.setString(9, dataBean.getRetro_flag());
            p.setString(10, dataBean.getCancel_flag());
            p.setString(11, dataBean.getRemark());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            p.setString(14, dataBean.getExport_id());
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

    public int updateDel(DataBean_MData_export dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mdata_export SET status = 'N',delete_date=?,delete_by=? where export_id=? and status = 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setTimestamp(1, dataBean.getDate());
            p.setString(2, dataBean.getBy());
            p.setString(3, dataBean.getExport_id());
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
}
