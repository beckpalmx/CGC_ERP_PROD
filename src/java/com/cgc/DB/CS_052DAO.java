/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.Chk_T_warehouse_item;
import com.cgc.Util.Process_ShowDetail;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanCS_052;
import com.cgc.bean.DataBeanError_Stock_Item;
import com.cgc.bean.DataBeanT_transaction_stock;
import com.cgc.bean.DataBeanT_warehouse_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class CS_052DAO {

    private int count;
    public UtiDatabase objuti;
    public ArrayList<DataBeanError_Stock_Item> objAL_error = new ArrayList<DataBeanError_Stock_Item>();

    public void Work_CS052(ArrayList<DataBeanCS_052> objAL, String Table_name) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        DataBeanT_transaction_stock Bean_transction = new DataBeanT_transaction_stock();
        DataBeanT_warehouse_item Bean_warehouse = new DataBeanT_warehouse_item();
        T_transaction_stockDAO obj_stok = new T_transaction_stockDAO();
        T_warehouse_itemDAO obj_item = new T_warehouse_itemDAO();
        T_warehouse_item_totalDAO obj_total = new T_warehouse_item_totalDAO();
        try {
            if (Table_name.equals("d_packing_product_detail_wh")) {
                for (int i = 0; i < objAL.size(); i++) {
                    Chk_T_warehouse_item objck1 = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
                    if (objck1.Return_value() == 0) {
                        //****************Begin Transaction_Stock***********************
                        Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                        Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                        Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                        Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                        Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                        Bean_transction.setWh_in(objAL.get(i).getWh_in());
                        Bean_transction.setWh_out(objAL.get(i).getWh_in());
                        Bean_transction.setWeight(objAL.get(i).getWeight());
                        Bean_transction.setJob_id(objAL.get(i).getJob_id());
                        Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_doc());
                        Bean_transction.setBy(objAL.get(i).getBy());
                        Bean_transction.setDate(objAL.get(i).getDate());
                        Bean_transction.setDoc_type("-");
                        System.out.println("Process ID = " + objAL.get(i).getProcess_id());
                        System.out.println("Product ID = " + objAL.get(i).getProduct_id());
                        System.out.println("getWh_in = " + objAL.get(i).getWh_in());
                        System.out.println("getWh_out = " + objAL.get(i).getWh_out());
                        obj_stok.InsertT_transaction_stock(Bean_transction, con);
                        //***************Begin Warehouse_itme**************************
                        Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_in(), objAL.get(i).getWeight());
                        if (objck.Return_value() == 0 || objck.Return_value() == -5) {
                            Bean_transction.setCost_per_unit("0.00");
                            Bean_transction.setWh_value("0.00");
                            obj_item.UpdateT_warehouse_item(Bean_transction, con);
                        } else {
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
                        D_cost_productDAO objcost = new D_cost_productDAO();
                        objcost.D_cost_product(Bean_transction);
                        objAL.get(i).setComplete_flag("Y");
                    } else {
                        DataBeanError_Stock_Item beanerror = new DataBeanError_Stock_Item();
                        beanerror.setLine_no(objAL.get(i).getLine_no());
                        beanerror.setDoc_id(objAL.get(i).getDoc_id());
                        beanerror.setStatus(objck1.Return_value() + "");
                        objAL_error.add(beanerror);
                    }
                }
            } else {
                for (int i = 0; i < objAL.size(); i++) {

                    //****************Begin Transaction_Stock***********************
                    Bean_transction.setDoc_id(objAL.get(i).getDoc_id());
                    Bean_transction.setDoc_date(objAL.get(i).getDoc_date());
                    Bean_transction.setProcess_id(objAL.get(i).getProcess_id());
                    Bean_transction.setProduct_id(objAL.get(i).getProduct_id());
                    Bean_transction.setLocation_id(objAL.get(i).getLocation_id());
                    Bean_transction.setWh_out(objAL.get(i).getWh_out());
                    Bean_transction.setWeight(objAL.get(i).getWeight());
                    Bean_transction.setJob_id(objAL.get(i).getJob_id());
                    Bean_transction.setWeight_withdraw(objAL.get(i).getWeight_doc());
                    Bean_transction.setBy(objAL.get(i).getBy());
                    Bean_transction.setDate(objAL.get(i).getDate());
                    Bean_transction.setDoc_type("+");
                    System.out.println("Process ID = " + objAL.get(i).getProcess_id());
                    System.out.println("Product ID = " + objAL.get(i).getProduct_id());
                    System.out.println("getWh_in = " + objAL.get(i).getWh_in());
                    System.out.println("getWh_out = " + objAL.get(i).getWh_out());

                    obj_stok.InsertT_transaction_stock(Bean_transction, con);
                    //***************Begin Warehouse_itme**************************
                    Chk_T_warehouse_item objck = new Chk_T_warehouse_item(objAL.get(i).getLocation_id(), objAL.get(i).getProduct_id(), objAL.get(i).getWh_out(), objAL.get(i).getWeight());
                    if (objck.Return_value() == 0 || objck.Return_value() == -5) {
                        Bean_transction.setCost_per_unit("0.00");
                        Bean_transction.setWh_value("0.00");
                        obj_item.UpdateT_warehouse_item(Bean_transction, con);
                    } else {
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
                    D_cost_productDAO objcost = new D_cost_productDAO();
                    objcost.D_cost_product(Bean_transction);
                    objAL.get(i).setComplete_flag("Y");
                }

            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (!objAL.isEmpty()) {
                Update_Complete_flag(objAL);
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public static void Update_Complete_flag(ArrayList<DataBeanCS_052> objAL) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "";
        String SQL_num1 = "";
        String SQL_num2 = "";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try {
            for (int i = 0; i < objAL.size(); i++) {
                if (objAL.get(i).getComplete_flag().equals("Y")) {
                    if (objAL.get(i).getTable_detail_prod() != null) {
                        SQL = "UPDATE " + objAL.get(i).getTable_detail_prod();
                        SQL += " Set complete_flag = '" + objAL.get(i).getComplete_flag();
                        SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();
                        SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                        SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_out();
                        SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();
                        SQL += "' ,update_date = '" + objAL.get(i).getDate();
                        SQL += "' ,update_by= '" + objAL.get(i).getBy();
                        SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                    } else {
                        SQL = "UPDATE " + objAL.get(i).getTable_detail();
                        SQL += " Set complete_flag = '" + objAL.get(i).getComplete_flag();
                        SQL += "' ,wh_weight_final = '" + objAL.get(i).getWeight();
                        SQL += "' ,wh_product_id = '" + objAL.get(i).getProduct_id();
                        SQL += "' ,wh_warehouse_id = '" + objAL.get(i).getWh_in();
                        SQL += "' ,wh_location_id = '" + objAL.get(i).getLocation_id();
                        SQL += "' ,update_date = '" + objAL.get(i).getDate();
                        SQL += "' ,update_by= '" + objAL.get(i).getBy();
                        SQL += "' where doc_id =? AND line_no=? AND complete_flag = 'N' AND delete_flag = 'N'";
                    }

                    System.out.println("SQL = " + SQL);

                    p = con.prepareStatement(SQL);
                    p.setString(1, objAL.get(i).getDoc_id());
                    p.setString(2, objAL.get(i).getLine_no());
                    p.executeUpdate();
                }
            }
            SQL_num1 = "SELECT count(doc_id) as num From d_packing_product_detail_wh  WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
            SQL_num2 = "SELECT count(doc_id) as num From d_packing_product_detail_prod_wh  WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'N' AND delete_flag = 'N'";
            if (objuti.numRowdatabase(SQL_num1) == 0 && objuti.numRowdatabase(SQL_num2) == 0) {
                SQL_num2 = "SELECT count(doc_id) as num From d_packing_product_detail_prod  WHERE doc_id = '" + objAL.get(0).getDoc_id() + "' AND complete_flag = 'Y' AND delete_flag = 'N'";
                if (objuti.numRowdatabase(SQL_num2) != 0) {
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

    public String showDetail(String Process_id, String Doc_id, String Tablename) throws Exception {
        count = 1;
        objuti = new UtiDatabase();
        Process_ShowDetail objprocess = new Process_ShowDetail(Process_id);
        String SQL = "SELECT * FROM " + Tablename + " WHERE doc_id = '" + Doc_id + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
            while (rs.next()) {
                strOutput += "<tr>\n";
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='3px'><input type='checkbox' id='ckbox_withdraw_" + rs.getString("line_no") + "' name='ckbox_withdraw' value ='" + rs.getString("line_no") + "' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>\n"
                        : "<td class='forborder' width='3px'><input type='checkbox' id='ckbox_secure_" + rs.getString("line_no") + "' name='ckbox_secure' value ='" + rs.getString("line_no") + "' onclick=\"cancle_chkboxAll('chk_all2',this.checked)\"></td>\n";
                strOutput += "<td class='forborder' width='3%'>" + rs.getString("line_no") + "</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("doc_id") + "</td>\n";
                strOutput += "<td class='forborder' width='7%'>" + rs.getString("doc_date") + "</td>\n";
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='10%'>" + rs.getString("job_id") + "<input type = 'hidden' id='job_withdraw_" + rs.getString("line_no") + "' name = 'job_withdraw' value = '" + rs.getString("job_id") + "'></td>\n"
                        : "<td class='forborder' width='10%'>" + rs.getString("job_id") + "<input type = 'hidden' id='job_secure_" + rs.getString("line_no") + "' name = 'job_secure' value = '" + rs.getString("job_id") + "'></td>\n";
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='5%'>" + rs.getString(objprocess.Return_FillProduct_id()) + "<input type='hidden' id='product_doc_withdraw_" + count + "' name = 'product_doc_withdraw' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "'></td>\n"
                        : "<td class='forborder' width='5%'>" + rs.getString(objprocess.Return_FillProduct_id()) + "<input type='hidden' id='product_doc_secure_" + rs.getString("line_no") + "' name = 'product_doc_secure' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "'></td>\n";
                strOutput += "<td class='forborder' width='7%'>" + rs.getString("size_desc") + "</td>\n";
                strOutput += "<td class='forborder' width='5%'>" + rs.getString(objprocess.Return_FillWeight()) + "</td>\n";
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='13%'><input type='text' id='product_withdraw_" + rs.getString("line_no") + "' name = 'product_withdraw' value = '' size = 9><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_withdraw_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n"
                        : "<td class='forborder' width='13%'><input type='text' id='product_secure_" + rs.getString("line_no") + "' name = 'product_secure' value = '' size = 9><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_secure_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n";

//                      ? "<td class='forborder' width='13%'><input type='text' id='product_withdraw_" + rs.getString("line_no") + "' name = 'product_withdraw' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "' size = 9><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_withdraw_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n"
//                      : "<td class='forborder' width='13%'><input type='text' id='product_secure_" + rs.getString("line_no") + "' name = 'product_secure' value = '" + rs.getString(objprocess.Return_FillProduct_id()) + "' size = 9><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_secure_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a></td>\n";
//                      ? "<td class='forborder' width='17%'><input type='text' id='product_withdraw_" + rs.getString("line_no") + "' name = 'product_withdraw' value = '" + "" + "' size = 17 onclick=\"openBrWindow('Vproduct&textinput=product_withdraw_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"><a href='#' ><!--img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_withdraw_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a--></td>\n"
//                      : "<td class='forborder' width='17%'><input type='text' id='product_secure_" + rs.getString("line_no") + "' name = 'product_secure' value = '" + "" + "' size = 17 onclick=\"openBrWindow('Vproduct&textinput=product_secure_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\" ><!--a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_secure_" + rs.getString("line_no") + "', 31, 'Search_Detail_ProductID.jsp')\"></a--></td>\n";
                
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='7%'><input type = 'text' id = 'location_withdraw_" + rs.getString("line_no") + "' name = 'location_withdraw' value = '' size = 5></td>\n"
                        : "<td class='forborder' width='7%'><input type = 'text' id = 'location_secure_" + rs.getString("line_no") + "' name = 'location_secure' value = '' size = 5></td>\n";
                //+ "<input type='hidden' id='location_doc_id_" + rs.getString("line_no") + "' name='location_doc_id' value = ''></td>\n";
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='10%'><input type='text' id='warehouse_withdraw_" + rs.getString("line_no") + "' name = 'warehouse_withdraw' value = '' size = 8 onclick=\"openBrWindow('mwarehouse&textinput=warehouse_withdraw_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\" ><!--a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_withdraw_" + rs.getString("line_no") + "', 48, 'Search_Detail_ProductID.jsp')\"></a--></td>\n"
                        : "<td class='forborder' width='10%'><input type='text' id='warehouse_secure_" + rs.getString("line_no") + "' name = 'warehouse_secure' value = '' size = 8 onclick=\"openBrWindow('mwarehouse&textinput=warehouse_secure_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\"><!--a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=warehouse_secure_" + rs.getString("line_no") + "', 48, 'Search_Detail_ProductID.jsp')\"></a--></td>\n";
                //+ "<input type='hidden' id='warehouse_in_" + rs.getString("line_no") + "' name = 'warehouse_in' value = '" + objuti.NotNull(rs.getString(objprocess.Return_FillWarehouse_in())) + "' size = 5></td>\n";
                strOutput += (Tablename.equals("vd_packing_product_detail_wh"))
                        ? "<td class='forborder' width='7%'><input type='text' id='weight_withdraw_" + rs.getString("line_no") + "' name = 'weight_withdraw' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' onKeyUp=\'IsNuber(this.value, this)\' size = 7></td>\n"
                        + "<input type='hidden' id='weight_doc_withdraw_" + rs.getString("line_no") + "' name = 'weight_doc_withdraw' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' ></td>\n"
                        : "<td class='forborder' width='7%'><input type='text' id='weight_secure_" + rs.getString("line_no") + "' name = 'weight_secure' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' onKeyUp=\'IsNuber(this.value, this)\' size = 7></td>\n"
                        + "<input type='hidden' id='weight_doc_secure_" + rs.getString("line_no") + "' name = 'weight_doc_secure' value = '" + rs.getString(objprocess.Return_FillWeight()) + "' ></td>\n";
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

    public String Alert_Return() {
        String Alert = "";
        if (objAL_error.isEmpty()) {
            Alert = "ทำการอนุมัติรายการถ่านเบิกสำเร็จ";
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
