<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.D_carbon_friction_withdraw_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_withdraw_detail"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_carbon_friction_withdraw_detail objdb = new DataBeanD_carbon_friction_withdraw_detail();
    D_carbon_friction_withdraw_detailDAO objex = new D_carbon_friction_withdraw_detailDAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_a") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_withdraw_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id")) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 1;
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_withdraw_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id")) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
            objdb.setLine_no(Integer.toString(statusnum + 1));
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
        objdb.setFriction_house(request.getParameter("friction_house"));
        objdb.setLocation_id(request.getParameter("location_id"));
        objdb.setWh_in(request.getParameter("wh_in"));
        objdb.setFriction_dust_bag(uti.NotNull(request.getParameter("friction_dust_bag"), "0"));
        objdb.setFriction_dust_amount(uti.NotNull(request.getParameter("friction_dust_amount"), "0"));
        objdb.setFriction_dust_weight(uti.NotNull(request.getParameter("friction_dust_weight"), "0"));
        objdb.setPan_dust_bag(uti.NotNull(request.getParameter("pan_dust_bag"), "0"));
        objdb.setPan_dust_amount(uti.NotNull(request.getParameter("pan_dust_amount"), "0"));
        objdb.setPan_dust_weight(uti.NotNull(request.getParameter("pan_dust_weight"), "0"));
        objdb.setSucker_dust_bag(uti.NotNull(request.getParameter("sucker_dust_bag"), "0"));
        objdb.setSucker_dust_amount(uti.NotNull(request.getParameter("sucker_dust_amount"), "0"));
        objdb.setSucker_dust_weight(uti.NotNull(request.getParameter("sucker_dust_weight"), "0"));
        objdb.setMagnet1(uti.NotNull(request.getParameter("magnet1"), "0"));
        objdb.setMagnet2(uti.NotNull(request.getParameter("magnet2"), "0"));
        System.out.println("friction_carbon_in_weight = " + request.getParameter("friction_carbon_in_weight"));
        objdb.setFriction_carbon_in_weight(uti.NotNull(request.getParameter("friction_carbon_in_weight"), "1"));
        objdb.setLost_weight(uti.NotNull(request.getParameter("lost_weight"), "0"));
        objdb.setCarbon_burn_in_weight(uti.NotNull(request.getParameter("carbon_burn_in_weight"), "0"));
        objdb.setJumbo_weight(uti.NotNull(request.getParameter("jumbo_weight"), "0"));
        objdb.setLaps_amount(uti.NotNull(request.getParameter("laps_amount"), "0"));
        objdb.setLaps_weight(uti.NotNull(request.getParameter("laps_weight"), "0"));
        objdb.setLaps_total(uti.NotNull(request.getParameter("laps_total"), "0"));
        objdb.setMoisture_percent(uti.NotNull(request.getParameter("moisture_percent"), "0"));
        objdb.setMoisture_weight(uti.NotNull(request.getParameter("moisture_weight"), "0"));
        System.out.println("moisture_percent = " + request.getParameter("moisture_percent"));
        System.out.println("moisture_weight = " + request.getParameter("moisture_weight"));
        objdb.setDoc_date(uti.NotNull(request.getParameter("doc_date"), ""));
        objdb.setCarbon_friction_total_weight(uti.NotNull(request.getParameter("carbon_friction_total_weight"), "0"));
    }
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
    }
%>