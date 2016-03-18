/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_MData_export;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.ResultSet;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.sql.Timestamp;
import java.util.Date;
import java.sql.*;
import javax.sql.*;

/**
 *
 * @author Beck
 */
public class PrintCSV_MySQL {

    static DataBean_MData_export objMdata_export;
    UtiDatabase objuti;

    public void ExportCSV(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        String Str_Writer="",SQL=null;
        Connection con = new DBConnect().openNewConnectionMySQL();
        ResultSet rs = null;
        objuti = new UtiDatabase();
        response.setContentType("application/csv");
        java.util.Date date= new java.util.Date();
        System.out.println(new Timestamp(date.getTime()));
        String FileName = date.toString();
        
        //response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
        
        response.setHeader("Content-disposition", "inline; filename=\"Excell_" + FileName + ".csv\"");        
        
        response.setBufferSize(1024);
        try {
            SQL = "select ticket_text,truck_no,date_in,time_in,date_out,time_out,load_in,load_out,net_wght,cred_name,prod_name,substring(Date_In,1,2) as date1,substring(Date_In,4,2) as month1,substring(Date_In,7,4) as year1,cost_unt from ticketbuy"
                    + " where (prod_code = '10' or prod_code = '11') and "
                    + " str_to_date(date_in,'%d/%m/%Y')"
                    + " between str_to_date('"+objuti.Format_Date_For_Mysql(request.getParameter("date_from_format")) +"','%d-%m-%Y') and  str_to_date('"+objuti.Format_Date_For_Mysql(request.getParameter("date_to_format")) +"','%d-%m-%Y')"
                    + " order by cred_name,ticket"; 
                        
            rs = con.createStatement().executeQuery(SQL);            
            PrintWriter pw = response.getWriter();
            
            //System.out.println("pw ="+pw);
            pw.println("รายการชั่งน้ำหนัก ไม้สับ-เปลือกยูคาฯ");
            pw.println("ช่วงวันที่ "+objuti.Format_Date_For_Mysql(request.getParameter("date_from_format"))+" ถึง "+objuti.Format_Date_For_Mysql(request.getParameter("date_to_format"))+"\n");
            pw.println("เลขที่เอกสาร,ทะเบียนรถ,วันที่รถเข้า,เวลาเข้า,วันที่รถออก,เวลาออก,ผู้ขาย,สินค้า,น้ำหนักเข้า(ก.ก.),น้ำหนักออก(ก.ก.),น้ำหนักสุทธิ(ก.ก.),ราคา/หน่วย,รวมราคา\n");
            //Return_param_value = String_sprit(objMdata_export.getParam_value());
            int i = 6;
            while (rs.next()) {
                Str_Writer = objuti.NotNull(rs.getString("ticket_text"))+",";   
                Str_Writer += objuti.NotNull(rs.getString("truck_no"))+",";
                Str_Writer += objuti.NotNull(rs.getString("date_in"))+","; 
                Str_Writer += objuti.NotNull(rs.getString("time_in"))+",";
                Str_Writer += objuti.NotNull(rs.getString("date_out"))+",";
                Str_Writer += objuti.NotNull(rs.getString("time_out"))+",";
                Str_Writer += objuti.NotNull(rs.getString("cred_name"))+",";
                Str_Writer += objuti.NotNull(rs.getString("prod_name"))+",";
                Str_Writer += objuti.NotNull(rs.getString("load_in"))+",";
                Str_Writer += objuti.NotNull(rs.getString("load_out"))+",";
                Str_Writer += objuti.NotNull(rs.getString("net_wght"))+",";
                Str_Writer += objuti.NotNull(rs.getString("cost_unt"))+",";
                Str_Writer += "=K"+i+"*"+"L"+i;
                //Str_Writer += System.getProperty("line.separator");
                               
                pw.println(Str_Writer);
                System.out.println(Str_Writer);
                Str_Writer = null;
                i++;
            }
            
            pw.close();

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
/*
    private void Return_Fill_MData_Export(String export_id, Connection con, ResultSet rs) throws Exception {
        String SQL_export = "select * from mdata_export where export_id = '" + export_id + "' and delete_flag = 'N'";
        objMdata_export = new DataBean_MData_export();
        objuti = new UtiDatabase();
        try {
            rs = con.createStatement().executeQuery(SQL_export);
            while (rs.next()) {
                objMdata_export.setParam_value(objuti.NotNull(rs.getString("param_value")));//จะได้ชื่อColoumภายในDataBaseเพื่อทำการดึงข้อมูลออกมา
                objMdata_export.setParam_name(objuti.NotNull(rs.getString("param_name")));//จะทำการระบุชื่อหัวของColoum
                objMdata_export.setParam_from(objuti.NotNull(rs.getString("param_from")));//จะเป็นช่องของ Doc_id
                objMdata_export.setParam_value_from(objuti.NotNull(rs.getString("param_value_from")));//จะเป็นชื่อของ Doc_date
                objMdata_export.setLookup_name(objuti.NotNull(rs.getString("lookup_name")));//ชื่อของTableที่จะExport
                objMdata_export.setStatus(objuti.NotNull(rs.getString("status")));
                objMdata_export.setName_t(objuti.NotNull(rs.getString("name_t")));//ชื่อของ Process นั้น
                objMdata_export.setOrder_by(objuti.NotNull(rs.getString("order_by")));//เป็น Statement ในการเรียงลำดับข้อมูล
                objMdata_export.setComplete_flag(objuti.NotNull(rs.getString("complete_flag")));
                objMdata_export.setDelete_flag(objuti.NotNull(rs.getString("delete_flag")));
                objMdata_export.setRetro_flag(objuti.NotNull(rs.getString("retro_flag")));
                objMdata_export.setCancel_flag(objuti.NotNull(rs.getString("cancel_flag")));
                //objMdata_export.setParam_type(objuti.NotNull(rs.getString("param_type")));//จะเป็นการระบุ flag ต่างๆๆ
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
    }

    private String[] String_sprit(String input) {
        return input.split(",");
    }
    * */
}
