
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detail_2DAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail_2"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    String location_id_ref;
    DataBeanD_carbon_friction_receive_detail_2 objdb = new DataBeanD_carbon_friction_receive_detail_2();
    D_carbon_friction_receive_detail_2DAO objex = new D_carbon_friction_receive_detail_2DAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    String SQL_Count;
    System.out.println("status_a = " + request.getParameter("status_a"));
    System.out.println("status_u = " + request.getParameter("status_u"));
    if (request.getParameter("status_a") != null) {
        SQL_Count = "Select Count(doc_id) As num from  d_carbon_friction_receive_detail_2 "
                + " where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id")) + "' "
                + " and delete_flag = 'N' and complete_flag = 'Y'";
        System.out.println("1 SQL_Count = " + SQL_Count);
        if (uti.numRowdatabase(SQL_Count) != 0) {
            System.out.println("Insert line_no = " + request.getParameter("line_no"));
            statusck = -1;
        } else {
            statusck = 1;
            System.out.println("Update line_no = " + request.getParameter("line_no"));
            SQL_Count = "Select Count(doc_id) As num from  d_carbon_friction_receive_detail_2 "
                    + " where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id"))
                    + "' and delete_flag = 'N' and complete_flag = 'N'";
            statusnum = uti.numRowdatabase(SQL_Count);
            objdb.setLine_no(Integer.toString(statusnum + 1));
            System.out.println("2 SQL_Count = " + SQL_Count);
            System.out.println("statusnum = " + statusnum);
        }
    } else if (request.getParameter("status_u") != null) {
        statusck = 2;
        objdb.setLine_no(request.getParameter("line_no"));

    } else if (request.getParameter("status_d") != null) {
        statusck = Integer.parseInt(request.getParameter("status_d"));
    } else {
        statusck = -1;
    }
    objdb.setDoc_id(request.getParameter("doc_id"));
    if (statusck == 1 || statusck == 2) {
        objdb.setProduct_id(request.getParameter("product_id"));
        objdb.setBag_no(request.getParameter("bag_no"));
        objdb.setLocation_id(request.getParameter("location_id"));
        objdb.setAmount_bag(request.getParameter("bag"));
        objdb.setWeight(request.getParameter("amount"));
        objdb.setTotal_weight(request.getParameter("weight"));
        objdb.setWh_in(request.getParameter("wh_in"));
        objdb.setDoc_date(request.getParameter("doc_date"));
    }

    if (request.getParameter("location_id") != null) {
        if (request.getParameter("location_id").contains("B")) {
            location_id_ref = request.getParameter("location_id").replace("B", "");
        } else if (request.getParameter("location_id").contains("F")) {
            location_id_ref = request.getParameter("location_id").replace("F", "");
        }
        objdb.setLocation_id_ref(location_id_ref);
    }

    System.out.println("location_id_ref = " + location_id_ref);

    objdb.setBy(((UserBean) session.getAttribute("user")).getUsername());
    objdb.setDate(new Timestamp(new java.util.Date().getTime()));

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            objex.insert(objdb);
            out.print("บันทึกสำเร็จ");
            break;
        case 2:
            objex.update(objdb);
            out.print("แก้ไขสำเร็จ");
            break;
        case 3:
            if (request.getParameter("chk_all") != null) {
                objex.Delete_line_no_All(objdb);
            } else {
                objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
            }
            break;
        default:
            out.print("No Statment");
            break;
    }
%>