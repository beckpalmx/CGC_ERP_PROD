package com.cgc.DB;

import java.sql.*;

import com.cgc.bean.DataBeanMSTD_COST_SUB;

public class MSTD_COST_SUBDAO {

    public int insert(DataBeanMSTD_COST_SUB dataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into mstd_cost_sub (std_sub_id,std_id,oh_id,cost_value,driver_id,remark,name_t,create_date,doc_type) values(?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getStd_sub_id());
            p.setString(2, dataBean.getStd_id());
            p.setString(3, dataBean.getOh_id());
            p.setString(4, dataBean.getCost_value());
            p.setString(5, dataBean.getDriver_id());
            p.setString(6, dataBean.getRemark());
            p.setString(7, dataBean.getName_t());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getDoc_type());
            return p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public int update(DataBeanMSTD_COST_SUB dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update mstd_cost_sub set std_id=?,oh_id=?,cost_value=?,driver_id=?,remark=?,name_t=?,update_date=?,doc_type=? where std_sub_id=?";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);

            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getStd_id());
            p.setString(2, dataBean.getOh_id());
            p.setString(3, dataBean.getCost_value());
            p.setString(4, dataBean.getDriver_id());
            p.setString(5, dataBean.getRemark());
            p.setString(6, dataBean.getName_t());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getDoc_type());
            p.setString(9, dataBean.getStd_sub_id());
            return p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public int UpDel(DataBeanMSTD_COST_SUB dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update mstd_cost_sub set delete_flag = ? , delete_date = ? where std_sub_id=? ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getStd_sub_id());
            return p.executeUpdate();

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
