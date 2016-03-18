/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.Util.Process_ShowDetail;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanCS_050;
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
public class CS_050DAO {
    public static ArrayList<DataBeanError_Stock_Item> objAL_error = new ArrayList<DataBeanError_Stock_Item>();
    public void Work_CS050(ArrayList<DataBeanCS_050> objAL) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        DataBeanT_transaction_stock Bean_transction = new DataBeanT_transaction_stock();
        DataBeanT_warehouse_item Bean_warehouse = new DataBeanT_warehouse_item();
        T_transaction_stockDAO obj_stok = new T_transaction_stockDAO();
        T_warehouse_itemDAO obj_item = new T_warehouse_itemDAO();
        T_warehouse_item_totalDAO obj_total = new T_warehouse_item_totalDAO();
        Calculator_T_warehouse_item obj_cal = new Calculator_T_warehouse_item();
        try {
            for (int i = 0; i < objAL.size(); i++) {
                Chk_T_warehouse_item objck_ap = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
                if (objck_ap.Return_value() == 0) {
                    //****************Begin Transaction_Stock***********************
                    Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                    Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                    Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                    Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                    Bean_transction.setWh_out(objAL.get(i).getWh_out());
                    Bean_transction.setWeight(objAL.get(i).getWeight());
                    Bean_transction.setJob_id(objAL.get(i).getJob_id());
                    Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                    Bean_transction.setBy(objAL.get(i).getBy());
                    Bean_transction.setDate(objAL.get(i).getDate());
                    //********************* - *****************************
                    Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                    Bean_transction.setDoc_type("-");
                    obj_stok.InsertT_transaction_stock(Bean_transction, con);
                    //******************** + *******************************
                    Bean_transction.setLocation_id("-");
                    Bean_transction.setDoc_type("+");
                    //obj_stok.InsertT_transaction_stock(Bean_transction, con);
                    //******************* - *********************************
                    Bean_transction.setDoc_type("-");
                    Bean_transction.setWh_in(objAL.get(i).getWh_out());
                    //obj_stok.InsertT_transaction_stock(Bean_transction, con);
                    //***************Begin Warehouse_itme**************************
                    for (int j = 1; j <= 3; j++) {
                        Bean_transction.setDoc_type(j==1 || j== 3?"-":"+");
                        Bean_transction.setLocation_id(j==1?objAL.get(i).getLocation_id():"-");
                        Bean_transction.setWh_in(j==3?objAL.get(i).getWh_out():objAL.get(i).getWh_in());
                        Chk_T_warehouse_item objck = new Chk_T_warehouse_item(Bean_transction.getLocation_id(), Bean_transction.getProduct_id(), j==1?Bean_transction.getWh_in():Bean_transction.getWh_out(), Bean_transction.getWeight());
                        if (objck.Return_value() == 0 || objck.Return_value() == -5) {
                            obj_item.Select_Twarehouse_data(j==3?objAL.get(i).getWh_out():objAL.get(i).getWh_in(),j==3?"-":objAL.get(i).getLocation_id(), Bean_transction.getProduct_id());
                            Bean_transction.setCost_per_unit(obj_item.price);
                            Bean_transction.setWh_value(j==1 || j== 3 ?obj_cal.Product_value(obj_item.wh_value, obj_cal.RawMat_value(obj_item.price, objAL.get(i).getWeight()), Bean_transction.getDoc_type()):obj_cal.RawMat_value(obj_item.price, objAL.get(i).getWeight()));
                            obj_item.UpdateT_warehouse_item(Bean_transction, con);
                        } else {
                            obj_item.Select_Twarehouse_data(objAL.get(i).getWh_in(), objAL.get(i).getLocation_id() , objAL.get(i).getProduct_id());
                            Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                            Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                            Bean_warehouse.setLocation_id("-");
                            Bean_warehouse.setWeight(objAL.get(i).getWeight());
                            Bean_warehouse.setBy(objAL.get(i).getBy());
                            Bean_warehouse.setDate(objAL.get(i).getDate());
                            Bean_warehouse.setPrice(obj_item.price);
                            Bean_warehouse.setWh_value(obj_cal.RawMat_value(obj_item.price, objAL.get(i).getWeight()));
                            obj_item.InsertT_warehouse_item(Bean_warehouse, con);
                        }
                    }
                    //************************Begin Total ************************
                    Bean_transction.setDoc_type("-");
                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                    obj_total.T_warehouse_item_total(Bean_transction, con);
                    //*************************** + ********************************
                    Bean_transction.setDoc_type("+");
                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                    obj_total.T_warehouse_item_total(Bean_transction, con);
                    //************************** - *********************************
                    Bean_transction.setDoc_type("-");
                    Bean_transction.setWh_in(objAL.get(i).getWh_out());
                    obj_total.T_warehouse_item_total(Bean_transction, con);
                    obj_total.T_warehouse_total_product(Bean_transction, con);
                    //************
                    Bean_transction.setDoc_type("-");
                    Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                    Bean_transction.setWh_in(objAL.get(i).getWh_in());
                    D_cost_productDAO objcost = new D_cost_productDAO();
                    objcost.D_cost_product(Bean_transction);
                    //************
                    objAL.get(i).setComplete_flag("Y");
                }else {
                DataBeanError_Stock_Item beanerror = new DataBeanError_Stock_Item();
                beanerror.setLine_no(objAL.get(i).getLine_no());
                beanerror.setDoc_id(objAL.get(i).getDoc_id());
                beanerror.setStatus(objck_ap.Return_value() + "");
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
    public static void Update_Complete_flag(ArrayList<DataBeanCS_050> objAL) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL,SQL1,IODINE = "";
        String SQL_num = "";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try {
            for (int i = 0; i < objAL.size(); i++) {
                
                SQL1 = " Select iodine From MProduct where product_id = '" + objAL.get(i).getProduct_id() + "'";                 
                ResultSet rs = null;
                rs = con.createStatement().executeQuery(SQL1);
                while (rs.next()) {
                   IODINE = rs.getString("iodine");
                }
                    
                System.out.println("Doc ID = " + objAL.get(i).getDoc_id());
                System.out.println("Line No = " + objAL.get(i).getLine_no());   
                    
                if (objAL.get(i).getComplete_flag().equals("Y")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail();                    
                    SQL += " Set complete_flag = '" + objAL.get(i).getComplete_flag();
                    SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();                    
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();  
                    SQL += "' ,location_id = '" + objAL.get(i).getLocation_id();
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();  
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();                      
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";                    
                    System.out.println("update 1 SQL = "+ SQL );
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(i).getDoc_id());
                    p.setString(2, objAL.get(i).getLine_no());
                    p.executeUpdate();
                    
                    SQL = "UPDATE d_carbon_withdraw_detail " ;                      
                    SQL += " Set wh_id = '" + objAL.get(i).getWh_in();
                    SQL += "' ,location_id = '" + objAL.get(i).getLocation_id();                    
                    SQL += "' where doc_id =? AND line_no=? AND delete_flag = 'N'";
                    System.out.println("update 2 SQL = "+ SQL );
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(i).getDoc_id());
                    p.setString(2, objAL.get(i).getLine_no());
                 
                    
                }
            }
            SQL_num = (objAL.isEmpty())
                    ? null
                    : "SELECT count(doc_id) as num From " + objAL.get(0).getTable_detail() + " WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
            System.out.println("update 3 SQL_num = "+ SQL_num );
            if (SQL_num != null) {
                if (objuti.numRowdatabase(SQL_num) == 0) {
                    p = null;
                    SQL = "UPDATE " + objAL.get(0).getTable_header() + " Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' ";
                    System.out.println("update 4 SQL = "+ SQL );
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

    public String showDetail(String Doc_id) throws Exception {
        //int count = 1;
        UtiDatabase objuti = new UtiDatabase();
        Process_ShowDetail objprocess = new Process_ShowDetail("PR_034");
        String SQL = "SELECT * FROM d_carbon_withdraw_detail_wh WHERE doc_id = '" + Doc_id + "' and delete_flag <> 'Y' and complete_flag <> 'Y'  order by to_number(line_no,'9999')";
        String strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput += "<tr>\n";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox_" + rs.getString("line_no") + "' name='ckbox' value ='" + rs.getString("line_no") + "' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>\n";
                strOutput += "<td class='forborder' width='3%'>" + rs.getString("line_no") + "</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("job_id") + "<input type = 'hidden' id='job_id_" + rs.getString("line_no") + "' name = 'job_id' value = '" + rs.getString("job_id") + "'></td>\n";
                strOutput += "<td class='forborder' width='7%'>" + rs.getString("size_use") + "</td>\n";
                strOutput += "<td class='forborder' width='5%'>" + rs.getString("pcat_id") + "</td>\n";
                strOutput += "<td class='forborder' width='5%'>" + rs.getString("grd_io_ctc") + "</td>\n";
                strOutput += "<td class='forborder' width='7%'>" + rs.getString("machine") + "</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("weight") + "</td>\n";
                strOutput += "<td class='forborder' width='15%'><input type='text' id='product_id_" + rs.getString("line_no") + "' name = 'product_id' value = '' size = 10>"
                        + "<a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_id_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n";
                //strOutput += "<td class='forborder' width='10%'><input type='text' id='warehouse_id_" + rs.getString("line_no") + "' name = 'warehouse_id' value = '" + rs.getString("wh_id") + "' size = 6 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_id_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\"></a>"
                strOutput += "<td class='forborder' width='10%'><input type='text' id='warehouse_id_" + rs.getString("line_no") + "' name = 'warehouse_id' value = '' size = 4 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_id_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\"></a>"
                        + "<input type='hidden' id='warehouse_in_" + rs.getString("line_no") + "' name = 'warehouse_in' value = 'W006' size = 7></td>\n";
                //strOutput += "<td class='forborder' width='5%'><input type = 'text' id = 'location_id_" + rs.getString("line_no") + "' name = 'location_id' value = '" + rs.getString("location_id") + "' size = 3></td>\n";
                strOutput += "<td class='forborder' width='5%'><input type = 'text' id = 'location_id_" + rs.getString("line_no") + "' name = 'location_id' value = '' size = 3></td>\n";
                //+ "<input type='hidden' id='location_doc_id_" + rs.getString("line_no") + "' name='location_doc_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "'></td>\n";

                strOutput += "<td class='forborder' width='10%'><input type='text' id='weight_" + rs.getString("line_no") + "' name = 'weight' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' onKeyUp=\'IsNuber(this.value, this)\'  size = 9>"
                        + "<input type='hidden' id='weight_doc_id_" + rs.getString("line_no") + "' name = 'weight_doc_id' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' ></td>\n";
                strOutput += "<td width='10%' class='forborder' colspan='2'>\n"
                        + "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n"
                        + "<tr>\n"
                        + "<td colspan='2'>\n"
                        + "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n"
                        + "<tr>\n"
                        + "<td class='row5' width='5%'>" + "0" + "</td>\n"
                        + "<td class='row5' width='5%'>" + "0" + "</td>\n"
                        + "</tr>\n"
                        + "</table>\n"
                        + "</td>\n"
                        + "</tr>\n"
                        + "</table></td>\n";
                strOutput += "</tr>\n";
                //count++;
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
}
