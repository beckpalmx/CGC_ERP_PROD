
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_carbon_friction_receive_detail objdb = new DataBeanD_carbon_friction_receive_detail();
    D_carbon_friction_receive_detailDAO objex = new D_carbon_friction_receive_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_receive_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_receive_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
                //JOptionPane.showConfirmDialog(null, objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if (request.getParameter("silo_no") != null) {
                objdb.setSilo_no(en.EncodeTexttoTIS(request.getParameter("silo_no")));
            }
            if (request.getParameter("weight_balance") != null) {
                objdb.setWeight_balance(en.EncodeTexttoTIS(request.getParameter("weight_balance")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            if (request.getParameter("username") != null) {
                objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            }
            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    if (uti.numRowdatabase("Select Count(silo_no) As num from  d_carbon_friction_receive_detail where doc_id = '" + objdb.getDoc_id() + "' and silo_no = '" + objdb.getSilo_no() + "' and delete_flag = 'N' and complete_flag = 'N'") == 0) {

                        if (objex.insert(objdb) != -1) {
                            out.print("บันทึกสำเร็จ");
                        } else {
                            out.print("ไม่สามารถบันทึกได้");
                        }
                    } else {
                        out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื้องจากมีไซโลอยู่แล้ว");
                    }
                    break;
                case 2:
                    if (uti.numRowdatabase("Select Count(silo_no) As num from  d_carbon_friction_receive_detail where doc_id = '" + objdb.getDoc_id() + "' and silo_no = '" + objdb.getSilo_no() + "' and delete_flag = 'N' and complete_flag = 'N'") == 0) {

                        if (objex.update(objdb) != -1) {
                            out.print("แก้ไขสำเร็จ");
                        } else {
                            out.print("ไม่สามารถบันทึกได้");
                        }
                    } else {
                        out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื้องจากมีไซโลอยู่แล้ว");
                    }

                    break;
                case 3:

                    if (request.getParameter("chk_all") != null) {
                        //JOptionPane.showConfirmDialog(null,request.getParameter("chk_all"));
                        objex.Delete_line_no_All(objdb);
                    } else {
                        //JOptionPane.showConfirmDialog(null, request.getParameter("ckbox"));
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>