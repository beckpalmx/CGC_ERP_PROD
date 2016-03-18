/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanCS_D_carbon_send_product_detail;
import com.cgc.bean.DataBeanCS_D_carbon_send_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import com.cgc.Util.SendMail;
import com.cgc.bean.DataBeanSendMail;
import com.cgc.Util.UtiDatabase;
import java.sql.SQLException;

/**
 *
 * @author Man
 */
public class D_carbon_send_product_headerDAO {

    UtiDatabase uti = new UtiDatabase();

    public int insert(DataBeanCS_D_carbon_send_product_header DataBean, ArrayList<DataBeanCS_D_carbon_send_product_detail> ObjAL_Detail) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        String Table_Header;
        String Table_detail;
        PreparedStatement p = null;
        String SqlCount ;  
        try {

            //for (int loop = 1; loop <= 2; loop = loop + 1) {
            //    if (loop == 1) {
            Table_Header = "d_carbon_send_product_header";
            Table_detail = "d_carbon_send_product_detail";
            //     } else {
            //         Table_Header = "d_carbon_send_product_qc_header";
            //         Table_detail = "d_carbon_send_product_qc_detail";
            //     }

            int i = 1;

            p = con.prepareStatement("insert into " + Table_Header + "(doc_id,doc_date,job_type,send_doc_time,receive_doc_time"
                    + ",product_leader_id,lab_leader_id,warehouse_emp_id,warehouse_leader_id,create_by"
                    + ",create_date,update_date,product_confirm,quality_confirm,wh_emp_confirm,wh_leader_confirm,doc_type,send_mail_status,complete_flag) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            //System.out.println("Header Loop : " + loop);
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getJob_type());
            i += 1;
            p.setString(i, DataBean.getSend_doc_time());
            i += 1;
            p.setString(i, DataBean.getReceive_doc_time());
            i += 1;
            p.setString(i, DataBean.getProduct_leader_id());
            i += 1;
            p.setString(i, DataBean.getLab_leader_id());
            i += 1;
            p.setString(i, DataBean.getWarehouse_emp_id());
            i += 1;
            p.setString(i, DataBean.getWarehouse_leader_id());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getProduct_confirm());
            i += 1;
            p.setString(i, DataBean.getQuality_confirm());
            i += 1;
            p.setString(i, DataBean.getWh_emp_confirm());
            i += 1;
            p.setString(i, DataBean.getWh_leader_confirm());
            i += 1;
            p.setString(i, DataBean.getDoc_type());
            i += 1;
            p.setString(i, DataBean.getSend_mail_status());
            i += 1;
            p.setString(i, DataBean.getComplete_flag());
            i += 1;

            //p.executeUpdate();
            System.out.println("p = " + p);
            SqlCount = "Select Count(doc_id) As num from  " + Table_Header + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                //p.executeBatch();
                p.executeUpdate();
                System.out.println("Returnvalue = " + true);
            }

            p.clearParameters();

            p = con.prepareStatement("insert into " + Table_detail + "(doc_id,doc_date,line_no,job_id,product_id"
                    + ",size_name,iodine,machine_id,pallet,product_no,bag_quatity"
                    //+ ",bag_weight"
                    + ",weight,create_by,create_date,update_date,doc_type,fraction,job_type,complete_flag,param_header_id,wh_product_id,wh_id,location_id,h2o,butane,iod,psd_1) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            System.out.println("ObjAL_Detail = " + ObjAL_Detail.size());

            for (int count = 0; count < ObjAL_Detail.size(); count++) {
                i = 1;
                p.setString(i, DataBean.getDoc_id());
                i += 1;
                p.setString(i, DataBean.getDoc_date());
                i += 1;
                //System.out.println("Doc_Date = " + DataBean.getDoc_date());
                //System.out.println("Loop : " + loop);
                p.setString(i, ObjAL_Detail.get(count).getLine_no());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getJob_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getProduct_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getSize_name());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getIodine());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getMachine_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getPallet());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getProduct_no());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBag_quatity());
                i += 1;
