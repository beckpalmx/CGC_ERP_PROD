/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_MData_export;
import static com.cgc.report.PrintCSV.objMdata_export;
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
public class PrintCSV_FUEL_REC {

    static DataBean_MData_export objMdata_export;
    UtiDatabase objuti;

    public void ExportCSV(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        String Str_Writer = "", SQL = null;
        //DBConnect objcon = new DBConnect();
        //Connection con = objcon.openNewConnection();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        objuti = new UtiDatabase();
        response.setContentType("application/csv");
        java.util.Date date = new java.util.Date();
        System.out.println(new Timestamp(date.getTime()));
        String FileName = date.toString();

        String rq_date_from = request.getParameter("date_from_format");
        String rq_date_to = request.getParameter("date_to_format");
        String supplier_id = request.getParameter("supplier_id");

        //response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
        response.setHeader("Content-disposition", "inline; filename=\"Excell_" + FileName + ".csv\"");

        response.setBufferSize(1024);
        try {
            SQL = "select * from vd_fuel_receive_report ";           
            SQL += "WHERE to_date(format_date(doc_date),'YYYY-MM-DD') BETWEEN to_date(format_date2('" + rq_date_from + "'),'YYYY-MM-DD') AND to_date(format_date2('" + rq_date_to + "'),'YYYY-MM-DD') ";            
            if (request.getParameter("supplier_id") != null && !request.getParameter("supplier_id").equals("")) {
                SQL += SQL.indexOf("WHERE") != -1 ? " AND supplier_id = '" + request.getParameter("supplier_id") + "' " : " WHERE supplier_id = '" + request.getParameter("supplier_id") + "' ";
            }
            
            SQL += " order by to_date(format_date(doc_date),'YYYY-MM-DD')";

            System.out.println("SQL = " + SQL);
            rs = con.createStatement().executeQuery(SQL);
            PrintWriter pw = response.getWriter();

            //System.out.println("pw ="+pw);
            pw.println("รายการสรุปรับเชื้อเพลิงโรงไฟฟ้า");
            pw.println("ช่วงวันที่ " + objuti.Format_Date_For_Mysql(request.getParameter("date_from_format")) + " ถึง " + objuti.Format_Date_For_Mysql(request.getParameter("date_to_format")) + "\n");
            pw.println("วันที่,เลขที่ใบชั่ง,ทะเบียนรถ,ชื่อผุ้ขาย,ประเภท,น้ำหนัก,ราคาต่อหน่วย,ราคารวม\n");
            //Return_param_value = String_sprit(objMdata_export.getParam_value());
            int i = 6;
            while (rs.next()) {
                Str_Writer = objuti.NotNull(rs.getString("doc_date")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("scale_no")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("car_no")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("supplier_name")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("fuel_name")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("total_weight")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("price_unit")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("total_price")) + ",";
                //Str_Writer += "=K"+i+"*"+"L"+i;
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
