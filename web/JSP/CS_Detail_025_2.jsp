
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detail_1DAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail_1"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_carbon_friction_receive_detail_1 objdb = new DataBeanD_carbon_friction_receive_detail_1();
    D_carbon_friction_receive_detail_1DAO objex = new D_carbon_friction_receive_detail_1DAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_receive_detail_1 where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id")) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_receive_detail_1 where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id")) + "' and delete_flag = 'N' and complete_flag = 'N'");
                    objdb.setLine_no(Integer.toString(statusnum + 1));
                }
            } else if (request.getParameter("status_u") != null) {
                statusck = 2;
                objdb.setLine_no(request.getParameter("line_no"));

            } else if (request.getParameter("status_d") != null) {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            } else if (request.getParameter("get_balance") != null) {
                statusck = Integer.parseInt(request.getParameter("get_balance"));
            } else {
                statusck = -1;
            }
            objdb.setDoc_id(request.getParameter("doc_id") != null ? request.getParameter("doc_id") : null);
            objdb.setDoc_date(request.getParameter("doc_date") != null ? request.getParameter("doc_date") : null);
            if (statusck == 1 || statusck == 2) {
                objdb.setProduct_id(request.getParameter("product_id"));
                objdb.setFriction_house(request.getParameter("friction_house"));
                objdb.setSilo_no(request.getParameter("silo_no"));
                objdb.setLocation_id(request.getParameter("location_id"));
                objdb.setBalance_weight(request.getParameter("balance_weight"));
                objdb.setRemain_weight(request.getParameter("remain_weight"));
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
                case 4:
                    break;
                default:
                    out.print("No Statment");
                    break;
            }
%>