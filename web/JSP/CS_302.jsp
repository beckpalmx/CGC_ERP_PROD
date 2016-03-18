
<%@page import="com.cgc.DB.D_carbon_withdraw_header_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_withdraw_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_withdraw_header  objdb = new DataBeanD_carbon_withdraw_header();
    D_carbon_withdraw_header_whDAO  objex = new D_carbon_withdraw_header_whDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null ) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_withdraw_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                     if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_withdraw_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                    statusck = -1;
                    } else {
                    statusck = 1;
                    }
                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            }else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
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
            objdb.setComplete_flag(request.getParameter("return_complete_flag"));
            objdb.setDoc_type(request.getParameter("document_confirm_flag"));
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }

            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                    }
                    break;
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("แก้ไขสำเร็จ");
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