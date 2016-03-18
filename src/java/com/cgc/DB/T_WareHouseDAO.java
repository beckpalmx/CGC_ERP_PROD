package com.cgc.DB;

import com.cgc.bean.T_StockBean;
import com.cgc.bean.T_WareHouseBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class T_WareHouseDAO {

    public void insertDetail(T_WareHouseBean wareHouseBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO t_warehouse_item(warehouse_id,location_id,product_id,weight,price,wh_value,create_date,create_by) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, wareHouseBean.getWarehouse_id());
            p.setString(2, wareHouseBean.getLocation_id());
            p.setString(3, wareHouseBean.getProduct_id());
            p.setString(4, wareHouseBean.getWeight());
            p.setString(5, wareHouseBean.getPrice());
            p.setString(6, wareHouseBean.getWh_value());
            p.setTimestamp(7, wareHouseBean.getCreate_date());
            p.setString(8, wareHouseBean.getCreate_by());
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

    public T_WareHouseBean selectData(T_StockBean data) throws Exception {

        T_WareHouseBean whBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From t_warehouse_item where warehouse_id = ? AND location_id = ? AND product_id=? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, data.getWh_in());
                p.setString(2, data.getLocation_id());
                p.setString(3, data.getProduct_id());
                rs = p.executeQuery();
                while (rs.next()) {
                    whBean = new T_WareHouseBean();
                    whBean.setWarehouse_id(rs.getString("warehouse_id"));
                    whBean.setLocation_id(rs.getString("location_id"));
                    whBean.setProduct_id(rs.getString("product_id"));
                    whBean.setWeight(rs.getString("weight"));
                    whBean.setPrice(rs.getString("price"));
                    whBean.setWh_value(rs.getString("wh_value"));
                }
        } catch(Exception e) {
            e.printStackTrace(System.out);
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
    public void  update(T_WareHouseBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE t_warehouse_item SET weight =?,price=?,wh_value=?,update_date=?,update_by=? where warehouse_id = ? AND location_id = ? AND product_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getWeight());
            p.setString(2, data.getPrice());
            p.setString(3, data.getWh_value());
            p.setTimestamp(4, data.getUpdate_date());
            p.setString(5, data.getUpdate_by());
            p.setString(6, data.getWarehouse_id());
            p.setString(7, data.getLocation_id());
            p.setString(8, data.getProduct_id());
            p.executeUpdate();

        }catch (Exception e){
            e.printStackTrace(System.out);
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public void insertDetail_Total(T_WareHouseBean wareHouseBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO t_warehouse_item_total(warehouse_id,location_id,product_id,weight,price,wh_value,create_date,create_by) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, wareHouseBean.getWarehouse_id());
            p.setString(2, "");
            p.setString(3, wareHouseBean.getProduct_id());
            p.setString(4, wareHouseBean.getWeight());
            p.setString(5, wareHouseBean.getPrice());
            p.setString(6, wareHouseBean.getWh_value());
            p.setTimestamp(7, wareHouseBean.getCreate_date());
            p.setString(8, wareHouseBean.getCreate_by());
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
    public T_WareHouseBean selectData_Total(T_StockBean data) throws Exception {

        T_WareHouseBean whBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From t_warehouse_item_total where warehouse_id = ? AND product_id=? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, data.getWh_in());
                p.setString(2, data.getProduct_id());
                rs = p.executeQuery();
                while (rs.next()) {
                    whBean = new T_WareHouseBean();
                    whBean.setWarehouse_id(rs.getString("warehouse_id"));
                    whBean.setProduct_id(rs.getString("product_id"));
                    whBean.setWeight(rs.getString("weight"));
                    whBean.setPrice(rs.getString("price"));
                    whBean.setWh_value(rs.getString("wh_value"));
                }
        } catch(Exception e) {
            e.printStackTrace(System.out);
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
    public void  updateTotal(T_WareHouseBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE t_warehouse_item_total SET weight =?,price=?,wh_value=?,update_date=?,update_by=? where warehouse_id = ? AND product_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getWeight());
            p.setString(2, data.getPrice());
            p.setString(3, data.getWh_value());
            p.setTimestamp(4, data.getUpdate_date());
            p.setString(5, data.getUpdate_by());
            p.setString(6, data.getWarehouse_id());
            p.setString(7, data.getProduct_id());
            p.executeUpdate();

        }catch (Exception e){
            e.printStackTrace(System.out);
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
