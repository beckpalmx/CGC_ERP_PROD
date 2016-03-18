<%@page import="com.cgc.DB.D_job_order_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_job_order_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_job_order_header objdb = new DataBeanD_job_order_header();
    D_job_order_headerDAO objex = new D_job_order_headerDAO();
    UtiDatabase uti = new UtiDatabase();
%>
<%
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
            objdb.setApprove(request.getParameter("complete_flag"));
            objdb.setDoc_type(request.getParameter("close_job_type"));
            objdb.setRemark(request.getParameter("close_job_type").equals("1") ? "" : en.EncodeTexttoTIS(request.getParameter("remark_close_job_order")));
            objdb.setDate(new Timestamp(new java.util.Date().getTime()));
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            if (uti.numRowdatabase("select count(doc_id) as num from d_job_order_header where doc_id = '" + objdb.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'") != 0) {
                if (objdb.getDoc_type().equals("1")) {
                    if (uti.numRowdatabase("select count(doc_id) as num from d_requisition_product_header_wh "
                            + "where doc_id = '" + objdb.getDoc_id() + "' and approve_flag = 'Y' and status_sending = true") != 0) {
                        objex.Close_Job_Order(objdb);
                        out.print("ทำการอนุมัติสำเร็จ");
                    } else {
                        out.print("ไม่สามารถปิดใบแจ้งการผลิตนี้ได้เนื้องจากยังไม่ได้ทำการส่งออกสินค้า");
                    }
                } else {
                    objex.Close_Job_Order(objdb);
                    out.print("ทำการอนุมัติสำเร็จ");
                }
            } else {
                out.print("ไม่สามารถทำการอนุมัติเอกสารใบนี้ได้เนื่องจากไม่มีในระบบ");
            }
%>