
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_requisition_product_detail_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_requisition_product_detail"%>
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
    DataBeanD_requisition_product_detail objdb = new DataBeanD_requisition_product_detail();
    D_requisition_product_detail_whDAO objex = new D_requisition_product_detail_whDAO();


%>
<%

            int total = 0;
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_requisition_product_detail_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_requisition_product_detail_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                    objdb.setLine_no(Integer.toString(statusnum + 1));
                }
            } else if (request.getParameter("status_u") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_requisition_product_detail_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 2;
                    objdb.setLine_no(request.getParameter("line_no"));
                }
            } else if (request.getParameter("status_d") != null) {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            } else {
                statusck = -1;
            }
            if (request.getParameter("doc_id") != null) {
                objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
            }
            if (request.getParameter("product_id") != null) {
                objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(en.EncodeTexttoTIS(request.getParameter("weight")));
            }
            if (request.getParameter("bag") != null) {
                objdb.setBag(en.EncodeTexttoTIS(request.getParameter("bag")));
            }
            if (request.getParameter("lot_no") != null) {
                objdb.setLot_no(en.EncodeTexttoTIS(request.getParameter("lot_no")));
            }
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("wh_out") != null) {
                objdb.setWh_out(en.EncodeTexttoTIS(request.getParameter("wh_out")));
            }
            if (request.getParameter("doc_date") != null) {
                objdb.setDoc_date(request.getParameter("doc_date"));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            if (request.getParameter("quantity") != null) {
                objdb.setQuantity(en.EncodeTexttoTIS(request.getParameter("quantity")));
            }
            if (request.getParameter("job_id") != null) {
                objdb.setJob_id(en.EncodeTexttoTIS(request.getParameter("job_id")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));

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
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_requisition_product_detail_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 0) {
                        if (request.getParameter("chk_all") != null) {
                            total = objex.Delete_line_no_All(objdb);
                            out.print(total);
                        } else {

                            total = objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                            out.print(total);
                        }
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>