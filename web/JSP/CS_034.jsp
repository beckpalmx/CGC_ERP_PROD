<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="com.cgc.DB.D_carbon_withdraw_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_withdraw_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_withdraw_header objdb = new DataBeanD_carbon_withdraw_header();
    D_carbon_withdraw_headerDAO objex = new D_carbon_withdraw_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_withdraw_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_withdraw_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                        statusck = -1;
                    } else {
                        statusck = 1;
                    }
                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            } else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            objdb.setDoc_date(request.getParameter("doc_date"));
            objdb.setWh_in(request.getParameter("wh_in"));
            objdb.setWh_out(request.getParameter("wh_out"));
            objdb.setDoc_time(request.getParameter("doc_time"));
            objdb.setWork_type(en.EncodeTexttoTIS(request.getParameter("work_type")));
            objdb.setPrd_emp_id(request.getParameter("prd_emp_id"));
            objdb.setWh_emp_id(request.getParameter("wh_emp_id"));
            objdb.setWh_sup_id(request.getParameter("wh_sup_id"));
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            objdb.setComplete_flag(request.getParameter("complete_flag"));
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }

            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    
                    //objdb.setDoc_id(new Runer_Doc_id().Run_id_date("d_carbon_withdraw_header", objdb.getDoc_date()));                    
                    //String doc_id_success = new Runer_Doc_id().Run_id_date("d_carbon_withdraw_header", objdb.getDoc_date());    
                    //System.out.println(doc_id_success);
                    
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                        //out.print("บันทึกสำเร็จ เลขที่เอกสาร = "+doc_id_success);
                    }
                    break;
                case 2:
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        objex.update(objdb);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                    break;
                case 3:
                    objex.UpDel(objdb);

                    out.print("ลบข้อมูลสำเร็จ");

                    break;
                default:
                    out.print("No Statment");
            }
%>