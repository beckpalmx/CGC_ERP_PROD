/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.bean.DataBeanCS_048;
import com.cgc.bean.DataBeanCS_049;
import com.cgc.bean.DataBeanCS_050;
import com.cgc.bean.DataBeanCS_051;
import com.cgc.bean.DataBeanCS_052;
import com.cgc.bean.DataBeanD_cost_product;
import com.cgc.bean.DataBeanMSTD_COST_SUB;
import com.cgc.bean.DataBeanT_transaction_stock;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_cost_productDAO {
    private String weight;
    private String wh_value;
    private String price;
    //****************** ทำการเลือก std_id จาก mstd_cost_sub ***************************************
    public ArrayList<DataBeanMSTD_COST_SUB> SelectMstd_cost_sub(String std_id) throws Exception {
        ArrayList<DataBeanMSTD_COST_SUB> objAL = new ArrayList<DataBeanMSTD_COST_SUB>();
        String SQl = "Select * From mstd_cost_sub where std_id = '" + std_id + "' and delete_flag <> 'Y'";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQl);
            while (rs.next()) {
                DataBeanMSTD_COST_SUB objbean = new DataBeanMSTD_COST_SUB();
                objbean.setStd_id(std_id);
                objbean.setStd_sub_id(rs.getString("std_sub_id"));
                objbean.setCost_value(rs.getString("cost_value"));
                objbean.setDriver_id(rs.getString("driver_id"));
                objbean.setOh_id(rs.getString("oh_id"));
                objbean.setDoc_type(rs.getString("doc_type"));
                objAL.add(objbean);
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
        return objAL;

    }
    //************************* ทำการ เลือก str_id จาก mstd_cost_main ********************************

    public String[] Select_Std_id(String Process_id) throws Exception {
        String str_sprit = "";
        String SQL = "Select std_id From mstd_cost_main where process_id ='" + Process_id + "' and delete_flag <> 'Y'";
        String[] strReturn = new String[]{};
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                str_sprit += rs.getString("std_id") + ",";
            }
            if (str_sprit.length() != 0) {
                strReturn = str_sprit.split(",");
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
        return strReturn;
    }
    //*************************บันทึกข้อมูลลง d_cost_product*************************************

    public void Insert_D_cost_product(DataBeanD_cost_product dataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String SQL =
                "Insert into d_cost_product"
                + "(doc_id,doc_date,job_id,process_id,std_id,std_sub_id,cost_value,oh_id,driver_id,rawmat_cost,overhead_cost,create_by,create_date,total_cost) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        PreparedStatement p = null;
        try {
            p = con.prepareStatement(SQL);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getJob_id());
            p.setString(4, dataBean.getProcess_id());
            p.setString(5, dataBean.getStd_id());
            p.setString(6, dataBean.getStd_sub_id());
            p.setString(7, dataBean.getCost_value());
            p.setString(8, dataBean.getOh_id());
            p.setString(9, dataBean.getDriver_id());
            p.setString(10, dataBean.getRawmat_cost() == null? "0.00":dataBean.getRawmat_cost());
            p.setString(11, dataBean.getOverhead_cost()==null?"0.00":dataBean.getOverhead_cost());
            p.setString(12, dataBean.getBy());
            p.setTimestamp(13, dataBean.getDate());
            p.setString(14, dataBean.getTotal_cost());
            p.executeUpdate();
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
    //********************คิดราคา ต่อ หน่วย***********************

    /*public String CostCal(String cost_value, String weight) {
    return Double.toString(Double.parseDouble(cost_value) * Double.parseDouble(weight));
    }*/
    //*********************************การทำงาน**************************
    public void D_cost_product(DataBeanT_transaction_stock obj_Transaction) throws Exception {
        Calculator_T_warehouse_item objcal = new Calculator_T_warehouse_item();
        ArrayList<DataBeanMSTD_COST_SUB> obj_cost_sub = new ArrayList<DataBeanMSTD_COST_SUB>();
        String[] str_std_id = Select_Std_id(obj_Transaction.getProcess_id());
        for (int i = 0; i < str_std_id.length; i++) {
            obj_cost_sub = SelectMstd_cost_sub(str_std_id[i]);
            for (DataBeanMSTD_COST_SUB bean : obj_cost_sub) {
                DataBeanD_cost_product objbean = new DataBeanD_cost_product();
                objbean.setDoc_id(obj_Transaction.getDoc_id());
                objbean.setDoc_date(obj_Transaction.getDoc_date());
                objbean.setProcess_id(obj_Transaction.getProcess_id());
                objbean.setJob_id(obj_Transaction.getJob_id());
                objbean.setStd_id(bean.getStd_id());
                objbean.setStd_sub_id(bean.getStd_sub_id());
                objbean.setOh_id(bean.getOh_id());
                objbean.setDriver_id(bean.getDriver_id());
                objbean.setBy(obj_Transaction.getBy());
                objbean.setDate(obj_Transaction.getDate());
                if (bean.getDoc_type().equals("N")) {
                    objbean.setOverhead_cost(bean.getCost_value());
                    objbean.setCost_value(bean.getCost_value());
                    objbean.setTotal_cost(bean.getCost_value());
                } else {
                    Select_Twarehouse_data(obj_Transaction.getWh_out(), obj_Transaction.getLocation_id(), obj_Transaction.getProduct_id());
                    objbean.setRawmat_cost(obj_Transaction.getWeight());
                    bean.setCost_value(price);
                    objbean.setTotal_cost(objcal.RawMat_value(price,obj_Transaction.getWeight()));
                }
                objbean.setCost_value(bean.getCost_value());
                Insert_D_cost_product(objbean);
            }
            obj_cost_sub.clear();

        }
    }
    //**************************************************************************

    public void D_cost_product048() {
    }

    public void D_cost_product049() {
    }

    public void D_cost_product050() {
    }

    public void D_cost_product051() {
    }

    public void D_cost_product052() {
    }
    public void Select_Twarehouse_data(String warehouse_id, String location_id, String product_id) throws Exception {
        weight = "0";
        price = "0";
        wh_value = "0";
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
