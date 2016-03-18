
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_carbon_burn_in_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_in_detail"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_carbon_burn_in_detail objdb = new DataBeanD_carbon_burn_in_detail();
    D_carbon_burn_in_detailDAO objex = new D_carbon_burn_in_detailDAO();


%>
<%

            int total = 0;
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_in_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_in_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
            if (request.getParameter("doc_id") != null) {
                objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            }
            if (request.getParameter("product_id") != null) {
                objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));
            }
            if (request.getParameter("location_id") != null) {
                objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if (request.getParameter("silo_no") != null) {
                objdb.setSilo_no(en.EncodeTexttoTIS(request.getParameter("silo_no")));
            }
            if (request.getParameter("tank_suite") != null) {
                objdb.setTank_suite(en.EncodeTexttoTIS(request.getParameter("tank_suite")));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(request.getParameter("weight"));
            }
            if (request.getParameter("weight_tot") != null) {
                objdb.setWeight_tot(request.getParameter("weight_tot"));
            }
            if (request.getParameter("weight_tank") != null) {
                objdb.setWeight_tank(request.getParameter("weight_tank"));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            if (request.getParameter("channel") != null) {
                objdb.setChannel(request.getParameter("channel"));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            objdb.setDate(ts);

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

                    if (request.getParameter("chk_all") != null) {
                        //JOptionPane.showConfirmDialog(null,request.getParameter("chk_all"));
                        total = objex.Delete_line_no_All(objdb);
                        out.print(total);
                    } else {

                        total = objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                        out.print(total);
                        //JOptionPane.showConfirmDialog(null, total);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>