/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.bean.DataBeanD_carbon_friction_receive_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanMemD_carbon_friction_receive;
import com.cgc.bean.DataBeanT_transaction_stock;
import com.cgc.bean.DataBeanT_warehouse_item;
import com.cgc.bean.DataBeanError_Stock_Item;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_friction_receive_headerDAO {

    public static String by;
    public static Timestamp date;
    private int Returnvalue;
    public static ArrayList<DataBeanMemD_carbon_friction_receive> ObjMem_AL = new ArrayList<>();
    public static ArrayList<DataBeanError_Stock_Item> objError_AL = new ArrayList<>();

    public int insert(DataBeanD_carbon_friction_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_friction_receive_header "
                + "(doc_id,time_from,time_to,runner_id,shift,wh_in,wh_out,loc_total,loc_1,s_bag_loc1,q_bag_loc1,w_bag_loc1,loc_1_desc,loc_2,s_bag_loc2,q_bag_loc2,w_bag_loc2,loc_2_desc,loc_3,s_bag_loc3,q_bag_loc3,w_bag_loc3,loc_3_desc,c_weight1,c_weight2,c_weight3,c_weight4,c_weight5,u_weight1,u_weight2,u_weight3,u_weight4,u_weight5,p_weight1,p_weight2,p_weight3,p_weight4,p_weight5,remark,doc_date,create_date,update_date,create_by,c_weight6,p_weight6,u_weight6,loc_c1,loc_c2,loc_c3,loc_c4,loc_c5,loc_c6,loc_p1,loc_p2,loc_p3,loc_p4,loc_p5,loc_p6,loc_u1,loc_u2,loc_u3,loc_u4,loc_u5,loc_u6,c_bag_qty,c_bag_weight,p_bag_qty,p_bag_weight,u_bag_qty,u_bag_weight,c_bag_qty1,c_bag_weight1,p_bag_qty1,p_bag_weight1,u_bag_qty1,u_bag_weight1) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p ;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getTime_from());
            p.setString(3, dataBean.getTime_to());
            p.setString(4, dataBean.getRunner_id());
            p.setString(5, dataBean.getShift());
            p.setString(6, dataBean.getWh_in());
            p.setString(7, dataBean.getWh_out());
            p.setString(8, dataBean.getLoc_total());
            p.setString(9, dataBean.getLoc_1());
            p.setString(10, dataBean.getS_bag_loc1());
            p.setString(11, dataBean.getQ_bag_loc1());
            p.setString(12, dataBean.getW_bag_loc1());
            p.setString(13, dataBean.getLoc_1_desc());
            p.setString(14, dataBean.getLoc_2());
            p.setString(15, dataBean.getS_bag_loc2());
            p.setString(16, dataBean.getQ_bag_loc2());
            p.setString(17, dataBean.getW_bag_loc2());
            p.setString(18, dataBean.getLoc_2_desc());
            p.setString(19, dataBean.getLoc_3());
            p.setString(20, dataBean.getS_bag_loc3());
            p.setString(21, dataBean.getQ_bag_loc3());
            p.setString(22, dataBean.getW_bag_loc3());
            p.setString(23, dataBean.getLoc_3_desc());
            p.setString(24, dataBean.getC_weight1());
            p.setString(25, dataBean.getC_weight2());
            p.setString(26, dataBean.getC_weight3());
            p.setString(27, dataBean.getC_weight4());
            p.setString(28, dataBean.getC_weight5());
            p.setString(29, dataBean.getU_weight1());
            p.setString(30, dataBean.getU_weight2());
            p.setString(31, dataBean.getU_weight3());
            p.setString(32, dataBean.getU_weight4());
            p.setString(33, dataBean.getU_weight5());
            p.setString(34, dataBean.getP_weight1());
            p.setString(35, dataBean.getP_weight2());
            p.setString(36, dataBean.getP_weight3());
            p.setString(37, dataBean.getP_weight4());
            p.setString(38, dataBean.getP_weight5());
            p.setString(39, dataBean.getRemark());
            p.setString(40, dataBean.getDoc_date());
            p.setTimestamp(41, dataBean.getDate());
            p.setTimestamp(42, dataBean.getDate());
            p.setString(43, dataBean.getBy());
            p.setString(44, dataBean.getC_weight6());
            p.setString(45, dataBean.getU_weight6());
            p.setString(46, dataBean.getP_weight6());
            p.setString(47, dataBean.getLoc_c1());
            p.setString(48, dataBean.getLoc_c2());
            p.setString(49, dataBean.getLoc_c3());
            p.setString(50, dataBean.getLoc_c4());
            p.setString(51, dataBean.getLoc_c5());
            p.setString(52, dataBean.getLoc_c6());
            p.setString(53, dataBean.getLoc_p1());
            p.setString(54, dataBean.getLoc_p2());
            p.setString(55, dataBean.getLoc_p3());
            p.setString(56, dataBean.getLoc_p4());
            p.setString(57, dataBean.getLoc_p5());
            p.setString(58, dataBean.getLoc_p6());
            p.setString(59, dataBean.getLoc_u1());
            p.setString(60, dataBean.getLoc_u2());
            p.setString(61, dataBean.getLoc_u3());
            p.setString(62, dataBean.getLoc_u4());
            p.setString(63, dataBean.getLoc_u5());
            p.setString(64, dataBean.getLoc_u6());
            p.setString(65, dataBean.getC_bag_qty());
            p.setString(66, dataBean.getC_bag_weight());
            p.setString(67, dataBean.getP_bag_qty());
            p.setString(68, dataBean.getP_bag_weight());
            p.setString(69, dataBean.getU_bag_qty());
            p.setString(70, dataBean.getU_bag_weight());
            p.setString(71, dataBean.getC_bag_qty1());
            p.setString(72, dataBean.getC_bag_weight1());
            p.setString(73, dataBean.getP_bag_qty1());
            p.setString(74, dataBean.getP_bag_weight1());
            p.setString(75, dataBean.getU_bag_qty1());
            p.setString(76, dataBean.getU_bag_weight1());
            //p.setString(77, dataBean.getComplete_flag());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_friction_receive_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_friction_receive_detail set doc_date=?,wh_in=?,wh_out=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                //p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if (dataBean.getComplete_flag().equals("Y")) {
                by = dataBean.getBy();
                date = dataBean.getDate();
                Mem_Detail(dataBean.getDoc_id(), dataBean.getDoc_date(), con);
                Mem_Header(dataBean.getDoc_id(), dataBean.getDoc_date(), con);
                Stadment_Stock_Item(con);
                Update_Complete(dataBean, con);
                ObjMem_AL.clear();
            }
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_friction_receive_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_carbon_friction_receive_header set  "
                + "time_from=?,time_to=?,runner_id=?,shift=?,wh_in=?,wh_out=?,loc_total=?,loc_1=?,s_bag_loc1=?,q_bag_loc1=?,w_bag_loc1=?,loc_1_desc=?,loc_2=?,s_bag_loc2=?,q_bag_loc2=?,w_bag_loc2=?,loc_2_desc=?,loc_3=?,s_bag_loc3=?,q_bag_loc3=?,w_bag_loc3=?,loc_3_desc=?,c_weight1=?,c_weight2=?,c_weight3=?,c_weight4=?,c_weight5=?,u_weight1=?,u_weight2=?,u_weight3=?,u_weight4=?,u_weight5=?,p_weight1=?,p_weight2=?,p_weight3=?,p_weight4=?,p_weight5=?,remark=?,doc_date=?,update_date=?,update_by=?,c_weight6=?,p_weight6=?,u_weight6=?,loc_c1=?,loc_c2=?,loc_c3=?,loc_c4=?,loc_c5=?,loc_c6=?,loc_p1=?,loc_p2=?,loc_p3=?,loc_p4=?,loc_p5=?,loc_p6=?,loc_u1=?,loc_u2=?,loc_u3=?,loc_u4=?,loc_u5=?,loc_u6=?"
                + ",c_bag_qty=?,c_bag_weight=?,p_bag_qty=?,p_bag_weight=?,u_bag_qty=?,u_bag_weight=?,c_bag_qty1=?,c_bag_weight1=?,p_bag_qty1=?,p_bag_weight1=?,u_bag_qty1=?,u_bag_weight1=?"
                + " where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p ;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getTime_from());
            p.setString(2, dataBean.getTime_to());
            p.setString(3, dataBean.getRunner_id());
            p.setString(4, dataBean.getShift());
            p.setString(5, dataBean.getWh_in());
            p.setString(6, dataBean.getWh_out());
            p.setString(7, dataBean.getLoc_total());
            p.setString(8, dataBean.getLoc_1());
            p.setString(9, dataBean.getS_bag_loc1());
            p.setString(10, dataBean.getQ_bag_loc1());
            p.setString(11, dataBean.getW_bag_loc1());
            p.setString(12, dataBean.getLoc_1_desc());
            p.setString(13, dataBean.getLoc_2());
            p.setString(14, dataBean.getS_bag_loc2());
            p.setString(15, dataBean.getQ_bag_loc2());
            p.setString(16, dataBean.getW_bag_loc2());
            p.setString(17, dataBean.getLoc_2_desc());
            p.setString(18, dataBean.getLoc_3());
            p.setString(19, dataBean.getS_bag_loc3());
            p.setString(20, dataBean.getQ_bag_loc3());
            p.setString(21, dataBean.getW_bag_loc3());
            p.setString(22, dataBean.getLoc_3_desc());
            p.setString(23, dataBean.getC_weight1());
            p.setString(24, dataBean.getC_weight2());
            p.setString(25, dataBean.getC_weight3());
            p.setString(26, dataBean.getC_weight4());
            p.setString(27, dataBean.getC_weight5());
            p.setString(28, dataBean.getU_weight1());
            p.setString(29, dataBean.getU_weight2());
            p.setString(30, dataBean.getU_weight3());
            p.setString(31, dataBean.getU_weight4());
            p.setString(32, dataBean.getU_weight5());
            p.setString(33, dataBean.getP_weight1());
            p.setString(34, dataBean.getP_weight2());
            p.setString(35, dataBean.getP_weight3());
            p.setString(36, dataBean.getP_weight4());
            p.setString(37, dataBean.getP_weight5());
            p.setString(38, dataBean.getRemark());
            p.setString(39, dataBean.getDoc_date());
            p.setTimestamp(40, dataBean.getDate());
            p.setString(41, dataBean.getBy());
            p.setString(42, dataBean.getC_weight6());
            p.setString(43, dataBean.getU_weight6());
            p.setString(44, dataBean.getP_weight6());
            p.setString(45, dataBean.getLoc_c1());
            p.setString(46, dataBean.getLoc_c2());
            p.setString(47, dataBean.getLoc_c3());
            p.setString(48, dataBean.getLoc_c4());
            p.setString(49, dataBean.getLoc_c5());
            p.setString(50, dataBean.getLoc_c6());
            p.setString(51, dataBean.getLoc_p1());
            p.setString(52, dataBean.getLoc_p2());
            p.setString(53, dataBean.getLoc_p3());
            p.setString(54, dataBean.getLoc_p4());
            p.setString(55, dataBean.getLoc_p5());
            p.setString(56, dataBean.getLoc_p6());
            p.setString(57, dataBean.getLoc_u1());
            p.setString(58, dataBean.getLoc_u2());
            p.setString(59, dataBean.getLoc_u3());
            p.setString(60, dataBean.getLoc_u4());
            p.setString(61, dataBean.getLoc_u5());
            p.setString(62, dataBean.getLoc_u6());
            p.setString(63, dataBean.getC_bag_qty());
            p.setString(64, dataBean.getC_bag_weight());
            p.setString(65, dataBean.getP_bag_qty());
            p.setString(66, dataBean.getP_bag_weight());
            p.setString(67, dataBean.getU_bag_qty());
            p.setString(68, dataBean.getU_bag_weight());
            p.setString(69, dataBean.getC_bag_qty1());
            p.setString(70, dataBean.getC_bag_weight1());
            p.setString(71, dataBean.getP_bag_qty1());
            p.setString(72, dataBean.getP_bag_weight1());
            p.setString(73, dataBean.getU_bag_qty1());
            p.setString(74, dataBean.getU_bag_weight1());
            p.setString(75, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_friction_receive_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_friction_receive_detail set doc_date=?,wh_in=?,wh_out=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                //p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if (dataBean.getComplete_flag().equals("Y")) {
                by = dataBean.getBy();
                date = dataBean.getDate();
                Mem_Detail(dataBean.getDoc_id(), dataBean.getDoc_date(), con);
                Mem_Header(dataBean.getDoc_id(), dataBean.getDoc_date(), con);
                Stadment_Stock_Item(con);
                Update_Complete(dataBean, con);
                ObjMem_AL.clear();
            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_carbon_friction_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_friction_receive_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_carbon_friction_receive_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p ;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public static void Mem_Detail(String doc_id, String doc_date, Connection con) throws Exception {
        String SQL = "SELECT * FROM d_carbon_friction_receive_detail where doc_id = '" + doc_id + "' and doc_date = '" + doc_date + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        ResultSet rs;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBeanMemD_carbon_friction_receive objbean = new DataBeanMemD_carbon_friction_receive();
                objbean.setProcess_id("PR_025");
                objbean.setDoc_id(rs.getString("doc_id"));
                objbean.setDoc_date(rs.getString("doc_date"));
                objbean.setWh_in(rs.getString("wh_in"));
                objbean.setWh_out(rs.getString("silo_no"));
                objbean.setLocation_id(rs.getString("location_id"));
                objbean.setProduct_id(rs.getString("product_id"));
                objbean.setWeight(rs.getString("weight_balance"));
                objbean.setComplete_flag("N");
                objbean.setLine_no(rs.getString("line_no"));
                ObjMem_AL.add(objbean);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);

        } finally {
            //if (rs != null) {
            //rs.close();
            //}
        }
    }

    public static void Mem_Header(String doc_id, String doc_date, Connection con) throws Exception {
        String SQL = "select * from d_carbon_friction_receive_header where doc_id = '" + doc_id + "' and doc_date ='" + doc_date + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet rs;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                for (int i = 1; i <= Integer.parseInt(rs.getString("loc_total")); i++) {
                    DataBeanMemD_carbon_friction_receive objbean = new DataBeanMemD_carbon_friction_receive();
                    objbean.setProcess_id("PR_025");
                    objbean.setDoc_id(rs.getString("doc_id"));
                    objbean.setDoc_date(rs.getString("doc_date"));
                    objbean.setWh_in(rs.getString("wh_in"));
                    objbean.setWh_out(rs.getString("loc_" + i + "_desc"));
                    objbean.setLocation_id(rs.getString("loc_" + i));
                    objbean.setProduct_id((!ObjMem_AL.isEmpty()) ? ObjMem_AL.get(i - 1).getProduct_id() : "C");
                    objbean.setWeight(rs.getString("w_bag_loc" + i));
                    objbean.setComplete_flag("N");
                    objbean.setLine_no("header");
                    ObjMem_AL.add(objbean);
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace(System.out);
        } finally {
            //if (rs != null) {
            //rs.close();
            //}

        }

    }

    public static void Stadment_Stock_Item(Connection con) throws Exception {
        Calculator_T_warehouse_item obj_cal = new Calculator_T_warehouse_item();
        T_transaction_stockDAO objtransction = new T_transaction_stockDAO();
        T_warehouse_itemDAO objwarehouse = new T_warehouse_itemDAO();
        T_warehouse_item_totalDAO objwarehouse_total = new T_warehouse_item_totalDAO();
        for (int i = 0; i < ObjMem_AL.size(); i++) {
            //Chk_T_warehouse_item objck = new Chk_T_warehouse_item(ObjMem_AL.get(i).getLocation_id(), ObjMem_AL.get(i).getProduct_id(), ObjMem_AL.get(i).getWh_in(), ObjMem_AL.get(i).getWeight());
            //if (objck.Return_value() == 0) {
            //************** Begin  Transction *******************
            DataBeanT_transaction_stock beanTransction = new DataBeanT_transaction_stock();
            beanTransction.setDoc_id(ObjMem_AL.get(i).getDoc_id());
            beanTransction.setDoc_date(ObjMem_AL.get(i).getDoc_date());
            beanTransction.setProcess_id(ObjMem_AL.get(i).getProcess_id());
            beanTransction.setProduct_id(ObjMem_AL.get(i).getProduct_id());
            beanTransction.setLocation_id(ObjMem_AL.get(i).getLocation_id());
            beanTransction.setWeight(ObjMem_AL.get(i).getWeight());
            beanTransction.setWeight_withdraw(ObjMem_AL.get(i).getWeight());
            beanTransction.setWh_in(ObjMem_AL.get(i).getWh_in());
            beanTransction.setWh_out(ObjMem_AL.get(i).getWh_out());
            beanTransction.setDate(date);
            beanTransction.setBy(by);
            beanTransction.setJob_id("-");
            //***************Transction - ************
            //beanTransction.setDoc_type("-");
            //objtransction.InsertT_transaction_stock(beanTransction);
            //***************Transction + ************
            beanTransction.setDoc_type("+");
            objtransction.InsertT_transaction_stock(beanTransction, con);
                //*************** End Transction *******************

            //*************** Begin Warehouse ******************
            // for(int j = 1; j <= 2; j++){
            //beanTransction.setDoc_type((j == 1)?"-":"+");
            Chk_T_warehouse_item objchk_i_u_warehouse = new Chk_T_warehouse_item(beanTransction.getLocation_id(), beanTransction.getProduct_id(), beanTransction.getWh_out(), beanTransction.getWeight());
            if (objchk_i_u_warehouse.Return_value() == 0 || objchk_i_u_warehouse.Return_value() == -5) {
                objwarehouse.Select_Twarehouse_data("W002", "-", ObjMem_AL.get(i).getProduct_id());
                beanTransction.setCost_per_unit(objwarehouse.price.isEmpty() ? "0.00" : objwarehouse.price);
                objwarehouse.Select_Twarehouse_data(ObjMem_AL.get(i).getWh_out(), ObjMem_AL.get(i).getLocation_id(), ObjMem_AL.get(i).getProduct_id());
                beanTransction.setWh_value(obj_cal.Product_value(objwarehouse.wh_value, obj_cal.RawMat_value(beanTransction.getCost_per_unit(), ObjMem_AL.get(i).getWeight()), beanTransction.getDoc_type()));
                objwarehouse.UpdateT_warehouse_item(beanTransction, con);
            } else {
                objwarehouse.Select_Twarehouse_data("W002", "-", ObjMem_AL.get(i).getProduct_id());
                DataBeanT_warehouse_item beanwarehouse = new DataBeanT_warehouse_item();
                beanwarehouse.setWarehouse_id(beanTransction.getWh_out());
                beanwarehouse.setLocation_id(beanTransction.getLocation_id());
                beanwarehouse.setProduct_id(beanTransction.getProduct_id());
                beanwarehouse.setWeight(beanTransction.getWeight());
                beanwarehouse.setBy(by);
                beanwarehouse.setDate(date);
                beanwarehouse.setPrice(objwarehouse.price.isEmpty() ? "0.00" : objwarehouse.price);
                beanwarehouse.setWh_value(obj_cal.RawMat_value(objwarehouse.price.isEmpty() ? "0.00" : objwarehouse.price, ObjMem_AL.get(i).getWeight()));
                objwarehouse.InsertT_warehouse_item(beanwarehouse, con);
            }
            objwarehouse_total.T_warehouse_item_total(beanTransction, con);
            objwarehouse_total.T_warehouse_total_product(beanTransction, con);

            //}
            //********** End Warehouse **************************
            D_cost_productDAO obj_cost = new D_cost_productDAO();
            obj_cost.D_cost_product(beanTransction);
            ObjMem_AL.get(i).setComplete_flag("Y");

        }
    }

    public String ReturnAlert() {
        String strRetuen = "";
        if (objError_AL.isEmpty()) {
            strRetuen = "อนุมัติเอกสารสมบูรณ์";
        }
        for (int i = 0; i < objError_AL.size(); i++) {
            strRetuen += "ลำดับที่ " + objError_AL.get(i).getLine_no() + " เลขที่เอกสาร " + objError_AL.get(i).getDoc_id()
                    + ",คลังสินค้าที่ " + objError_AL.get(i).getWarehouse_id() + ",เลขที่กอง " + objError_AL.get(i).getLocation_id()
                    + ",รหัสสินค้า " + objError_AL.get(i).getProduct_id() + ",น้ำหนักที่เบิก " + objError_AL.get(i).getWeight()
                    + "ไม่สามารถทำรายการได้เนื่องจาก " + objError_AL.get(i).getStatus() + "\n";
        }
        objError_AL.clear();
        return strRetuen;
    }

    public static void Update_Complete(DataBeanD_carbon_friction_receive_header dataBean, Connection con) throws Exception {
        String sqlheader = "update d_carbon_friction_receive_header set complete_flag = ?  where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_carbon_friction_receive_detail set complete_flag = ?  where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p ;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setString(2, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                //p.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }
}
