/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.WarehouseBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author com02
 */
public class WareHouseDAO {
    public boolean insert(WarehouseBean whBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mwarehouse(warehouse_id,name_t,remark,create_date,wh_type) values(?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, whBean.getWarehouse_id());
            p.setString(2, whBean.getName_t());
            p.setString(3, whBean.getRemark());
            p.setTimestamp(4, whBean.getCreate_date());
            p.setString(5, whBean.getWh_type());            
            p.executeUpdate();

            return true;

        } catch (Exception e) {
            return false;
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
    public ArrayList<WarehouseBean> selectDataAll() throws Exception {
        WarehouseBean whBean = null;
        ArrayList<WarehouseBean> list = new ArrayList<WarehouseBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mwarehouse where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                whBean = new WarehouseBean();
                whBean.setWarehouse_id(rs.getString("warehouse_id"));
                whBean.setName_t(rs.getString("name_t"));
                whBean.setRemark(rs.getString("remark"));
                whBean.setWh_type(rs.getString("wh_type"));
                list.add(whBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return list;
        }
    }
    public ArrayList<WarehouseBean> selectDataSerBy(String name, String id) throws Exception {
        WarehouseBean whBean = null;
        ArrayList<WarehouseBean> list = new ArrayList<WarehouseBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mwarehouse where name_t like ? or warehouse_id like ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                whBean = new WarehouseBean();
                whBean.setWarehouse_id(rs.getString("warehouse_id"));
                whBean.setName_t(rs.getString("name_t"));
                whBean.setRemark(rs.getString("remark"));
                whBean.setWh_type(rs.getString("wh_type"));
                list.add(whBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return list;
        }
    }
    public void  updateDel(WarehouseBean whBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mwarehouse SET delete_flag = 'Y' where warehouse_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, whBean.getWarehouse_id());
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
    public void  update(WarehouseBean whBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mwarehouse SET name_t=?,remark=?,update_date=?,wh_type=? where warehouse_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            
            
            p.setString(1, whBean.getName_t());
            p.setString(2, whBean.getRemark());
            p.setTimestamp(3, whBean.getUpdate_date());
            p.setString(4, whBean.getWh_type());            
            p.setString(5, whBean.getWarehouse_id());
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
    public WarehouseBean selectData(String id) throws Exception {
        WarehouseBean whBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mwarehouse where warehouse_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    whBean = new WarehouseBean();
                    whBean.setWarehouse_id(rs.getString("warehouse_id"));
                    whBean.setName_t(rs.getString("name_t"));
                    whBean.setRemark(rs.getString("remark"));
                    whBean.setWh_type(rs.getString("wh_type"));
                    whBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return whBean ;
        }
    }
}
