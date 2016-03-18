/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.bean.DataBeanT_transaction_stock;
import com.cgc.bean.DataBeanT_warehouse_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class T_warehouse_itemDAO {

    private String SQL;
    public String weight;
    public String price;
    public String wh_value;
    //insert ข้อมูลลง T_warehouse_item

    public void InsertT_warehouse_item(DataBeanT_warehouse_item dataBean, Connection con) throws Exception {
        PreparedStatement p = null;
        SQL = "INSERT INTO t_warehouse_item "
                + "(warehouse_id,location_id,product_id,price,wh_value,weight,create_date,create_by)"
                + " VALUES(?,?,?,?,?,?,?,?)";
        try {
            p = con.prepareStatement(SQL);
            p.setString(1, dataBean.getWarehouse_id());
            p.setString(2, dataBean.getLocation_id());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getPrice());
            p.setString(5, dataBean.getWh_value());
            p.setString(6, dataBean.getWeight());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }

    }

    public void UpdateT_warehouse_item(DataBeanT_transaction_stock dataBean, Connection con) throws Exception {
        Calculator_T_warehouse_item objcal = new Calculator_T_warehouse_item();
        Select_Twarehouse_data((dataBean.getDoc_type().equals("-")) ? dataBean.getWh_in() : dataBean.getWh_out(), dataBean.getLocation_id(), dataBean.getProduct_id());
        PreparedStatement p = null;
        SQL = "Update t_warehouse_item set weight=?,update_date=?,update_by=?";
        SQL += ",wh_value=?,price=?";
        SQL += " where warehouse_id=? and location_id=? and product_id=?";
        try {
            //dataBean.setWeight();
            if (dataBean.getProcess_id().equals("PR_022")) {
                p = con.prepareStatement(SQL);
                p.setString(1, objcal.Cal_Positive(weight, dataBean.getWeight()));
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, objcal.Cal_WH_Total_Value(wh_value, dataBean.getReceieve_value()));
                p.setString(5, objcal.Cost_per_Unit(objcal.Cal_WH_Total_Value(wh_value, dataBean.getReceieve_value()), objcal.Cal_Positive(weight, dataBean.getWeight())));
                p.setString(6, (dataBean.getDoc_type().equals("-")) ? dataBean.getWh_in() : dataBean.getWh_out());
                p.setString(7, dataBean.getLocation_id());
                p.setString(8, dataBean.getProduct_id());
            } else {
                p = con.prepareStatement(SQL);
                p.setString(1, (dataBean.getDoc_type().equals("-")) ? objcal.Cal_Negative(weight, dataBean.getWeight()) : objcal.Cal_Positive(weight, dataBean.getWeight()));
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getWh_value() == null ? "0.00":dataBean.getWh_value());
                p.setString(5, dataBean.getCost_per_unit()== null ? "0.00" : dataBean.getCost_per_unit());
                p.setString(6, (dataBean.getDoc_type().equals("-")) ? dataBean.getWh_in() : dataBean.getWh_out());
                p.setString(7, dataBean.getLocation_id());
                p.setString(8, dataBean.getProduct_id());
                
            }
            p.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }/*if(con != null){
            con.close();
            }*/
        }
    }
    //เลือก warehouse_id,location_id,product_id  เพื่อเอา weight ออกมา

    public void Select_Twarehouse_data(String warehouse_id, String location_id, String product_id) throws Exception {
        weight = "0.00";
        price = "0.00";
        wh_value = "0.00";
        String SQL_select = "SELECT weight,wh_value,price FROM t_warehouse_item WHERE warehouse_id ='" + warehouse_id + "' AND location_id ='" + location_id + "' AND product_id = '" + product_id + "'";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL_select);
            while (rs.next()) {
                weight = rs.getString("weight");
                wh_value = rs.getString("wh_value");
                price = rs.getString("price");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
