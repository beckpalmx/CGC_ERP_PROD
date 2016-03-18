/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanCS_048;
import com.cgc.bean.DataBeanT_transaction_stock;
import com.cgc.bean.DataBeanT_warehouse_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class CS_114DAO {

    public static void Steadment_PR_114(ArrayList<DataBeanCS_048> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        DataBeanT_transaction_stock Bean_transction = new DataBeanT_transaction_stock();
        DataBeanT_warehouse_item Bean_warehouse = new DataBeanT_warehouse_item();
        T_transaction_stockDAO Obj_transction = new T_transaction_stockDAO();
        T_warehouse_itemDAO Obj_warehouse = new T_warehouse_itemDAO();
        T_warehouse_item_totalDAO obj_total = new T_warehouse_item_totalDAO();
        for (int i = 0; i < objAL.size(); i++) {
            ///*******************Begin Transction ************************
            //Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
            //if (objck.Return_value() == 0 || objck.Return_value() == -5) {
                Bean_transction.setBy(objAL.get(i).getBy());
                Bean_transction.setDate(objAL.get(i).getDate());
                Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                Bean_transction.setWeight(objAL.get(i).getWeight());
                Bean_transction.setWh_in(objAL.get(i).getWh_in());
                Bean_transction.setWh_out(objAL.get(i).getWh_out());
                Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                Bean_transction.setDoc_type("+");
                Bean_transction.setJob_id(objAL.get(i).getJob_id());
                Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                //*********************Beging Warehouse ************************
                Chk_T_warehouse_item objck2 = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
                if (objck2.Return_value() != 0 && objck2.Return_value() != -5) {
                    Bean_warehouse.setBy(objAL.get(i).getBy());
                    Bean_warehouse.setDate(objAL.get(i).getDate());
                    Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_in());
                    Bean_warehouse.setLocation_id(objAL.get(i).getLocation_id());
                    Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                    Bean_warehouse.setWeight(objAL.get(i).getWeight());
                    Bean_warehouse.setPrice("0.00");
                    Bean_warehouse.setWh_value("0.00");
                    Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
                } else {
                    Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
                }
                obj_total.T_warehouse_item_total(Bean_transction, con);
                obj_total.T_warehouse_total_product(Bean_transction, con);
                objAL.get(i).setComplate_falg("Y");
            //}
        }
        Update_Complete_flag(objAL);
        if (con != null) {
            con.close();
        }
    }

    public static void Update_Complete_flag(ArrayList<DataBeanCS_048> objAL) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "";
        String SQL_num = "";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try {
            for (int i = 0; i < objAL.size(); i++) {
                if (objAL.get(i).getComplate_falg().equals("Y")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail(); 
                    SQL += " Set complete_flag = '" + objAL.get(i).getComplate_falg();
                    SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();  
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();  
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();  
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();  
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                    System.out.println("SQL = "+ SQL );
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(i).getDoc_id());
                    p.setString(2, objAL.get(i).getLine_no());
                    p.executeUpdate();
                }
            }
            SQL_num = (objAL.isEmpty())
                    ? null
                    : "SELECT count(doc_id) as num From " + objAL.get(0).getTable_detail() + " WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
            if (SQL_num != null) {
                if (objuti.numRowdatabase(SQL_num) == 0) {
                    p = null;
                    SQL = "UPDATE " + objAL.get(0).getTable_header() + " Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' ";
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(0).getDoc_id());
                    p.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
