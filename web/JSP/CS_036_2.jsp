
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_product_receive_header_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_product_receive_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_product_receive_header objdb = new DataBeanD_product_receive_header();
    D_product_receive_header_whDAO objex = new D_product_receive_header_whDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_header_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                        statusck = -1;
                    } else {
                        statusck = 1;
                    }
                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            } else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            objdb.setDoc_date(request.getParameter("doc_date"));
            objdb.setWh_in(request.getParameter("wh_in"));
            objdb.setWh_out(request.getParameter("wh_out"));
            /*objdb.setJob_id(request.getParameter("job_id"));
            objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));
            objdb.setCtc_i2(request.getParameter("ctc_i2"));
            objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
            objdb.setInc_bal(request.getParameter("inc_bal"));
            objdb.setPalate_no(request.getParameter("palate_no"));*/
            //******************************CHECK**************************************
            /*objdb.setMashed_machine_chk(request.getParameter("mashed_machine_chk"));
            objdb.setPan_chk(request.getParameter("pan_chk"));
            objdb.setBall_mill_chk(request.getParameter("ball_mill_chk"));
            objdb.setPill_flat_chk(request.getParameter("pill_flat_chk"));
            objdb.setMag_chk(request.getParameter("mag_chk"));
            objdb.setJob_edit_chk(request.getParameter("job_edit_chk"));
            objdb.setWash_chk(request.getParameter("wash_chk"));
            objdb.setRoast_chk(request.getParameter("wash_chk"));
            objdb.setRoast_edit_chk(request.getParameter("roast_edit_chk"));*/
            //*******************************VALUE*************************************
            /*objdb.setMashed_machine(en.EncodeTexttoTIS(request.getParameter("mashed_machine")));
            objdb.setPan(en.EncodeTexttoTIS(request.getParameter("pan")));
            objdb.setBall_mill(en.EncodeTexttoTIS(request.getParameter("ball_mill")));
            objdb.setPill_flat(en.EncodeTexttoTIS(request.getParameter("pill_flat")));
            objdb.setMag(en.EncodeTexttoTIS(request.getParameter("mag")));
            objdb.setJob_edit(en.EncodeTexttoTIS(request.getParameter("job_edit")));
            objdb.setWash(en.EncodeTexttoTIS(request.getParameter("wash")));
            objdb.setRoast(en.EncodeTexttoTIS(request.getParameter("roast")));
            objdb.setRost_edit(en.EncodeTexttoTIS(request.getParameter("roast_edit")));*/

            //*************************************************************************
            objdb.setReturn_document_flag(request.getParameter("return_document"));
            objdb.setConfirm_document_flag(request.getParameter("confirm_document"));
            /*objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));*/
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:

                    break;
                case 2:
                    objex.update(objdb);
                    out.print("แก้ไขสำเร็จ");
                    break;
                case 3:
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail_prod where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                        out.print("ไม่สามารถทำการลบได้เนื่องจากมีรายการที่ทำการอนุมัติไปแล้ว");
                    } else {
                        objex.UpDel(objdb);
                        out.print("ลบข้อมูลสำเร็จ");
                    }

                    break;
                default:
                    out.print("No Statment");
                    break;
            }
%>