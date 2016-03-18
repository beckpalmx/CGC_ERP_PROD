/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Cal_Total;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_requisition_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.Util.SendMail;
import com.cgc.bean.DataBeanSendMail;
import java.util.ArrayList;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class D_requisition_product_header_whDAO {

    private int Returnvalue;

    public int update(DataBeanD_requisition_product_header dataBean) throws Exception {
        Returnvalue = 0;
        int Send_Mail = 0;
        ArrayList<DataBeanD_requisition_product_header> obj_requisition_product_header = new ArrayList<DataBeanD_requisition_product_header>();
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        PreparedStatement p = null;
        String sql = "update d_requisition_product_header_wh set  "
                + "update_by=?,update_date=?,doc_type=?"
                + " where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        p = con.prepareCall(sql);
        p.setString(1, dataBean.getBy());
        p.setTimestamp(2, dataBean.getDate());
        p.setString(3, dataBean.getDoc_type());
        p.setString(4, dataBean.getDoc_id());
        p.executeUpdate();
        try {
            if (dataBean.getComplete_flag().equalsIgnoreCase("N")) {
                sql = "select count(doc_id) as num from d_requisition_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_requisition_product_detail_wh set doc_date=?,wh_in=?,wh_out=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getWh_in());
                    p.setString(3, dataBean.getWh_out());
                    p.setString(4, dataBean.getBy());
                    p.setString(5, dataBean.getDoc_id());
                    p.executeUpdate();
                    //**************************Header*************************
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_requisition_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'Y'") == 0) {
                        Cal_Total cal = new Cal_Total("d_requisition_product_detail_wh", "weight", dataBean.getDoc_id(), " and complete_flag <> 'Y'");
                        sql = "update d_requisition_product_header_wh set net_weight_wh=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                        p = null;
                        p = con.prepareStatement(sql);
                        p.setString(1, cal.Return_Total());
                        p.setString(2, dataBean.getDoc_id());
                        p.executeUpdate();
                    }
                    // Add Data From Bean to Object Array List

                }
            } else {
                Returnvalue = Return_Document("d_requisition_product", dataBean.getDoc_id(), con, p, objuti);
                Send_Mail = Returnvalue;
            }

            obj_requisition_product_header.add(dataBean);

            if (Send_Mail == 1) {
                System.out.println("obj_requisition_product_header = " + obj_requisition_product_header);
                System.out.println("dataBean.doc_id = " + dataBean.getDoc_id());
                System.out.println("dataBean.doc_date = " + dataBean.getDoc_date());
                Send_Email_Return_Document(obj_requisition_product_header, con, p);
            }

        } finally {
            try {
                if (p != null) {
                    p.close();
                }
                if (con != null) {
                    con.close();
                }

            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public int Return_Document(String Table_name, String doc_id, Connection con, PreparedStatement p, UtiDatabase Objuti) throws Exception {
        String SQLDetail = "";
        int status_return = 0;
        try {
            //SQLHeader = "Select count(doc_id) as num from "+Table_name+"_header_wh where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'Y'";
            SQLDetail = "Select count(doc_id) as num from " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'";
            if (Objuti.numRowdatabase(SQLDetail) == 0) {
                //***************Delete Warehouse********************************
                p = con.prepareStatement("DELETE FROM " + Table_name + "_header_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                p.clearParameters();
                //**************return Complet_flag *****************************
                p = con.prepareStatement("UPDATE " + Table_name + "_header set complete_flag = 'N' WHERE doc_id ='" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                status_return = 1;

            } else {
                status_return = -1;
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            return status_return;
        }
    }

    public int Send_Email_Return_Document(ArrayList<DataBeanD_requisition_product_header> obj_AL, Connection con, PreparedStatement p) throws Exception {
        UtiDatabase uti = new UtiDatabase();
        int status_return = 0;
        int record_count = 0;
        String Cust_name = "";
        String Weight = "";
        String Search_Detail = "";

        try {

            for (DataBeanD_requisition_product_header bean : obj_AL) {

                DataBeanSendMail dataBeansendmail = new SendMail(con, bean.getScreen_id()).Return_DataBeanSendMail();

                System.out.println("Doc_ID = " + bean.getDoc_id());
                System.out.println("Doc_Date = " + bean.getDoc_date());
                System.out.println("Cust ID = " + bean.getCust_id());

                Cust_name = SelectHeader(con, bean.getDoc_id());

                System.out.println("Cust_name = " + Cust_name);

                Search_Detail = "Select Count(doc_id) As num from d_requisition_product_detail where doc_id = '" + bean.getDoc_id() + "'";

                if (!dataBeansendmail.getEmail_from().equals("") && !dataBeansendmail.getEmail_to().equals("")
                        && !dataBeansendmail.getEmail_server().equals("") && !dataBeansendmail.getEmail_port().equals("")) {

                    String subject = "CGC ERP System : ส่งเอกสารคืนเพื่อแก้ไข เอกสารการเบิกสินค้าเพื่อส่งออก เลขที่ : " + bean.getDoc_id() + " วันที่ : " + bean.getDoc_date();
                    String message = "";
                    message = message + "<br>";
                    message = message + "<br>" + "เลขที่ : " + bean.getDoc_id();
                    message = message + "<br>" + "วันที่ : " + bean.getDoc_date();
                    message = message + "<br>" + "ชื่อลูกค้า : " + Cust_name;
                    message = message + "<br>";

                    record_count = uti.numRowdatabase(Search_Detail);
                    System.out.println("record_count = " + record_count);
                    if (record_count > 0) {
                        for (int i = 1; i <= record_count; i++) {
                            Weight = SelectDetail(con, bean.getDoc_id());
                            message = message + "<br>" + "รายการที่ " + i + " น้ำหนักถ่าน  " + Weight;
                            System.out.println("Detail message = " + message);
                        }
                    }

                    message = message + "<br>" + "-------------------------------------------------------------------------------------------------";
                    message = message + "<br>" + "เพื่อความถูกต้องสมบูรณ์ โปรดตรวจสอบเอกสารในระบบและแก้ไข พร้อมส่งกลับ คลังสินค้า อีกครั้ง";

                    String[] array_to = dataBeansendmail.getEmail_to().split(";");
                    for (int i = 0; i < array_to.length; i++) {
                        SendMail sendMail = new SendMail(dataBeansendmail.getEmail_from(), array_to[i], subject, message);
                        sendMail.send(dataBeansendmail.getEmail_server(), dataBeansendmail.getEmail_port());
                        System.out.println(array_to[i]);
                        System.out.println(subject);
                        //System.out.println(sendMail);
                    }
                    status_return = 1;
                } else {
                    status_return = -1;
                }

            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            return status_return;
        }
    }

    public static String SelectHeader(Connection con, String s_doc_id) throws Exception {
        String str_return = "";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery("select cust_name from vd_requisition_product_header where doc_id = '" + s_doc_id + "'");
            while (rs.next()) {
                str_return = rs.getString("cust_name");
                System.out.println("Header str_return = " + str_return);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return str_return;
        }

    }

    public static String SelectDetail(Connection con, String s_doc_id) throws Exception {
        String str_return = "";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery("select weight,quantity,bag,lot_no from vd_requisition_product_detail where doc_id = '" + s_doc_id + "'");
            while (rs.next()) {
                str_return = "Lot_no " + rs.getString("lot_no") + " จำนวน " + rs.getString("bag") + " กระสอบ/ถุง น้ำหนักต่อกระสอบ/ถุง " + rs.getString("quantity") + " กิโลกรัม  รวม " + rs.getString("weight") + " กิโลกรัม ";
                System.out.println("Detail str_return = " + str_return);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return str_return;
        }

    }

}
