/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_MData_export;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.sql.*;

/**
 *
 * @author Beck
 */
public class PrintCSV_FIREWOOD_EXPORT {

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
        String cred_code = request.getParameter("cred_code");
        String data_for = request.getParameter("data_for");

        System.out.println("cred_code = " + cred_code);

        //response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
        response.setHeader("Content-disposition", "inline; filename=\"Excell_" + FileName + ".csv\"");

        response.setBufferSize(1024);
        try {

            if (data_for.equals("1")) {
                SQL = "select * from vd_ticketbuy_not_cgc ";
            } else {
                SQL = "select * from vd_ticketbuy_wood_type3 ";
            }

            SQL += "WHERE to_date(format_date(doc_date),'YYYY-MM-DD') BETWEEN to_date(format_date2('" + rq_date_from + "'),'YYYY-MM-DD') AND to_date(format_date2('" + rq_date_to + "'),'YYYY-MM-DD') ";

            if (request.getParameter("cred_code") != null && !request.getParameter("cred_code").equals("")) {
                SQL += SQL.indexOf("WHERE") != -1 ? " AND cred_code = '" + request.getParameter("cred_code") + "' " : " WHERE cred_code = '" + request.getParameter("cred_code") + "' ";
            }

            SQL += " order by to_date(format_date(doc_date),'YYYY-MM-DD')";

            System.out.println("SQL = " + SQL);
            rs = con.createStatement().executeQuery(SQL);
            try (PrintWriter pw = response.getWriter()) {
                pw.println("รายการสรุปการซื้อไม้ฟืน");
                pw.println("ช่วงวันที่ " + objuti.Format_Date_For_Mysql(request.getParameter("date_from_format")) + " ถึง " + objuti.Format_Date_For_Mysql(request.getParameter("date_to_format")) + "\n");
                pw.println("วันที่,เลขที่ใบชั่ง,ทะเบียนรถ,ชื่อผุ้ขาย,ประเภท,น้ำหนักรถเข้า,น้ำหนักรถออก,น้ำหนักสุทธิ,ราคาต่อหน่วย,ราคารวม\n");
                //Return_param_value = String_sprit(objMdata_export.getParam_value());
                int i = 6;
                while (rs.next()) {
                    Str_Writer = objuti.NotNull(rs.getString("doc_date")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("ticket_text")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("truck_no")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("cred_name")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("prod_name")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("load_in")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("load_out")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("net_wght")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("price_unit")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("price_total")) + ",";

                    //Str_Writer += "=K"+i+"*"+"L"+i;
                    //Str_Writer += System.getProperty("line.separator");
                    pw.println(Str_Writer);
                    //System.out.println(Str_Writer);
                    Str_Writer = null;
                    i++;
                }
            }

        } catch (SQLException e) {
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
