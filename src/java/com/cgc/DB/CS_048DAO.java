/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.Util.Process_ShowDetail;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanCS_048;
import com.cgc.bean.DataBeanError_Stock_Item;
import com.cgc.bean.DataBeanT_transaction_stock;
import com.cgc.bean.DataBeanT_warehouse_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class CS_048DAO {

    private String SQL;
    private UtiDatabase objuti;
    private int count;
    private int case_stedment;
    public static DataBeanT_transaction_stock Bean_transction = new DataBeanT_transaction_stock();
    public static DataBeanT_warehouse_item Bean_warehouse = new DataBeanT_warehouse_item();
    public static T_transaction_stockDAO Obj_transction = new T_transaction_stockDAO();
    public static T_warehouse_itemDAO Obj_warehouse = new T_warehouse_itemDAO();
    public static T_warehouse_item_totalDAO obj_total = new T_warehouse_item_totalDAO();
    public static ArrayList<DataBeanError_Stock_Item> objAL_error = new ArrayList<DataBeanError_Stock_Item>();

    public void workCS_048(ArrayList<DataBeanCS_048> objAL) throws Exception {

        count = 0;
        case_stedment
                = (objAL.get(count).getProcess_id().equals("PR_022"))
                ? 1
                : (objAL.get(count).getProcess_id().equals("PR_023") || (objAL.get(count).getProcess_id().equals("PR_027")))
                ? 2
                : (objAL.get(count).getProcess_id().equals("PR_042"))
                ? 3
                : (objAL.get(count).getProcess_id().equals("PR_115"))//รับถ่านที่เหลือคืนจากการผลิตเข้าคลังสินค้า
                ? 4
                : 0;
        Case_Work(objAL, case_stedment);

    }

    public static void Case_Work(ArrayList<DataBeanCS_048> objAL, int case_stedment) throws Exception {
        switch (case_stedment) {
            case 1:
                Steadment_PR_022(objAL);
                break;
            case 2:
                Stedment_PR_023(objAL);
                break;
            case 3:
                Stedment_PR_042(objAL);
                //Stedment_PR_Other(objAL);
                break;
            case 4:
                Stedment_PR_Other2(objAL);
            default:
                break;
        }
    }

    public static void Steadment_PR_022(ArrayList<DataBeanCS_048> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        Calculator_T_warehouse_item objcal = new Calculator_T_warehouse_item();
        for (int i = 0; i < objAL.size(); i++) {
            ///*******************Begin Transction ************************
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
            Bean_transction.setReceieve_value(objAL.get(i).getTotal_price());
            Obj_transction.InsertT_transaction_stock(Bean_transction, con);
            //*********************Beging Warehouse ************************

            Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
            if (objck.Return_value() != 0 && objck.Return_value() != -5) {
                Bean_warehouse.setBy(objAL.get(i).getBy());
                Bean_warehouse.setDate(objAL.get(i).getDate());
                Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_in());
                Bean_warehouse.setLocation_id(objAL.get(i).getLocation_id());
                Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                Bean_warehouse.setWeight(objAL.get(i).getWeight());
                //Bean_warehouse.setPrice(objcal.Cost_per_Unit(objAL.get(i).getTotal_price(), objAL.get(i).getWeight()));
                //Bean_warehouse.setPrice("0.00");
                Bean_warehouse.setPrice(objcal.Cost_per_Unit(objAL.get(i).getTotal_price() == null || objAL.get(i).getTotal_price().equals("null") ? "0.00" : objAL.get(i).getTotal_price(), objAL.get(i).getWeight()));
                //Bean_warehouse.setWh_value(objAL.get(i).getTotal_price());
                Bean_warehouse.setWh_value("0.00");
                Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
            } else {
                Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
            }
            //obj_total.T_warehouse_item_total(Bean_transction, con);
            //obj_total.T_warehouse_total_product(Bean_transction, con);
            //D_cost_productDAO objcost = new D_cost_productDAO();
            //objcost.D_cost_product(Bean_transction);
            objAL.get(i).setComplate_falg("Y");
        }
        Update_Complete_flag(objAL);
        if (con != null) {
            con.close();
        }
    }

    public static void Stedment_PR_023(ArrayList<DataBeanCS_048> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        Calculator_T_warehouse_item objcal = new Calculator_T_warehouse_item();
        System.out.println("objAL.size() = " + objAL.size());
        for (int i = 0; i < objAL.size(); i++) {

            Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());

            if (objck.Return_value() != 9) {
                ///*******************Begin Transction ************************
                Bean_transction.setBy(objAL.get(i).getBy());
                Bean_transction.setDate(objAL.get(i).getDate());
                Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                Bean_transction.setJob_id(objAL.get(i).getJob_id());
                Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                Bean_transction.setWeight(objAL.get(i).getWeight());
                Bean_transction.setWh_in(objAL.get(i).getWh_in());
                Bean_transction.setWh_out(objAL.get(i).getWh_out());
                Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                //***************** - **************************
                Bean_transction.setDoc_type("-");
                Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                //***************** + **************************
                /*
                 Bean_transction.setDoc_type("+");
                 Bean_transction.setLocation_id(objAL.get(i).getLocation_doc_id());
                 Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                
                 */
                //**************** - ***************************
                /*
                 Bean_transction.setWh_in(objAL.get(i).getWh_out());
                 Bean_transction.setDoc_type("-");
                 Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                 Bean_transction.setWh_in(objAL.get(i).getWh_in());
                 */
                //*********************Beging Warehouse ************************
                for (int j = 1; j <= 1; j++) {
                    Bean_transction.setDoc_type(j == 1 || j == 3 ? "-" : "+");
                    Bean_transction.setLocation_id(j == 1 ? objAL.get(i).getLocation_id() : objAL.get(i).getLocation_doc_id());
                    Bean_transction.setWh_in(j == 3 ? objAL.get(i).getWh_out() : objAL.get(i).getWh_in());
                    //Chk_T_warehouse_item objck2 = new Chk_T_warehouse_item(Bean_transction.getLocation_id(), Bean_transction.getProduct_id(), j == 1 || j == 3 ? Bean_transction.getWh_in() : Bean_transction.getWh_out(), Bean_transction.getWeight());
/*                 
                     if (objck2.Return_value() == 0 || objck.Return_value() == -5) {
                     Obj_warehouse.Select_Twarehouse_data(j == 3 ? objAL.get(i).getWh_out() : objAL.get(i).getWh_in(), j == 3 ? objAL.get(i).getLocation_doc_id() : objAL.get(i).getLocation_id(), Bean_transction.getProduct_id());
                     //Bean_transction.setCost_per_unit(Obj_warehouse.price);
                     Bean_transction.setCost_per_unit("0.00");
                     Bean_transction.setWh_value(j == 1 || j == 3 ? objcal.Product_value(Obj_warehouse.wh_value, objcal.RawMat_value(Obj_warehouse.price, objAL.get(i).getWeight()), Bean_transction.getDoc_type()) : objcal.RawMat_value(Obj_warehouse.price, objAL.get(i).getWeight()));
                     Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
                     } else {
                     Obj_warehouse.Select_Twarehouse_data(objAL.get(i).getWh_in(), objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id());
                     Bean_warehouse.setBy(objAL.get(i).getBy());
                     Bean_warehouse.setDate(objAL.get(i).getDate());
                     Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                     Bean_warehouse.setLocation_id(objAL.get(i).getLocation_doc_id());
                     Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                     Bean_warehouse.setWeight(objAL.get(i).getWeight());
                     Bean_warehouse.setPrice(Obj_warehouse.price);
                     Bean_warehouse.setWh_value(objcal.RawMat_value(Obj_warehouse.price, objAL.get(i).getWeight()));
                     Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
                     }
                     */

                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                }

                Bean_transction.setDoc_type("-");
                //Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                //obj_total.T_warehouse_item_total(Bean_transction, con);
                Bean_transction.setDoc_type("+");
                //Bean_transction.setLocation_id(objAL.get(i).getLocation_doc_id());
                //obj_total.T_warehouse_item_total(Bean_transction, con);
                Bean_transction.setDoc_type("-");
                Bean_transction.setWh_in(objAL.get(i).getWh_out());
                //obj_total.T_warehouse_item_total(Bean_transction, con);
                Bean_transction.setWh_in(objAL.get(i).getWh_in());
                //obj_total.T_warehouse_total_product(Bean_transction, con);
                //D_cost_productDAO objcost = new D_cost_productDAO();
                //objcost.D_cost_product(Bean_transction);
                objAL.get(i).setComplate_falg("Y");
                System.out.println("objAL = " + objAL);
            } else {
                DataBeanError_Stock_Item beanerror = new DataBeanError_Stock_Item();
                beanerror.setLine_no(objAL.get(i).getLine_no());
                beanerror.setDoc_id(objAL.get(i).getDoc_id());
                beanerror.setStatus(objck.Return_value() + "");
                objAL_error.add(beanerror);
            }

        }
        Update_Complete_flag(objAL);
        if (con != null) {
            con.close();
        }
    }

    public static void Stedment_PR_042(ArrayList<DataBeanCS_048> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        for (int i = 0; i < objAL.size(); i++) {
            Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
            if (objck.Return_value() == 0) {
                ///*******************Begin Transction ************************
                Bean_transction.setBy(objAL.get(i).getBy());
                Bean_transction.setDate(objAL.get(i).getDate());
                Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                Bean_transction.setWeight(objAL.get(i).getWeight());
                Bean_transction.setWh_in(objAL.get(i).getWh_in());
                Bean_transction.setWh_out(objAL.get(i).getWh_out());
                Bean_transction.setJob_id(objAL.get(i).getJob_id());
                Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                Bean_transction.setDoc_type("-");
                Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                //Bean_transction.setDoc_type("+");
                //Bean_transction.setLocation_id(objAL.get(i).getLocation_doc_id());
                //Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                //*********************Beging Warehouse ************************
                for (int j = 1; j <= 2; j++) {
                    Bean_transction.setDoc_type(j == 1 ? "-" : "+");
                    Bean_transction.setLocation_id(j == 1 ? objAL.get(i).getLocation_id() : objAL.get(i).getLocation_doc_id());
                    Chk_T_warehouse_item objck2 = new Chk_T_warehouse_item(Bean_transction.getLocation_id(), Bean_transction.getProduct_id(), j == 1 ? Bean_transction.getWh_in() : Bean_transction.getWh_out(), Bean_transction.getWeight());
                    if (objck2.Return_value() == 0 || objck.Return_value() == -5) {
                        Bean_transction.setCost_per_unit("0.00");
                        Bean_transction.setWh_value("0.00");
                        Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
                    } else {
                        Bean_warehouse.setBy(objAL.get(i).getBy());
                        Bean_warehouse.setDate(objAL.get(i).getDate());
                        Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                        Bean_warehouse.setLocation_id(objAL.get(i).getLocation_doc_id());//ตรงนี้ได้เท่ากับ -
                        Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                        Bean_warehouse.setWeight(objAL.get(i).getWeight());
                        Bean_warehouse.setPrice("0.00");
                        Bean_warehouse.setWh_value("0.00");
                        Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
                    }

                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                }
                Bean_transction.setDoc_type("-");
                obj_total.T_warehouse_item_total(Bean_transction, con);
                Bean_transction.setDoc_type("+");
                obj_total.T_warehouse_item_total(Bean_transction, con);
                obj_total.T_warehouse_total_product(Bean_transction, con);
                D_cost_productDAO objcost = new D_cost_productDAO();
                objcost.D_cost_product(Bean_transction);
                objAL.get(i).setComplate_falg("Y");

            } else {
                DataBeanError_Stock_Item beanerror = new DataBeanError_Stock_Item();
                beanerror.setLine_no(objAL.get(i).getLine_no());
                beanerror.setDoc_id(objAL.get(i).getDoc_id());
                beanerror.setStatus(objck.Return_value() + "");
                objAL_error.add(beanerror);
            }

        }
        Update_Complete_flag(objAL);
        if (con != null) {
            con.close();
        }
    }

    public static void Stedment_PR_Other(ArrayList<DataBeanCS_048> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        for (int i = 0; i < objAL.size(); i++) {
            Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
            if (objck.Return_value() == 0) {
                ///*******************Begin Transction ************************
                Bean_transction.setBy(objAL.get(i).getBy());
                Bean_transction.setDate(objAL.get(i).getDate());
                Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                Bean_transction.setWeight(objAL.get(i).getWeight());
                Bean_transction.setWh_in(objAL.get(i).getWh_in());
                Bean_transction.setWh_out(objAL.get(i).getWh_out());
                Bean_transction.setJob_id(objAL.get(i).getJob_id());
                Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                Bean_transction.setDoc_type("-");
                Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                Bean_transction.setDoc_type("+");
                Bean_transction.setLocation_id(objAL.get(i).getLocation_doc_id());
                Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                //*********************Beging Warehouse ************************
                for (int j = 1; j <= 2; j++) {
                    Bean_transction.setDoc_type(j == 1 ? "-" : "+");
                    Bean_transction.setLocation_id(j == 1 ? objAL.get(i).getLocation_id() : objAL.get(i).getLocation_doc_id());
                    Chk_T_warehouse_item objck2 = new Chk_T_warehouse_item(Bean_transction.getLocation_id(), Bean_transction.getProduct_id(), j == 1 ? Bean_transction.getWh_in() : Bean_transction.getWh_out(), Bean_transction.getWeight());
                    if (objck2.Return_value() == 0 || objck.Return_value() == -5) {
                        Bean_transction.setCost_per_unit("0.00");
                        Bean_transction.setWh_value("0.00");
                        Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
                    } else {
                        Bean_warehouse.setBy(objAL.get(i).getBy());
                        Bean_warehouse.setDate(objAL.get(i).getDate());
                        Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                        Bean_warehouse.setLocation_id(objAL.get(i).getLocation_doc_id());//ตรงนี้ได้เท่ากับ -
                        Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                        Bean_warehouse.setWeight(objAL.get(i).getWeight());
                        Bean_warehouse.setPrice("0.00");
                        Bean_warehouse.setWh_value("0.00");
                        Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
                    }

                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                }
                Bean_transction.setDoc_type("-");
                obj_total.T_warehouse_item_total(Bean_transction, con);
                Bean_transction.setDoc_type("+");
                obj_total.T_warehouse_item_total(Bean_transction, con);
                obj_total.T_warehouse_total_product(Bean_transction, con);
                D_cost_productDAO objcost = new D_cost_productDAO();
                objcost.D_cost_product(Bean_transction);
                objAL.get(i).setComplate_falg("Y");

            } else {
                DataBeanError_Stock_Item beanerror = new DataBeanError_Stock_Item();
                beanerror.setLine_no(objAL.get(i).getLine_no());
                beanerror.setDoc_id(objAL.get(i).getDoc_id());
                beanerror.setStatus(objck.Return_value() + "");
                objAL_error.add(beanerror);
            }

        }
        Update_Complete_flag(objAL);
        if (con != null) {
            con.close();
        }
    }

    public static void Stedment_PR_Other2(ArrayList<DataBeanCS_048> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        try {
            for (int i = 0; i < objAL.size(); i++) {
                Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
                if (objck.Return_value() == 0 && objAL.get(i).getDoc_type().equals("-")) {
                    //************************Begin Transceaction ***************************
                    Bean_transction.setBy(objAL.get(i).getBy());
                    Bean_transction.setDate(objAL.get(i).getDate());
                    Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                    Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                    Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                    Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                    Bean_transction.setWeight(objAL.get(i).getWeight());
                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                    Bean_transction.setWh_out(objAL.get(i).getWh_out());
                    Bean_transction.setJob_id(objAL.get(i).getJob_id());
                    Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                    Bean_transction.setDoc_type(objAL.get(i).getDoc_type());
                    Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                    Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                    //*********************Begin Warehouse****************************
                    Chk_T_warehouse_item objck2 = new Chk_T_warehouse_item(Bean_transction.getLocation_id(), Bean_transction.getProduct_id(), objAL.get(i).getDoc_type().equals("-") ? Bean_transction.getWh_in() : Bean_transction.getWh_out(), Bean_transction.getWeight());
                    if (objck2.Return_value() == 0 || objck.Return_value() == -5) {
                        Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
                    } else {
                        Bean_warehouse.setBy(objAL.get(i).getBy());
                        Bean_warehouse.setDate(objAL.get(i).getDate());
                        Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                        Bean_warehouse.setLocation_id(objAL.get(i).getLocation_id());//ตรงนี้ได้เท่ากับ -
                        Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                        Bean_warehouse.setWeight(objAL.get(i).getWeight());
                        Bean_warehouse.setPrice("0.00");
                        Bean_warehouse.setWh_value("0.00");
                        Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
                    }
                    //*****************************************************************
                    obj_total.T_warehouse_item_total(Bean_transction, con);
                    obj_total.T_warehouse_total_product(Bean_transction, con);
                    objAL.get(i).setComplate_falg("Y");
                } else if (objAL.get(i).getDoc_type().equals("+") && (new UtiDatabase().numRowdatabase("select count(*) as num from mproduct where product_id = '" + objAL.get(i).getProduct_id() + "' and delete_flag = 'N'") != 0)) {
                    //************************Begin Transceaction ***************************
                    Bean_transction.setBy(objAL.get(i).getBy());
                    Bean_transction.setDate(objAL.get(i).getDate());
                    Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                    Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                    Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                    Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                    Bean_transction.setWeight(objAL.get(i).getWeight());
                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                    Bean_transction.setWh_out(objAL.get(i).getWh_out());
                    Bean_transction.setJob_id(objAL.get(i).getJob_id());
                    Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                    Bean_transction.setDoc_type(objAL.get(i).getDoc_type());
                    Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                    Obj_transction.InsertT_transaction_stock(Bean_transction, con);
                    //*********************Begin Warehouse****************************
                    Chk_T_warehouse_item objck2 = new Chk_T_warehouse_item(Bean_transction.getLocation_id(), Bean_transction.getProduct_id(), objAL.get(i).getDoc_type().equals("-") ? Bean_transction.getWh_in() : Bean_transction.getWh_out(), Bean_transction.getWeight());
                    if (objck2.Return_value() == 0 || objck.Return_value() == -5) {
                        Obj_warehouse.UpdateT_warehouse_item(Bean_transction, con);
                    } else {
                        Bean_warehouse.setBy(objAL.get(i).getBy());
                        Bean_warehouse.setDate(objAL.get(i).getDate());
                        Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                        Bean_warehouse.setLocation_id(objAL.get(i).getLocation_id());//ตรงนี้ได้เท่ากับ -
                        Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                        Bean_warehouse.setWeight(objAL.get(i).getWeight());
                        Bean_warehouse.setPrice("0.00");
                        Bean_warehouse.setWh_value("0.00");
                        Obj_warehouse.InsertT_warehouse_item(Bean_warehouse, con);
                    }
                    //*****************************************************************
                    obj_total.T_warehouse_item_total(Bean_transction, con);
                    obj_total.T_warehouse_total_product(Bean_transction, con);
                    objAL.get(i).setComplate_falg("Y");
                } else {
                    DataBeanError_Stock_Item beanerror = new DataBeanError_Stock_Item();
                    beanerror.setLine_no(objAL.get(i).getLine_no());
                    beanerror.setDoc_id(objAL.get(i).getDoc_id());
                    beanerror.setStatus((objAL.get(i).getDoc_type().equals("+") ? -4 : objck.Return_value()) + "");
                    objAL_error.add(beanerror);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            Update_Complete_flag(objAL);
            if (con != null) {
                con.close();
            }
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
                if (objAL.get(i).getProcess_id().equals("PR_022")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail();
                    SQL += " Set complete_flag = 'Y'";
                    SQL += ",line_no = 1";
                    SQL += ",wh_weight_final = '" + objAL.get(i).getWeight();
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();
                    SQL += "' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' ";
                } else if (objAL.get(i).getProcess_id().equals("PR_023") || objAL.get(i).getProcess_id().equals("PR_027")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail();
                    SQL += " Set complete_flag = 'Y'";
                    SQL += ",wh_weight_final = '" + objAL.get(i).getWeight();
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N' ";
                } else if (objAL.get(i).getProcess_id().equals("PR_042")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail();
                    SQL += " Set complete_flag = '" + objAL.get(i).getComplate_falg();
                    SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                } else if (objAL.get(i).getProcess_id().equals("PR_115")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail();
                    SQL += " Set complete_flag = '" + objAL.get(i).getComplate_falg();
                    SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                } else {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail() + " Set complete_flag = '" + objAL.get(i).getComplate_falg();
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                }

                System.out.println("SQL = " + SQL);

                /*
                 SQL = (objAL.get(i).getProcess_id().equals("PR_022"))
                 ? "UPDATE " + objAL.get(i).getTable_detail() + " Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' "
                 : "UPDATE " + objAL.get(i).getTable_detail() + " Set complete_flag = '" + objAL.get(i).getComplate_falg() + "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                 */
                p = con.prepareStatement(SQL);
                p.setString(1, objAL.get(i).getDoc_id());
                if (!objAL.get(i).getProcess_id().equals("PR_022")) {
                    p.setString(2, objAL.get(i).getLine_no());
                }
                p.executeUpdate();
            }

            SQL_num = (objAL.isEmpty())
                    ? null
                    : "SELECT count(doc_id) as num From " + objAL.get(0).getTable_detail() + " WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
            System.out.println("SQL_num = " + SQL_num);
            if (SQL_num != null) {
                if (objuti.numRowdatabase(SQL_num) == 0) {
                    p = null;
                    SQL = "UPDATE " + objAL.get(0).getTable_header() + " Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' ";
                    System.out.println("Update Rawmat SQL = " + SQL);
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(0).getDoc_id());
                    p.executeUpdate();
                    if (objAL.get(0).getProcess_id().equals("PR_022") && objAL.get(0).getComplate_falg().equals("Y")) {
                        for (int i = 1; i <= 2; i++) {
                            SQL = (i == 1)
                                    ? "UPDATE d_rawmatt_analyze_detail Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' "
                                    : "UPDATE d_rawmatt_analyze_header Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N'";
                            System.out.println("SQL d_rawmatt_analyze_detail = " + SQL);
                            p = con.prepareStatement(SQL);
                            p.setString(1, objAL.get(0).getDoc_id());
                            p.executeUpdate();
                        }
                    } /*else if (objAL.get(0).getProcess_id().equals("PR_042")) {
                     SQL_num = "SELECT count(doc_id) as num From " + objAL.get(0).getTable_detail() + " WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
                     if (objuti.numRowdatabase(SQL_num) == 0) {
                     for (int i = 1; i <= 2; i++) {
                     SQL = (i == 1)
                     ? "UPDATE d_job_order_header Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' "
                     : "UPDATE d_job_order_detail Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N'";
                     p = con.prepareStatement(SQL);
                     p.setString(1, objAL.get(0).getJob_id());
                     p.executeUpdate();
                     }
                     }
                     }*/

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

    public String showDetail(String Process_id, String Doc_id, String Tablename) throws Exception {
        count = 1;
        objuti = new UtiDatabase();
        Process_ShowDetail objprocess = new Process_ShowDetail(Process_id);
        SQL = "SELECT * FROM " + Tablename + " WHERE doc_id = '" + Doc_id + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        
//        System.out.println("SQL =" + SQL );
        
        if (!Process_id.equals("PR_022")) {
            SQL += " order by to_number(line_no,'9999')";
        }
        String strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            System.out.println("Process_id = " + Process_id);
            System.out.println("Detail SQL = " + SQL);
            while (rs.next()) {

                //System.out.append("Location =" + rs.getString("location_id"));
                strOutput += "<tr>\n";
                strOutput += (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='1%'><input type='checkbox' id='ckbox_" + count + "' name='ckbox' value ='" + count + "' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>\n"
                        : "<td class='forborder' width='1%'><input type='checkbox' id='ckbox_" + rs.getString("line_no") + "' name='ckbox' value ='" + rs.getString("line_no") + "' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>\n";
                strOutput += (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='2%'>" + count + "</td>\n"
                        : "<td class='forborder' width='2%'>" + rs.getString("line_no") + "</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("doc_id") + "</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("doc_date") + "</td>\n";
                strOutput += (Process_id.equals("PR_040") || Process_id.equals("PR_042"))
                        ? "<td class='forborder' width='10%'>" + rs.getString("job_id") + "<input type = 'hidden' id='job_id_" + rs.getString("line_no") + "' name = 'job_id' value = '" + rs.getString("job_id") + "'></td>\n"
                        : (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='8%'>-<input type = 'hidden' id='job_id_" + count + "' name = 'job_id' value = '-'></td>\n"
                        : "<td class='forborder' width='8%'>-<input type = 'hidden' id='job_id_" + rs.getString("line_no") + "' name = 'job_id' value = '-'></td>\n";
                strOutput += (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='8%'>" + rs.getString(objprocess.Return_FillProduct_id()) + "<input type='hidden' id='product_doc_id_" + count + "' name = 'product_doc_id' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "'></td>\n"
                        : "<td class='forborder' width='8%'>" + rs.getString(objprocess.Return_FillProduct_id()) + "<input type='hidden' id='product_doc_id_" + rs.getString("line_no") + "' name = 'product_doc_id' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "'></td>\n";

                //strOutput += "<td class='forborder' width='10%'>" + rs.getString(objprocess.Return_FillProduct_id()) + "<input type='hiden' id></td>\n";
                strOutput += "<td class='forborder' width='8%'>" + rs.getString(objprocess.Return_FillWeight()) + "</td>\n";
                strOutput += (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='18%'><input type='text' id='product_id_" + count + "' name = 'product_id' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "' size = 16><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_id_" + count + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n"
                        : "<td class='forborder' width='18%'><input type='text' id='product_id_" + rs.getString("line_no") + "' name = 'product_id' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "' size = 16><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_id_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n";
                strOutput += (Process_id.equals("PR_022") || Process_id.equals("PR_023") || Process_id.equals("PR_027"))
                        ? "<td class='forborder' width='7%'><input type = 'text' id = 'location_id_" + count + "' name = 'location_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "' size = 5>"
                        + "<input type='hidden' id='location_doc_id_" + rs.getString("line_no") + "' name='location_doc_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "'></td>\n"
                        : (Process_id.equals("PR_115"))
                        ? "<td class='forborder' width='7%'><input type = 'text' id = 'location_id_" + rs.getString("line_no") + "' name = 'location_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "' size = 5>"
                        + "<input type='hidden' id='location_doc_id_" + rs.getString("line_no") + "' name='location_doc_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "'></td>\n"
                        : "<td class='forborder' width='7%'><input type = 'text' id = 'location_id_" + rs.getString("line_no") + "' name = 'location_id' value = '' size = 5>"
                        + "<input type='hidden' id='location_doc_id_" + rs.getString("line_no") + "' name='location_doc_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "'></td>\n";
                strOutput += (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='10%'><input type='text' id='warehouse_id_" + count + "' name = 'warehouse_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillWarehouse_id())) + "' size = 5 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_id_" + count + "', 48, 'Search_Detail.jsp')\"></a></td>\n"
                        : "<td class='forborder' width='10%'><input type='text' id='warehouse_id_" + rs.getString("line_no") + "' name = 'warehouse_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillWarehouse_id())) + "' size = 5 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_id_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\"></a>"
                        + "<input type='hidden' id='warehouse_in_" + rs.getString("line_no") + "' name = 'warehouse_in' value = '" + objuti.NotNull(rs.getString(objprocess.Return_FillWarehouse_in())) + "' size = 5></td>\n";
                strOutput += (Process_id.equals("PR_022"))
                        ? "<td class='forborder' width='10%'><input type='text' id='weight_" + count + "' name = 'weight' value = '" + rs.getString(objprocess.Return_FillWeight()) + "'  onKeyUp=\'IsNuber(this.value, this)\'  size = 9><input type='hidden' id='total_price_" + count + "' name = 'total_price' value = '" + rs.getString(objprocess.Return_FillTotal_price()) + "'></td>\n"
                        + "<input type='hidden' id='weight_doc_id_" + count + "' name = 'weight_doc_id' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' ></td>\n"
                        : "<td class='forborder' width='10%'><input type='text' id='weight_" + rs.getString("line_no") + "' name = 'weight' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' onKeyUp=\'IsNuber(this.value, this)\' size = 9></td>\n"
                        + "<input type='hidden' id='weight_doc_id_" + rs.getString("line_no") + "' name = 'weight_doc_id' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' ></td>\n";
                strOutput += (Process_id.equals("PR_115"))
                        ? "<input type='hidden' id='doc_type_" + rs.getString("line_no") + "' name = 'doc_type' value = '" + rs.getString("doc_type") + "' ></td>\n"
                        : "";
                strOutput += "</tr>\n";

                if (Process_id.equals("PR_115")) {
                    System.out.println(strOutput);
                }

                count++;
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
        strOutput += "</table>";
        return strOutput;
    }

    public String Alert_Return() {
        String Alert = "";
        if (objAL_error.isEmpty()) {
            Alert = "ทำการอนุมัติเอกสารสมบูรณ์";
        } else {
            for (int i = 0; i < objAL_error.size(); i++) {
                Alert += "ลำดับที่ " + objAL_error.get(i).getLine_no()
                        + " รหัสเอกสารที่ " + objAL_error.get(i).getDoc_id()
                        + " ไม่สามารถทำรายการนี้ได้เนื่องจาก = "
                        + objAL_error.get(i).getStatus() + "\n";
            }
        }
        objAL_error.clear();
        return Alert;
    }
}
