/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Beck
 */
public class Runer_Doc_id {

    public String Run_id(String Table_name_Header, String Table_name_Detail) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();

        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "", SQL2 = "";
        mem_date_now = Return_Date_Now();
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        SQL2 = "Select count(doc_id) as num from " + Table_name_Detail + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Doc_id(Table_name_Header, Table_name_Detail, con);
                return_str = Return_Format_id(mem_rs);
            } else if (objuti.numRowdatabase(SQL2) != 0) {
                mem_rs = Return_Doc_id(Table_name_Header, Table_name_Detail, con);
                return_str = Return_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-001";
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

    public String Run_Packing_id(String runer_id, String Table_name_Header, String Table_name_Detail) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();

        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "", SQL2 = "";
        String format_type = "P";
        mem_date_now = Return_Year_Month(runer_id, format_type);
        System.out.println("LP Return_Year_Month = " + mem_date_now);
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        System.out.println("SQL1 = " + SQL1);
        SQL2 = "Select count(doc_id) as num from " + Table_name_Detail + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        System.out.println("SQL2 = " + SQL2);
        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Pack_Doc_id(mem_date_now, Table_name_Header, Table_name_Detail, con);
                return_str = Return_Pack_Format_id(mem_rs);
            } else if (objuti.numRowdatabase(SQL2) != 0) {
                mem_rs = Return_Pack_Doc_id(mem_date_now, Table_name_Header, Table_name_Detail, con);
                return_str = Return_Pack_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-001";
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

    public String Run_Requisition_id(String runer_id, String Table_name_Header, String Table_name_Detail) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();

        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "", SQL2 = "";
        String format_type = "R";
        mem_date_now = Return_Year_Month(runer_id, format_type);
        System.out.println("LP Return_Year_Month = " + mem_date_now);
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        System.out.println("SQL1 = " + SQL1);
        SQL2 = "Select count(doc_id) as num from " + Table_name_Detail + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        System.out.println("SQL2 = " + SQL2);
        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Requisition_Doc_id(mem_date_now, Table_name_Header, Table_name_Detail, con);
                return_str = Return_Requisition_Format_id(mem_rs);
            } else if (objuti.numRowdatabase(SQL2) != 0) {
                mem_rs = Return_Requisition_Doc_id(mem_date_now, Table_name_Header, Table_name_Detail, con);
                return_str = Return_Requisition_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "001";
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

    public String Run_Next_id(String runer_id, String Table_name_Header, String Table_name_Detail) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();

        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "", SQL2 = "";
        System.out.println("Run_Next_id 1 : " + runer_id);
        mem_date_now = Return_Year_Month_Date(runer_id);
        System.out.println("Run_Next_id 2 : " + runer_id);
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        SQL2 = "Select count(doc_id) as num from " + Table_name_Detail + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Next_Doc_id(mem_date_now, Table_name_Header, Table_name_Detail, con);
                System.out.println("Run_Next_id = " + mem_rs);
                return_str = Return_Next_Format_id(mem_rs);
                //} else if (objuti.numRowdatabase(SQL2) != 0) {
                //    mem_rs = Return_Next_Doc_id(mem_date_now,Table_name_Header, Table_name_Detail, con);
                //    return_str = Return_Next_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-001";
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

    public String Run_id_date(String Table_name_Header, String Date_Input) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "";
        mem_date_now = Format_Date_Thai(Date_Input);

        System.out.println("Date_Input = " + Date_Input);
        System.out.println("mem_date_now = " + mem_date_now);

        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%'  ";

        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Doc_id_date(Table_name_Header, mem_date_now, con);
                return_str = Return_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-001";
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

    public static String Return_Date_Now() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyMMdd");
        System.out.println("Date = " + date);
        System.out.println("format.format(date) = " + format.format(date));
        return format.format(date);
    }

    public static String Return_Year_Month(String runer_id, String format_type) {
        String Run_doc_Year_Month = "";
        System.out.println("Before Substring runer_id = " + runer_id);
        if (format_type.equals("P")) {
            Run_doc_Year_Month = runer_id.substring(8, 10) + "-" + runer_id.substring(3, 5);
        } else {
            Run_doc_Year_Month = runer_id.substring(8, 10) + runer_id.substring(3, 5);
        }
        System.out.println("Run_doc_Year_Month = " + Run_doc_Year_Month);
        return Run_doc_Year_Month;
    }

    public static String Return_Year_Month_Date(String runer_id) {
        System.out.println("Before Substring runer_id = " + runer_id);
        String Run_doc_Year_Month_Date = runer_id.substring(8, 10) + runer_id.substring(3, 5) + runer_id.substring(0, 2);
        System.out.println("Run_doc_Year_Month_Date = " + Run_doc_Year_Month_Date);
        return Run_doc_Year_Month_Date;
    }

    public static String Return_Format_id(String last_id) {
        DecimalFormat df = new DecimalFormat("000");
        String sub_str = last_id.substring(0, 7);
        int sub_runner = Integer.parseInt(last_id.substring(7, 10)) + 1;
        return sub_str + df.format(sub_runner);
    }

    public static String Return_Pack_Format_id(String last_id) {
        DecimalFormat df = new DecimalFormat("000");
        String sub_str = last_id.substring(0, 6);
        int sub_runner = Integer.parseInt(last_id.substring(6, 9)) + 1;
        String str_id = last_id.substring(6, 9);
        System.out.println("str_id = " + str_id);   
        System.out.println("sub_str = " + sub_str);
        System.out.println("sub_runner = " + sub_runner);
        System.out.println("Return_Format_id = " + sub_str + df.format(sub_runner));
        return sub_str + df.format(sub_runner);
        //return df.format(sub_runner);
    }

    public static String Return_Requisition_Format_id(String last_id) {
        DecimalFormat df = new DecimalFormat("000");
        String sub_str = last_id.substring(0, 4);
        String str_id = last_id.substring(4, 7);
        int sub_runner = Integer.parseInt(last_id.substring(4, 7)) + 1;
        System.out.println("str_id = " + str_id);     
        System.out.println("sub_runner = " + sub_runner);
        System.out.println("Return_Format_id = " + sub_str + df.format(sub_runner));
        return sub_str + df.format(sub_runner);
        //return df.format(sub_runner);
    }

    public static String Return_Next_Format_id(String last_id) {
        DecimalFormat df = new DecimalFormat("000");
        System.out.println("last_id = " + last_id);
        String sub_str = last_id.substring(0, 7);
        int sub_runner = Integer.parseInt(last_id.substring(8, 10)) + 1;
        System.out.println("sub_str = " + sub_str);
        System.out.println("sub_runner = " + sub_runner);
        System.out.println("Return_Format_id = " + sub_str + df.format(sub_runner));
        return sub_str + df.format(sub_runner);
        //return df.format(sub_runner);
    }

    public static String Return_Doc_id(String Table_name_header, String Table_name_detail, Connection con) throws Exception {
        String[] Return_header = new String[2];
        String[] Return_detail = new String[2];
        String SQL = "", Return = "";
        ResultSet rs = null;
        try {
            for (int i = 1; i <= 2; i++) {
                SQL = "Select to_number(doc_id,'999999-999') as doc_number,doc_id doc_id from ";
                SQL += i == 1 ? Table_name_header : Table_name_detail;
                SQL += " where delete_flag = 'N'  order by to_number(doc_id,'999999-999') desc";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if (rs.isFirst()) {
                        if (i == 1) {
                            Return_header[0] = rs.getString("doc_number");
                            Return_header[1] = rs.getString("doc_id");
                            break;
                        } else {
                            Return_detail[0] = rs.getString("doc_number");
                            Return_detail[1] = rs.getString("doc_id");
                            break;
                        }
                    }
                }
                continue;
            }
            if (Integer.parseInt(Return_header[0]) >= Integer.parseInt(Return_detail[0])) {
                Return = Return_header[1];
            } else {
                Return = Return_detail[1];
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Return;
    }

    public static String Return_Pack_Doc_id(String mem_date_now, String Table_name_header, String Table_name_detail, Connection con) throws Exception {
        String[] Return_header = new String[2];
        String[] Return_detail = new String[2];
        String SQL = "", Return = "";
        ResultSet rs = null;
        try {
            for (int i = 1; i <= 2; i++) {
                SQL = "Select to_number(doc_id,'99-99-999') as doc_number,doc_id doc_id from ";
                SQL += i == 1 ? Table_name_header : Table_name_detail;
                SQL += " where delete_flag = 'N'  ";
                SQL += " and doc_id like '" + mem_date_now + "%'";
                SQL += " order by to_number(doc_id,'99-99-999') desc";
                System.out.println("Return_Pack_Doc_id SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if (rs.isFirst()) {
                        if (i == 1) {
                            Return_header[0] = rs.getString("doc_number");
                            Return_header[1] = rs.getString("doc_id");
                            break;
                        } else {
                            Return_detail[0] = rs.getString("doc_number");
                            Return_detail[1] = rs.getString("doc_id");
                            break;
                        }
                    }

                    System.out.println("doc_number" + rs.getString("doc_number"));

                }
                continue;
            }
            if (Integer.parseInt(Return_header[0]) >= Integer.parseInt(Return_detail[0])) {
                Return = Return_header[1];
                System.out.println("Ret H = " + Return);
            } else {
                Return = Return_detail[1];
                System.out.println("Ret D = " + Return);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Return;
    }

    public static String Return_Requisition_Doc_id(String mem_date_now, String Table_name_header, String Table_name_detail, Connection con) throws Exception {
        String[] Return_header = new String[2];
        String[] Return_detail = new String[2];
        String SQL = "", Return = "";
        ResultSet rs = null;
        try {
            for (int i = 1; i <= 2; i++) {
                SQL = "Select to_number(doc_id,'9999999') as doc_number,doc_id doc_id from ";
                SQL += i == 1 ? Table_name_header : Table_name_detail;
                SQL += " where delete_flag = 'N'  ";
                SQL += " and doc_id like '" + mem_date_now + "%'";
                SQL += " order by to_number(doc_id,'9999999') desc";
                System.out.println("Return_Pack_Doc_id SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if (rs.isFirst()) {
                        if (i == 1) {
                            Return_header[0] = rs.getString("doc_number");
                            Return_header[1] = rs.getString("doc_id");
                            break;
                        } else {
                            Return_detail[0] = rs.getString("doc_number");
                            Return_detail[1] = rs.getString("doc_id");
                            break;
                        }
                    }

                    System.out.println("doc_number" + rs.getString("doc_number"));

                }
                continue;
            }
            if (Integer.parseInt(Return_header[0]) >= Integer.parseInt(Return_detail[0])) {
                Return = Return_header[1];
            } else {
                Return = Return_detail[1];
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Return;
    }

    public static String Return_Next_Doc_id(String mem_date_now, String Table_name_header, String Table_name_detail, Connection con) throws Exception {
        String[] Return_header = new String[2];
        String[] Return_detail = new String[2];
        String SQL = "", Return = "";
        ResultSet rs = null;
        try {

            SQL = "Select to_number(doc_id,'999999-999') as doc_number,doc_id doc_id from " + Table_name_header;
            SQL += " where delete_flag = 'N'  ";
            SQL += " and doc_id like '" + mem_date_now + "%'";
            SQL += " order by to_number(doc_id,'999999-999') desc";
            System.out.println("Return_Next_Doc_id SQL = " + SQL);
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                if (rs.isFirst()) {
                    Return_header[0] = rs.getString("doc_number");
                    Return_header[1] = rs.getString("doc_id");
                    System.out.println("in doc_number" + rs.getString("doc_number"));
                    break;
                }
                continue;
            }

            Return = Return_header[1];

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Return;
    }

    public static String Return_Doc_id_date(String Table_name_header, String Date_Input, Connection con) throws Exception {
        String[] Return_header = new String[2];
        String SQL = "", Return = "";
        ResultSet rs = null;
        try {
            SQL = "Select to_number(doc_id,'999999-9999') as doc_number,doc_id doc_id from ";
            SQL += Table_name_header;
            SQL += " Where doc_id like '" + Date_Input + "%' order by to_number(doc_id,'999999-9999') desc limit 1";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Return = Return_header[1] = rs.getString("doc_id");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Return;
    }

    //Date_input = วัน-เดือน-ปี exp=>12-01-2555
    public static String Format_Date_Thai(String Date_Input) {
        return Date_Input.substring(8, 10) + Date_Input.substring(3, 5) + Date_Input.substring(0, 2);
    }
}
