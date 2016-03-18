
<%@page import="com.cgc.DB.D_requisition_product_header_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_requisition_product_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_requisition_product_header objdb = new DataBeanD_requisition_product_header();
    D_requisition_product_header_whDAO objex = new D_requisition_product_header_whDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null ) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_requisition_product_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                     if (uti.numRowdatabase("Select Count(doc_id) As num from  d_requisition_product_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                    } else {
                    statusck = 1;
                    }
                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            }
             else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            objdb.setScreen_id(request.getParameter("screen_id"));
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
            objdb.setDoc_date(request.getParameter("doc_date"));
            objdb.setJob_id(en.EncodeTexttoTIS(request.getParameter("job_id")));
            objdb.setItem_id(en.EncodeTexttoTIS(request.getParameter("item_id")));
            objdb.setPo_no(en.EncodeTexttoTIS(request.getParameter("po_no_desc")));
            objdb.setWh_in(request.getParameter("wh_in"));
            objdb.setWh_out(request.getParameter("wh_out"));
            objdb.setContain_no(en.EncodeTexttoTIS(request.getParameter("contain_no")));
            objdb.setContain_type(request.getParameter("contain_type"));
            objdb.setPalate_type(request.getParameter("palate_type"));
            objdb.setSeal_no(en.EncodeTexttoTIS(request.getParameter("seal_no")));
            objdb.setApprover(en.EncodeTexttoTIS(request.getParameter("approver")));
            objdb.setPayment_prod(en.EncodeTexttoTIS(request.getParameter("payment_prod")));
            objdb.setReceiver(en.EncodeTexttoTIS(request.getParameter("receiver")));
            objdb.setCar_no(en.EncodeTexttoTIS(request.getParameter("car_no")));
            objdb.setNet_weight(request.getParameter("net_weight"));
            objdb.setCust_id(request.getParameter("cust_id"));
            objdb.setComplete_flag(request.getParameter("return_complete_flag"));
            objdb.setDoc_type(request.getParameter("document_confirm_flag"));
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
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("แก้ไขสำเร็จ");
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>