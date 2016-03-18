
<%@page import="com.cgc.DB.D_packing_req_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_packing_req_detail"%>
<%@page import="javax.swing.JOptionPane"%>
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
    DataBeanD_packing_req_detail objdb = new DataBeanD_packing_req_detail();
    D_packing_req_detailDAO objex = new D_packing_req_detailDAO();


%>
<%

            String total = "";
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_packing_req_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_packing_req_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                    objdb.setLine_no(Integer.toString(statusnum + 1));
                }
            }
             else if (request.getParameter("status_u") != null) {
                statusck = 2;
                objdb.setLine_no(request.getParameter("line_no"));

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
            if (request.getParameter("place_prd") != null) {
                objdb.setPlace_prd(en.EncodeTexttoTIS(request.getParameter("place_prd")));
            }
            if (request.getParameter("palate_no") != null) {
                objdb.setPalate_no(en.EncodeTexttoTIS(request.getParameter("palate_no")));
            }
            if (request.getParameter("qty_use") != null) {
                objdb.setQty_use(en.EncodeTexttoTIS(request.getParameter("qty_use")));
            }
            if (request.getParameter("qty_balance") != null) {
                objdb.setQty_balance(en.EncodeTexttoTIS(request.getParameter("qty_balance")));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            if (request.getParameter("doc_date") != null) {
                objdb.setDoc_date(request.getParameter("doc_date"));
            }
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("wh_out") != null) {
                objdb.setWh_out(en.EncodeTexttoTIS(request.getParameter("wh_out")));
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

                    if (request.getParameter("chk_all") != null) {
                        //JOptionPane.showConfirmDialog(null,request.getParameter("chk_all"));
                        objex.Delete_line_no_All(objdb);
                    } else {

                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                        //out.print(total);
                        //JOptionPane.showConfirmDialog(null, total);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>