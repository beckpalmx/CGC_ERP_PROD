/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanT_transaction_stock;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 *
 * @author Beck
 */
public class T_warehouse_item_totalDAO {
    
    public void T_warehouse_item_total(DataBeanT_transaction_stock bean,Connection con) throws Exception {
        Chk_T_warehouse_item objck = new Chk_T_warehouse_item((bean.getDoc_type().equals("-")) ? bean.getWh_in() : bean.getWh_out(), bean.getProduct_id());
        if (objck.Return_value() == 0) {
            Update_Warehouse_Total((bean.getDoc_type().equals("-")) ? bean.getWh_in() : bean.getWh_out(), bean.getProduct_id(),bean.getBy(),bean.getDate(),con);
        } else {
            Insert_Warehouse_Total(bean.getProcess_id(),(bean.getDoc_type().equals("-")) ? bean.getWh_in() : bean.getWh_out(), bean.getProduct_id(), bean.getWeight(),bean.getBy(),bean.getDate(),con);
        }
    }

    public static void Insert_Warehouse_Total(String Process_id,String Warehouse_id, String Product_id, String Weight,String By,Timestamp Date,Connection con) throws Exception {
        String SQL = "Insert into t_warehouse_item_total "
                + "(warehouse_id,product_id,weight,create_by,create_date) "
                + "values(?,?,?,?,?)";
        //DBConnect objcon = new DBConnect();
        //Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(SQL);
            p.setString(1, Warehouse_id);
            p.setString(2, Product_id);
            p.setString(3, (Process_id.equals("PR_023"))?"0.00":Weight);
            p.setString(4, By);
            p.setTimestamp(5, Date);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            /*if (con != null) {
                con.close();
            }*/
        }

    }

    public static void Update_Warehouse_Total(String Warehouse_id, String Product_id,String By,Timestamp Date,Connection con) throws Exception {
        Calculator_T_warehouse_item objcal = new Calculator_T_warehouse_item();
        //DBConnect objcon = new DBConnect();
        //Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        String SQL = "Update t_warehouse_item_total Set"
                + " weight=?,update_by=?,update_date=? "
                + "Where warehouse_id = ? and product_id = ?";
        try {
            p = con.prepareStatement(SQL);
            p.setString(1, objcal.Cal_T_warehouse_item_total(Warehouse_id, Product_id));
            p.setString(2, By);
            p.setTimestamp(3, Date);
            p.setString(4, Warehouse_id);
            p.setString(5, Product_id);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            /*if (con != null) {
                con.close();
            }*/
        }
    }

    public void T_warehouse_total_product(DataBeanT_transaction_stock bean,Connection con) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "Select count(*) as num from t_warehouse_item_product where product_id = '" + bean.getProduct_id() + "'";
        if (objuti.numRowdatabase(SQL) != 0) {
            Update_Total_Product(bean.getProduct_id(),bean.getBy(),bean.getDate(),con);
        } else {
            Insert_Total_Product(bean.getProduct_id(), bean.getWeight(),bean.getBy(),bean.getDate(),con);
            
        }
    }

    public static void Insert_Total_Product(String Product_id, String Weight,String By, Timestamp Date ,Connection con) throws Exception {
        String SQl = "Insert into t_warehouse_item_product "
                + "(product_id,weight,create_by,create_date) "
                + "Values(?,?,?,?)";
        //DBConnect objcon = new DBConnect();
        //Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try{
            p = con.prepareStatement(SQl);
            p.setString(1, Product_id);
            p.setString(2, Weight);
            p.setString(3, By);
            p.setTimestamp(4, Date);            
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            /*if(con != null){
                con.close();
            }*/
        }
    }

    public static void Update_Total_Product(String Product_id,String By,Timestamp Date,Connection con) throws Exception {
        String SQl = "Update  t_warehouse_item_product set "
                + " weight=?,update_by=?,update_date=? "
                + "Where product_id = ?";
        //DBConnect objcon = new DBConnect();
        //Connection con = objcon.openNewConnection();
        Calculator_T_warehouse_item objcal = new Calculator_T_warehouse_item();
        PreparedStatement p = null;
        try{
            p = con.prepareStatement(SQl);
            p.setString(1, objcal.Cal_T_warehouse_item_product(Product_id));
            p.setString(2, By);
            p.setTimestamp(3, Date);            
            p.setString(4, Product_id);
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            /*if(con != null){
                con.close();
            }*/
        }
    }
}
