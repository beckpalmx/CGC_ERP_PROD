/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Calculator_T_warehouse_item;
import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.Util.Process_ShowDetail;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanCS_051;
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
public class CS_051DAO {

    public void Work_CS051(ArrayList<DataBeanCS_051> objAL) throws Exception {
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

                //****************Begin Transaction_Stock***********************
                Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                Bean_transction.setWh_in(objAL.get(i).getWh_in());
                Bean_transction.setWh_out(objAL.get(i).getWh_out());
                Bean_transction.setWeight(objAL.get(i).getWeight());
                Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_withdraw());
                Bean_transction.setJob_id(objAL.get(i).getJob_id());
                Bean_transction.setBy(objAL.get(i).getBy());
                Bean_transction.setDate(objAL.get(i).getDate());
                Bean_transction.setDoc_type("+");
                obj_stok.InsertT_transaction_stock(Bean_transction, con);
                //***************Begin Warehouse_itme**************************
                Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_out(), objAL.get(i).getWeight());
                if (objck.Return_value() == 0 || objck.Return_value() == -5) {
                    //obj_item.Select_Twarehouse_data("0.00");
                    Bean_transction.setCost_per_unit("0.00");
                   //obj_item.Select_Twarehouse_data(objAL.get(i).getWh_out(), objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id());
                    Bean_transction.setWh_value("0.00");
                    obj_item.UpdateT_warehouse_item(Bean_transction, con);
                } else {
                    //obj_item.Select_Twarehouse_data("W006", "-", objAL.get(i).getProduct_id());
                    Bean_warehouse.setProduct_id(objAL.get(i).getProduct_id());
                    Bean_warehouse.setWarehouse_id(objAL.get(i).getWh_out());
                    Bean_warehouse.setLocation_id(objAL.get(i).getLocation_id());
                    Bean_warehouse.setWeight(objAL.get(i).getWeight());
                    Bean_warehouse.setBy(objAL.get(i).getBy());
                    Bean_warehouse.setDate(objAL.get(i).getDate());
                    Bean_warehouse.setPrice("0.00");
                    Bean_warehouse.setWh_value("0.00");
                    obj_item.InsertT_warehouse_item(Bean_warehouse, con);
                }
                obj_total.T_warehouse_item_total(Bean_transction, con);
                obj_total.T_warehouse_total_product(Bean_transction, con);
                D_cost_productDAO obj_cost = new D_cost_productDAO();
                obj_cost.D_cost_product(Bean_transction);
                objAL.get(i).setComplete_flag("Y");
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

    public static void Update_Complete_flag(ArrayList<DataBeanCS_051> objAL) throws Exception {
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
                                
                System.out.println("IODINE = " + IODINE);
                
                if (objAL.get(i).getComplete_flag().equals("Y")) {
                    SQL = "UPDATE " + objAL.get(i).getTable_detail_prod() ;
                    SQL += " Set complete_flag = '" + objAL.get(i).getComplete_flag();
                    SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();
                    SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                    SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_out();
                    SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();     
                    SQL += "' ,update_date = '" + objAL.get(i).getDate();  
                    SQL += "' ,update_by= '" + objAL.get(i).getBy();             
                    SQL += "' ,ctc_i2= '" + IODINE;                      
                    SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                    System.out.println("SQL = "+ SQL );
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(i).getDoc_id());
                    p.setString(2, objAL.get(i).getLine_no());
                    p.executeUpdate();
                    
                    // Update ไปฝ่ายผลิต
                    
                    SQL = "UPDATE d_product_receive_detail_prod" ;
                    SQL += " Set ctc_i2= '" + IODINE;  
                    SQL += "' where doc_id =? AND line_no=? AND delete_flag = 'N'";
                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(i).getDoc_id());
                    p.setString(2, objAL.get(i).getLine_no());
                    System.out.println("Doc ID = " + objAL.get(i).getDoc_id());
                    System.out.println("Line No = " + objAL.get(i).getLine_no());
                    p.executeUpdate();                      
                    
                }
            }
            SQL_num = (objAL.isEmpty())
                    ? null
                    : "SELECT count(doc_id) as num From " + objAL.get(0).getTable_detail_prod() + " WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
            if (SQL_num != null) {
                if (objuti.numRowdatabase(SQL_num) == 0) {
                    for (int i = 0; i <= 1; i++) {
                        p = null;
                        SQL =(i==0)? "UPDATE " + objAL.get(0).getTable_header():"UPDATE " + objAL.get(0).getTable_detail() ;
                        SQL +=" Set complete_flag = 'Y' where doc_id =? AND complete_flag = 'N' AND delete_flag = 'N' ";
                        p = con.prepareStatement(SQL);
                        p.setString(1, objAL.get(0).getDoc_id());
                        p.executeUpdate();
                    }
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

    public String showDetail(String Doc_id) throws Exception {
        int count = 1;
        UtiDatabase objuti = new UtiDatabase();
        Process_ShowDetail objprocess = new Process_ShowDetail("PR_036");
        String SQL = "SELECT * FROM vd_product_receive_detail_prod_wh WHERE doc_id = '" + Doc_id + "' and delete_flag <> 'Y' and complete_flag <> 'Y'  order by to_number(line_no,'9999')";
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
                strOutput += "<td class='forborder' width='3%'>" + count + "</td>\n";
                strOutput += "<td class='forborder' width='4%'>" + rs.getString("c_type") + "</td>\n";
                strOutput += "<td class='forborder' width='7%'>" + objuti.NotNull(rs.getString("size")) + "<input type = 'hidden' id='job_id_" + rs.getString("line_no") + "' name = 'job_id' value = '" + rs.getString("job_id") + "'></td>\n";
                strOutput += "<td class='forborder' width='8%'>" + objuti.NotNull(rs.getString("palate_complete_code")) + "</td>\n";
                strOutput += "<td class='forborder' width='5%'>" + objuti.NotNull(rs.getString("palate_no")) + "</td>\n";
                strOutput += "<td class='forborder' width='5%'>" + rs.getString("bag") + "</td>\n";
                strOutput += "<td class='forborder' width='8%'>" + rs.getString("weight") + "</td>\n";
                strOutput += "<td class='forborder' width='7%'>" + objuti.NotNull(rs.getString("ctc_i2")) + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='13%'><input type='text' id='product_id_" + rs.getString("line_no") + "' name = 'product_id' value = '" + objuti.NotNull(rs.getString(objprocess.Return_FillProduct_id())) + "' size = 7>"
                        + "<a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_id_" + rs.getString("line_no") + "', 31, 'Search_Detail.jsp')\"></a></td>\n";
                strOutput += "<td class='forborder' width='10%'><input type='text' id='warehouse_id_" + rs.getString("line_no") + "' name = 'warehouse_id' value = '' size = 5 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_id_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\"></a>"
                        + "<input type='hidden' id='warehouse_in_" + rs.getString("line_no") + "' name = 'warehouse_in' value = 'W006' size = 7></td>\n";
                strOutput += "<td class='forborder' width='7%'><input type = 'text' id = 'location_id_" + rs.getString("line_no") + "' name = 'location_id' value = '' size = 5></td>\n";
                //+ "<input type='hidden' id='location_doc_id_" + rs.getString("line_no") + "' name='location_doc_id' value = '" + objuti.NotNull(rs.getString(objprocess.Retrun_FillLocation_id())) + "'></td>\n";

                strOutput += "<td class='forborder' width='10%'><input type='text' id='weight_" + rs.getString("line_no") + "' name = 'weight' value = '" + removeNecative(objuti.NotNull(rs.getString(objprocess.Return_FillWeight()))) + "' onKeyUp=\'IsNuber(this.value, this)\'  size = 9>"
                        + "<input type='hidden' id='weight_doc_id_" + rs.getString("line_no") + "' name = 'weight_doc_id' value = '" + removeNecative(objuti.NotNull(rs.getString(objprocess.Return_FillWeight()))) + "' ></td>\n";
                strOutput += "<td width='10%' class='forborder' colspan='2'>\n"
                        + "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n"
                        + "<tr>\n"
                        + "<td colspan='2'>\n"
                        + "<table width='6%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n"
                        + "<tr>\n"
                        + "<td class='row5' width='3%'>" + Weight_Diff(removeNecative(objuti.NotNull(rs.getString("weight"))), removeNecative(objuti.NotNull(rs.getString("bag")))) + "</td>\n"/*+ removeNecative(objuti.NotNull(rs.getString("bag_no"))) +*/
                        + "<td class='row5' width='3%'>" + Weight_Mod(removeNecative(objuti.NotNull(rs.getString("weight"))), removeNecative(objuti.NotNull(rs.getString("bag")))) + "</td>\n"//removeNecative(objuti.NotNull(rs.getString("weight_diff")))
                        + "</tr>\n"
                        + "</table>\n"
                        + "</td>\n"
                        + "</tr>\n"
                        + "</table></td>\n";
                strOutput += "</tr>\n";
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

    public String removeNecative(String inputstring) {
        return (inputstring.indexOf("-") != -1)
                ? inputstring.replace("-", "")
                : inputstring.equals("")
                ? "0"
                : inputstring.equals("0")
                ? "1"
                : inputstring;
    }

    public String Weight_Diff(String Weight, String Bag) {
        return Integer.toString((int) (Float.parseFloat(Weight) / Float.parseFloat(Bag)));

    }

    public String Weight_Mod(String Weight, String Bag) {
        return Integer.toString((int) (Float.parseFloat(Weight) % Float.parseFloat(Bag)));
    }
}
