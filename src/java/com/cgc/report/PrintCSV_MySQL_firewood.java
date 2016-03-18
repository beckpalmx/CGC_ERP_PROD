/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_MData_export;
import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.sql.*;

/**
 *
 * @author Beck
 */
public class PrintCSV_MySQL_firewood {

    static DataBean_MData_export objMdata_export;
    UtiDatabase objuti;

    public void ExportCSV(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        String Str_Writer = "", SQL = null;
        //DBConnect objcon = new DBConnect();
        Connection con_mysql = new DBConnect().openNewConnectionMySQL();
        Connection con_postgress = new DBConnect().openNewConnection();
        ResultSet rs = null;
        objuti = new UtiDatabase();
        response.setContentType("application/csv");
        java.util.Date date = new java.util.Date();
        System.out.println(new Timestamp(date.getTime()));            
        java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());
        String FileName = date.toString();
        String SQL_Search = "";

        //response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
        response.setHeader("Content-disposition", "inline; filename=\"Excell_" + FileName + ".csv\"");

        response.setBufferSize(1024);
        try {

            SQL = "select ticket_text,truck_no,date_in,time_in,date_out,time_out,load_in,load_out,net_wght,cred_name,prod_code,prod_name,substring(Date_In,1,2) as date1,substring(Date_In,4,2) as month1,substring(Date_In,7,4) as year1,cost_unt from ticketbuy"
                    + " where ticket_text <> '' and (prod_code = '04' or prod_code = '05'or prod_code = '18'or prod_code = '19') and "
                    + " str_to_date(date_in,'%d/%m/%Y')"
                    + " between str_to_date('" + objuti.Format_Date_For_Mysql(request.getParameter("date_from_format")) + "','%d-%m-%Y') and  str_to_date('" + objuti.Format_Date_For_Mysql(request.getParameter("date_to_format")) + "','%d-%m-%Y')"
                    + " order by ticket ";
            
            
            System.out.println("Date Form = " + request.getParameter("date_from_format"));
                    
            System.out.println("SQL = " + SQL);

            rs = con_mysql.createStatement().executeQuery(SQL);
            PrintWriter pw = response.getWriter();

            //System.out.println("pw ="+pw);
            pw.println("รายการชั่งน้ำหนัก ไม้สับ-เปลือกยูคาฯ");
            pw.println("ช่วงวันที่ " + objuti.Format_Date_For_Mysql(request.getParameter("date_from_format")) + " ถึง " + objuti.Format_Date_For_Mysql(request.getParameter("date_to_format")) + "\n");
            pw.println("เลขที่เอกสาร,ทะเบียนรถ,วันที่รถเข้า,เวลาเข้า,วันที่รถออก,เวลาออก,ผู้ขาย,สินค้า,น้ำหนักเข้า(ก.ก.),น้ำหนักออก(ก.ก.),น้ำหนักสุทธิ(ก.ก.),ราคา/หน่วย,รวมราคา\n");
            //Return_param_value = String_sprit(objMdata_export.getParam_value());
            int i = 6;
            while (rs.next()) {

                SQL_Search = "Select Count(ticket_text) As num from  d_ticketbuy where ticket_text ='" + rs.getString("ticket_text") + "' and delete_flag <> 'Y'  ";
                int a = objuti.numRowdatabase(SQL_Search);
                if (a == 0) {
                    String sql1 = "insert into d_ticketbuy (ticket_text,truck_no,date_in,time_in,date_out"
                            + ",time_out,cred_name,prod_code,prod_name,load_in,load_out,net_wght,cost_unt,date1,month1,year1,create_date,create_by,doc_id,doc_date,doc_time)"
                            + " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    System.out.println("sql1 = " + sql1);
                    PreparedStatement p = null;
                    p = con_postgress.prepareStatement(sql1);
                    p.setString(1, objuti.NotNull(rs.getString("ticket_text")));
                    p.setString(2, objuti.NotNull(rs.getString("truck_no")));
                    p.setString(3, objuti.NotNull(rs.getString("date_in")));
                    p.setString(4, objuti.NotNull(rs.getString("time_in")));
                    p.setString(5, objuti.NotNull(rs.getString("date_out")));                    
                    p.setString(6, objuti.NotNull(rs.getString("time_out")));                    
                    p.setString(7, objuti.NotNull(rs.getString("cred_name")));                    
                    p.setString(8, objuti.NotNull(rs.getString("prod_code")));                    
                    p.setString(9, objuti.NotNull(rs.getString("prod_name")));   
                    p.setString(10, objuti.NotNull(rs.getString("load_in")));                       
                    p.setString(11, objuti.NotNull(rs.getString("load_out")));                              
                    p.setString(12, objuti.NotNull(rs.getString("net_wght")));    
                    p.setString(13, objuti.NotNull(rs.getString("cost_unt")));                        
                    p.setString(14, objuti.NotNull(rs.getString("date1")));                              
                    p.setString(15, objuti.NotNull(rs.getString("month1")));    
                    p.setString(16, objuti.NotNull(rs.getString("year1")));                       
                    p.setTimestamp(17,timestamp );    
                    p.setString(18, "System Import");
                    p.setString(19, objuti.NotNull(rs.getString("date1"))+ "-" + objuti.NotNull(rs.getString("month1")) + "-" + objuti.NotNull(rs.getString("year1")));
                    p.setString(20, objuti.NotNull(rs.getString("date1"))+ "-" + objuti.NotNull(rs.getString("month1")) + "-" + objuti.NotNull(rs.getString("year1")));
                    p.setString(21, objuti.NotNull(rs.getString("time_in")));
                    p.executeUpdate();                                        
                } else {                    
                    String sql2 = "update d_ticketbuy set ticket_text=?,truck_no=?,date_in=?,time_in=?,date_out=?"
                            //+ ",time_out=?,cred_name=?,prod_code=?,prod_name=?,load_in=?,load_out=?,net_wght=?,cost_unt=?,date1=?,month1=?,year1=?"
                            + ",time_out=?,cred_name=?,prod_code=?,prod_name=?,load_in=?,load_out=?,net_wght=?,date1=?,month1=?,year1=?"
                            + ",update_date=?,update_by=?"
                            + " where ticket_text = '" + rs.getString("ticket_text") + "'";
                    System.out.println("sql2 = " + sql2);
                    PreparedStatement p = null;
                    p = con_postgress.prepareStatement(sql2);                    
                    p.setString(1, objuti.NotNull(rs.getString("ticket_text")));
                    p.setString(2, objuti.NotNull(rs.getString("truck_no")));
                    p.setString(3, objuti.NotNull(rs.getString("date_in")));
                    p.setString(4, objuti.NotNull(rs.getString("time_in")));
                    p.setString(5, objuti.NotNull(rs.getString("date_out")));                    
                    p.setString(6, objuti.NotNull(rs.getString("time_out")));                    
                    p.setString(7, objuti.NotNull(rs.getString("cred_name")));                    
                    p.setString(8, objuti.NotNull(rs.getString("prod_code")));                    
                    p.setString(9, objuti.NotNull(rs.getString("prod_name")));   
                    p.setString(10, objuti.NotNull(rs.getString("load_in")));                       
                    p.setString(11, objuti.NotNull(rs.getString("load_out")));                              
                    p.setString(12, objuti.NotNull(rs.getString("net_wght")));    
                    //p.setString(13, objuti.NotNull(rs.getString("cost_unt")));                        
                    p.setString(13, objuti.NotNull(rs.getString("date1")));                              
                    p.setString(14, objuti.NotNull(rs.getString("month1")));    
                    p.setString(15, objuti.NotNull(rs.getString("year1")));                       
                    p.setTimestamp(16,timestamp );    
                    p.setString(17, "System Import");                    
                    p.executeUpdate();                                        
                
                }

                Str_Writer = objuti.NotNull(rs.getString("ticket_text")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("truck_no")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("date_in")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("time_in")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("date_out")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("time_out")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("cred_name")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("prod_code")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("prod_name")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("load_in")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("load_out")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("net_wght")) + ",";
                Str_Writer += objuti.NotNull(rs.getString("cost_unt")) + ",";
                Str_Writer += "=L" + i + "*" + "M" + i;
                //Str_Writer += System.getProperty("line.separator");

                pw.println(Str_Writer);
                System.out.println(Str_Writer);
                Str_Writer = null;
                i++;
            }

            pw.close();
            System.out.println("End Process ::: " + timestamp);

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con_mysql != null) {
                con_mysql.close();
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
