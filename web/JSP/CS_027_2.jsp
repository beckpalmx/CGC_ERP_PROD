
<%@page import="com.cgc.DB.D_carbon_burn_in_header_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_in_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_burn_in_header objdb = new DataBeanD_carbon_burn_in_header();
    D_carbon_burn_in_header_whDAO objex = new D_carbon_burn_in_header_whDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_in_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_in_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
    objdb.setComplete_flag(request.getParameter("document_confirm_flag"));
    objdb.setReturn_document_flag(request.getParameter("return_complete_flag"));
    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setDate(ts);
    objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    if (request.getParameter("remark") != null) {
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            break;
        case 2:
            objex.update(objdb);
            out.print("แก้ไขสำเร็จ");
            /*if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
             objex.update(objdb);
             out.print("แก้ไขสำเร็จ");
             }else{
             out.print("edit");
             }*/
            break;
        case 3:
            break;
        default:
            out.print("No Statment");
    }
%>