//                p.setString(i, ObjAL_Detail.get(count).getBag_weight());
//                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getWeight());
                i += 1;
                p.setString(i, DataBean.getBy());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setString(i, DataBean.getDoc_type());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getFraction());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getJob_type());
                i += 1;
                p.setString(i, DataBean.getComplete_flag());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getParam_header_id());
                i += 1;
                p.setString(i, "");
                i += 1;
                p.setString(i, "");
                i += 1;
                p.setString(i, "");
                i += 1;
                p.setString(i, "");
                i += 1;
                p.setString(i, "");
                i += 1;
                p.setString(i, "");
                i += 1;
                p.setString(i, "");
                i += 1;

                //p.addBatch();
                System.out.println("p = " + p);
                SqlCount = "Select Count(doc_id) As num from  " + Table_detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + ObjAL_Detail.get(count).getLine_no() + "' ;";
                System.out.println("SqlCount = " + SqlCount);
                if (uti.numRowdatabase(SqlCount) == 0) {
                    //p.executeBatch();
                    p.executeUpdate();
                    System.out.println("Returnvalue = " + true);
                }

            }

            //p = null;
            // Delete For Empty Record 
            //p = con.prepareStatement(" delete from d_carbon_send_product_detail where weight = '0' and product_id = '' and machine_id = '' and size_name = '' and product_no = '' "
            //+ " and doc_id = ? and delete_flag = 'N'");
            //p.setString(1, DataBean.getDoc_id());
            //p.executeUpdate();                
            //p = null;
            //}
            //Avg_carbon_out_analysis(con, p, DataBean.getDoc_id());
        } catch (SQLException e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
        return 1;
    }

    public int update(DataBeanCS_D_carbon_send_product_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("update d_carbon_send_product_header set product_leader_id=?,lab_leader_id=?,warehouse_emp_id=?"
                    + ",warehouse_leader_id=?,update_by=?,update_date=?,product_confirm=?"
                    + ",quality_confirm=?,wh_emp_confirm=?,wh_leader_confirm=?"
                    + ",send_doc_time=?,receive_doc_time=?,send_mail_status=?,complete_flag=? "
                    + "where doc_id = ? and delete_flag = 'N'");
            //+ "where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'");
            p.setString(i, DataBean.getProduct_leader_id());
            i += 1;
            p.setString(i, DataBean.getLab_leader_id());
            i += 1;
            p.setString(i, DataBean.getWarehouse_emp_id());
            i += 1;
            p.setString(i, DataBean.getWarehouse_leader_id());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getProduct_confirm());
            i += 1;
            p.setString(i, DataBean.getQuality_confirm());
            i += 1;
            p.setString(i, DataBean.getWh_emp_confirm());
            i += 1;
            p.setString(i, DataBean.getWh_leader_confirm());
            i += 1;
            p.setString(i, DataBean.getSend_doc_time());
            i += 1;
            p.setString(i, DataBean.getReceive_doc_time());
            i += 1;
            p.setString(i, DataBean.getSend_mail_status());
            i += 1;
            System.out.println("Send mail Status = " + DataBean.getSend_mail_status());
            p.setString(i, DataBean.getComplete_flag());
            i += 1;
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.executeUpdate();
            p = null;

            //Set Complete Flag To table Detail 
            String sql = "select count(doc_id) as num from d_carbon_send_product_detail where doc_id ='" + DataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (uti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_send_product_detail set update_by=?,update_date=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, DataBean.getBy());
                p.setTimestamp(2, DataBean.getDate());
                p.setString(3, DataBean.getComplete_flag());
                p.setString(4, DataBean.getDoc_id());
                p.executeUpdate();
            }

            // Delete For Empty Record 
            if (DataBean.getProduct_confirm().equalsIgnoreCase("Y")) {
                String SQL_Del = " delete from d_carbon_send_product_detail where weight = '0' and product_id = '' and machine_id = '' and size_name = '' and product_no = '' "
                        + " and doc_id = ? and delete_flag = 'N'";
                p = con.prepareStatement(SQL_Del);
                System.out.println(SQL_Del);
                p.setString(1, DataBean.getDoc_id());
                p.executeUpdate();
                p = null;
            }

            /**
             * * Send Mail **
             */
            //String from = "office_ko@cgc-carbon.com";
            //String to = "product@cgc-carbon.com;sale@cgc-carbon.com;warehouse@cgc-carbon.com;lab@cgc-carbon.com;it@cgc-carbon.com";
            //String to = "it@cgc-carbon.com;@cgc-carbon.com;it@cgc-carbon.com";
            //SendMail objquerybean =             
            if (DataBean.getSend_mail_status().equalsIgnoreCase("Y")) {

                DataBeanSendMail dataBeansendmail = new SendMail(con, DataBean.getScreen_id()).Return_DataBeanSendMail();

                if (dataBeansendmail.getEmail_from() != null
                        || dataBeansendmail.getEmail_to() != null
                        || dataBeansendmail.getEmail_server() != null
                        || dataBeansendmail.getEmail_port() != null) {

                    String subject = "CGC ERP System : มีเอกสารมาใหม่ ใบแจ้งการนำส่งสินค้า เลขที่ : " + DataBean.getDoc_id() + " วันที่ : " + DataBean.getDoc_date();

                    String message = "CGC ERP System : ใบแจ้งการนำส่งสินค้า เลขที่ : " + DataBean.getDoc_id() + " วันที่ : " + DataBean.getDoc_date();
                    message = message + "CGC ERP System : ประเภทงาน : " + DataBean.getJob_type();
                    //message = message + "<br>" + Return_Detail(DataBean, ArrayBean);
                    message = message + "<br>" + "-------------------------------------------------------------------------------------------------";
                    message = message + "<br>" + "เพื่อความถูกต้องสมบูรณ์ โปรดตรวจสอบเอกสารในระบบ และเอกสารตัวจริง";

                    //message = message + "<br>" + "<a href=\"http://202.183.167.6:8089/CGC_ERP\">CGC ERP LOGIN กรุณาล๊อคอิน</a>";  
                    String[] array_to = dataBeansendmail.getEmail_to().split(";");
                    for (int i_send = 0; i_send < array_to.length; i++) {
                        SendMail sendMail = new SendMail(dataBeansendmail.getEmail_from(), array_to[i], subject, message);
                        //sendMail.send(dataBeansendmail.getEmail_server(), dataBeansendmail.getEmail_port());
                        System.out.println(array_to[i]);
                        System.out.println(subject);
                        System.out.println(sendMail);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
        return 1;
    }

    public int updel(DataBeanCS_D_carbon_send_product_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try {
            for (int i = 1; i <= 2; i++) {
                p = con.prepareStatement("update " + (i == 1 ? "d_carbon_send_product_header" : "d_carbon_send_product_detail") + " set delete_flag=?,delete_by=?,delete_date=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'");
                p.setString(1, "Y");
                p.setString(2, DataBean.getBy());
                p.setTimestamp(3, DataBean.getDate());
                p.setString(4, DataBean.getDoc_id());
                p.executeUpdate();
                p.clearParameters();
            }

        } catch (SQLException e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
        return 1;
    }
}
