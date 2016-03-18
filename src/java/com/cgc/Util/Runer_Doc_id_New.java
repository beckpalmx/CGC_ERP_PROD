/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author Beck
 */
public class Runer_Doc_id_New {

    /**
     *
     * @param Table_name_Header
     * @return
     * @throws Exception
     */
    public String Run_id(String Table_name_Header) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "";
        mem_date_now = Return_Date_Now();
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";

        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Doc_id(Table_name_Header, con);
                return_str = Return_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-0001";
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {

            if (con != null) {
                con.close();
            }
        }
        return return_str;
    }

    /**
     *
     * @param Table_name_Header
     * @param Date_Input
     * @return
     * @throws Exception
     */
    public String Run_id(String Table_name_Header,String Date_Input) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "";
        mem_date_now = Format_Date_Thai(Date_Input);
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' ";

        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Doc_id(Table_name_Header,mem_date_now, con);
                return_str = Return_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-0001";
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {

            if (con != null) {
                con.close();
            }
        }
        return return_str;
    }

    /**
     *
     * @param Table_name_Header
     * @param Date_Input
     * @return
     * @throws Exception
     */
    public String Run_id_year(String Table_name_Header,String Date_Input) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DecimalFormat df = new DecimalFormat("0000");
        String return_str = "",mem_number_year=Date_Input.substring(8, 10),SQL1="";
        try{
            SQL1 = "select count(*) as num from "+Table_name_Header+" where substring(doc_id from '%-#\"__#\"-%' for '#') = '"+mem_number_year+"'";
            if(Table_name_Header=="d_purchase_order_header"){
                return_str = "PO-"+Format_Date_Thai_Year(Date_Input)+"-"+df.format((objuti.numRowdatabase(SQL1)+1));
            } else if(Table_name_Header=="d_purchase_request_header_offer_compare") {
                return_str = "PR-"+Format_Date_Thai_Year(Date_Input)+"-"+df.format((objuti.numRowdatabase(SQL1)+1));
            } else {
                return_str = Format_Date_Thai_Year(Date_Input)+"-"+df.format((objuti.numRowdatabase(SQL1)+1));
            }
            System.out.println(Table_name_Header);            
            System.out.println("SQL1 = "+ SQL1);
            System.out.println("return_str"+return_str);           
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            return return_str;
        }
    }
    
    public String Run_id_parameter(String Table_name_Header,String doc_type) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DecimalFormat df = new DecimalFormat("00000");
        String return_str = "",SQL1="";
        try{
            SQL1 = "select count(*) as num from "+Table_name_Header+" where delete_flag <> 'Y' and doc_type = '"+ doc_type +"'";
            return_str = "P-" + df.format((objuti.numRowdatabase(SQL1)+1));            
            System.out.println(Table_name_Header);            
            System.out.println(doc_type);            
            System.out.println("SQL1 = "+ SQL1);
            System.out.println("return_str"+return_str);           
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            return return_str;
        }
    }    
    

    /**
     *
     * @param screen_id
     * @param doc_date
     * @param dept_id
     * @return
     * @throws Exception
     */
    public String Run_id_DB(String screen_id,String doc_date,String dept_id)throws Exception{
        String id = null;
        Connection con = new DBConnect().openNewConnection();
        try{
            System.out.println("screen_id = " + screen_id);
            System.out.println("dept_id = " + dept_id);
            System.out.println("doc_date = " + doc_date);
            
            id = Query_d_running_doc_id(con,doc_date , Format_Date_Thai(doc_date), dept_id, screen_id);
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            con.close();
            return id;
        }
    }
   
    /**
     *
     * @param screen_id
     * @param doc_date
     * @param dept_id
     * @param doc_type
     * @return
     * @throws Exception
     */
    public String Run_id_DB_Doc_Type(String screen_id,String doc_date,String dept_id,String doc_type)throws Exception{
        String id = null;
        Connection con = new DBConnect().openNewConnection();
        try{
            id = Query_d_running_doc_id_doc_type(con,doc_date , Format_Date_Thai(doc_date), dept_id, screen_id,doc_type);
            System.out.println("doc_type = "+doc_type);
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            con.close();
            return id;
        }
    }
    
    /**
     *
     * @return
     */
    public static String Return_Date_Now() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyMMdd",new Locale("th","TH"));
        return format.format(date);
    }
    
    /**
     *
     * @param last_id
     * @return
     */
    public static String Return_Format_id(String last_id) {
        DecimalFormat df = new DecimalFormat("0000");
        String sub_str = last_id.substring(0, 7);
        int sub_runner = Integer.parseInt(last_id.substring(7, 11)) + 1;
        return sub_str + df.format(sub_runner);
    }

    /**
     *
     * @param Table_name_header
     * @param con
     * @return
     * @throws Exception
     */
    public static String Return_Doc_id(String Table_name_header, Connection con) throws Exception {
        String[] Retrun_header = new String[2];
        String SQL = "", Retrun = "";
        ResultSet rs = null;
        try {
            SQL = "Select to_number(doc_id,'999999-9999') as doc_number,doc_id doc_id from ";
            SQL += Table_name_header;
            SQL += " order by to_number(doc_id,'999999-9999') desc limit 1";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Retrun = Retrun_header[1] = rs.getString("doc_id");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Retrun;
    }

    /**
     *
     * @param Table_name_header
     * @param Date_Input
     * @param con
     * @return
     * @throws Exception
     */
    public static String Return_Doc_id(String Table_name_header,String Date_Input, Connection con) throws Exception {
        String[] Retrun_header = new String[2];
        String SQL = "", Retrun = "";
        ResultSet rs = null;
        try {
            SQL = "Select to_number(doc_id,'999999-9999') as doc_number,doc_id doc_id from ";
            SQL += Table_name_header;
            SQL += " Where doc_id like '"+Date_Input+"%' order by to_number(doc_id,'999999-9999') desc limit 1";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Retrun = Retrun_header[1] = rs.getString("doc_id");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Retrun;
    }
    
    //Date_input = วัน-เดือน-ปี exp=>12-01-2555

    /**
     *
     * @param Date_Input
     * @return
     */
        public static String Format_Date_Thai(String Date_Input){
        return Date_Input.substring(8, 10)+Date_Input.substring(3, 5)+Date_Input.substring(0, 2);               
    }
    
    /**
     *
     * @param Date_Input
     * @return
     */
    public static String Format_Date_Thai_Year(String Date_Input){
        return Date_Input.substring(8, 10);        
    }    
   
    /**
     *
     * @param con
     * @param doc_date
     * @param doc_date_format
     * @param dept_id
     * @param screen_id
     * @return
     * @throws Exception
     */
    public String Query_d_running_doc_id(Connection con,String doc_date,String doc_date_format,String dept_id,String screen_id)throws Exception{
        PreparedStatement p = null;
        ResultSet rs = null;
        UtiDatabase objuti = new UtiDatabase();
        String return_string = null,SQL =null;
        try{
            SQL = "select count(*) as num from vd_running_doc_id where run_doc_id = '"+doc_date_format+"' and dp_id = '"+dept_id+"' and m_screen_id = '"+screen_id+"'";
            if(objuti.numRowdatabase(SQL) != 0){
                SQL = "select format_run_count from vd_running_doc_id where run_doc_id = '"+doc_date_format+"' and dp_id = '"+dept_id+"' and m_screen_id = '"+screen_id+"'";
                System.out.println("SQL = " +SQL);
                rs = con.createStatement().executeQuery(SQL);
                while(rs.next()){
                    return_string = doc_date_format+"-"+dept_id+"-"+rs.getString("format_run_count");
                }
                p = con.prepareStatement("update d_running_doc_id  set run_count = trim(to_char(to_number(run_count,'9990')+1,'9990')) where run_doc_id = '"+doc_date_format+"' and dp_id = '"+dept_id+"' and m_screen_id = '"+screen_id+"'");
                p.executeUpdate();
            }else{
                p = con.prepareStatement("insert into d_running_doc_id(run_doc_id,run_doc_date,dp_id,run_count,m_screen_id) values(?,?,?,?,?)");
                p.setString(1, doc_date_format);
                p.setString(2, doc_date);
                p.setString(3, dept_id);
                p.setString(4, "1");
                p.setString(5, screen_id);
                p.executeUpdate();
                return_string = doc_date_format+"-"+dept_id+"-0001";
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            if(rs != null){
                rs.close();
            }
            return return_string;
        }
    }

    /**
     *
     * @param con
     * @param doc_date
     * @param doc_date_format
     * @param dept_id
     * @param screen_id
     * @param doc_type
     * @return
     * @throws Exception
     */
    public String Query_d_running_doc_id_doc_type(Connection con,String doc_date,String doc_date_format,String dept_id,String screen_id,String doc_type)throws Exception{
        PreparedStatement p = null;
        ResultSet rs = null;
        UtiDatabase objuti = new UtiDatabase();
        String return_string = null,SQL =null;
        try{
            SQL = "select count(*) as num from vd_running_doc_id where run_doc_id = '"+doc_date_format+"' and dp_id = '"+dept_id+"' and m_screen_id = '"+screen_id+"'";
            if(objuti.numRowdatabase(SQL) != 0){
                SQL = "select format_run_count from vd_running_doc_id where run_doc_id = '"+doc_date_format+"' and dp_id = '"+dept_id+"' and m_screen_id = '"+screen_id+"'";
                System.out.println("SQL = " +SQL);
                System.out.println("doc_type = "+doc_type);
                rs = con.createStatement().executeQuery(SQL);
                while(rs.next()){
                    return_string = doc_date_format+"-"+doc_type+"-"+dept_id+"-"+rs.getString("format_run_count");
                    System.out.println("doc_type = "+doc_type);
                }
                p = con.prepareStatement("update d_running_doc_id  set run_count = trim(to_char(to_number(run_count,'9990')+1,'9990')) where run_doc_id = '"+doc_date_format+"' and dp_id = '"+dept_id+"' and m_screen_id = '"+screen_id+"'");
                p.executeUpdate();
            }else{
                p = con.prepareStatement("insert into d_running_doc_id(run_doc_id,run_doc_date,dp_id,run_count,m_screen_id) values(?,?,?,?,?)");
                p.setString(1, doc_date_format);
                p.setString(2, doc_date);
                p.setString(3, dept_id);
                p.setString(4, "1");
                p.setString(5, screen_id);
                p.executeUpdate();
                return_string = doc_date_format+"-"+doc_type+"-"+dept_id+"-0001";
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            if(rs != null){
                rs.close();
            }
            return return_string;
        }
    }    
    
    
}
