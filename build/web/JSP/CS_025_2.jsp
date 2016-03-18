<%@page import="com.cgc.bean.UserBean"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_carbon_friction_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>

<%
    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_friction_header objdb = new DataBeanD_carbon_friction_header();
    D_carbon_friction_headerDAO objex = new D_carbon_friction_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDoc_date(request.getParameter("doc_date"));
    }
    if (statusck == 1 || statusck == 2) {
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDoc_date(request.getParameter("doc_date"));
        objdb.setDoc_time(request.getParameter("doc_time"));
        objdb.setReport_id(request.getParameter("report_id"));
        //objdb.setRemark(request.getParameter("remark"));
        objdb.setShift(request.getParameter("shift"));
    }

    if (request.getParameter("remark") != null) {
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }

    objdb.setComplete_flag(request.getParameter("complete_flag"));
    System.out.println("Complete Status : " + request.getParameter("complete_flag"));
    objdb.setBy(((UserBean) session.getAttribute("user")).getUsername());
    objdb.setDate(new Timestamp(new java.util.Date().getTime()));
    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            objdb.setDoc_id(new Runer_Doc_id().Run_id_date("d_carbon_friction_header", objdb.getDoc_date()));
            objex.insert(objdb);
            out.print("บันทึกสำเร็จ");
            break;
        case 2:
            objex.update(objdb);
            out.print("แก้ไขสำเร็จ");
            break;
        case 3:
            objex.delete(objdb);

            out.print("ลบข้อมูลสำเร็จ");

            break;
        default:
            out.print("No Statment");
    }
%>