package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cgc.bean.DataBeanMPROCESS;
import java.sql.ResultSet;

public class MPROCESSDAO {

    public int insert(DataBeanMPROCESS dataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into mprocess (process_id ,procgrp_id,warehouse_id,remark,name_t,wh_bg,wh_en,create_date) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getProcess_id());
            p.setString(2, dataBean.getProcgrp_id());
            p.setString(3, dataBean.getWarehouse_id());
            p.setString(4, dataBean.getRemark());
            p.setString(5, dataBean.getName_t());
            p.setString(6, dataBean.getWh_bg());
            p.setString(7, dataBean.getWh_en());
            p.setTimestamp(8, dataBean.getDate());
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

    public int update(DataBeanMPROCESS dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update mprocess set procgrp_id=?,warehouse_id=?,remark=?,name_t=?,wh_bg=?,wh_en=?,update_date=? where process_id=?";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getProcgrp_id());
            p.setString(2, dataBean.getWarehouse_id());
            p.setString(3, dataBean.getRemark());
            p.setString(4, dataBean.getName_t());
            p.setString(5, dataBean.getWh_bg());
            p.setString(6, dataBean.getWh_en());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getProcess_id());
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

    public int UpDel(DataBeanMPROCESS dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update mprocess set delete_flag = ? , delete_date = ? where process_id=? ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getProcess_id());
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
    public DataBeanMPROCESS selectData(String id) throws Exception {
        DataBeanMPROCESS pBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mprocess where process_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    pBean = new DataBeanMPROCESS();
                    pBean.setProcess_id(rs.getString("process_id"));
                    pBean.setName_t(rs.getString("name_t"));
                    pBean.setRemark(rs.getString("remark"));
                    pBean.setWh_bg(rs.getString("wh_bg"));
                    pBean.setWh_en(rs.getString("wh_en"));
                    pBean.setSub_table1(rs.getString("sub_table1"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return pBean ;
        }
    }
}
