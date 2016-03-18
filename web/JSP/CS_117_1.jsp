<%@page import="com.cgc.DB.D_adjust_rawmat_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_adjust_product_detail"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_adjust_product_detail objdb = new DataBeanD_adjust_product_detail();
    D_adjust_rawmat_detailDAO objex = new D_adjust_rawmat_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_adjust_rawmat_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_adjust_rawmat_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
            if (request.getParameter("doc_type") != null) {
                objdb.setDoc_type(en.EncodeTexttoTIS(request.getParameter("doc_type").trim()));
            }
            if (request.getParameter("doc_date") != null) {
                objdb.setDoc_date(en.EncodeTexttoTIS(request.getParameter("doc_date").trim()));
            }            
            if (request.getParameter("product_id") != null) {
                objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));

            }
            if (request.getParameter("location_id") != null) {
                objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(request.getParameter("weight"));

            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            if (request.getParameter("username") != null) {
                objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            }
            
            
            System.out.println("status_a = " + request.getParameter("status_a"));
            System.out.println("status_u = " + request.getParameter("status_u"));
            System.out.println("status_d = " + request.getParameter("status_d"));
            System.out.println("statusck = " + statusck);
            
            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("ไม่สามารถบันทึกได้");
                    }
                    break;
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("ไม่สามารถบันทึกได้");
                    }
                    break;
                case 3:
                    
                    System.out.println("Delete Line_NO  = " + request.getParameter("line_no") ) ;
                    objex.Delete_line_no(request.getParameter("line_no"), objdb, "d_adjust_rawmat_detail");
                    out.print("ลบข้อมูลสำเร็จ");
                    
                    
/*
                    if (request.getParameter("chk_all") != null) {
                        objex.Delete_line_no_All(objdb);
                    } else {
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                    }
*/        
                    break;
                default:
                    out.print("No Statment");
            }
%>