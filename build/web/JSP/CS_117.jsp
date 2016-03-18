<%@page import="com.cgc.DB.D_adjust_rawmat_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_adjust_product_header"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    DataBeanD_adjust_product_header objdb = new DataBeanD_adjust_product_header();
    D_adjust_rawmat_headerDAO objex = new D_adjust_rawmat_headerDAO();
    Timestamp ts;
    String runer_id;

%>
<%
            int statusck = 0;
            int statusnum = 0;
            runer_id = request.getParameter("runer_id");
            if (request.getParameter("status_d") == null && request.getParameter("runer_id") == null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_adjust_rawmat_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_adjust_rawmat_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                        statusck = -1;
                    } else {
                        statusck = 1;
                    }
                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            } else if (request.getParameter("runer_id") != null) {
                statusck = 4;
                System.out.println("runer_id" + runer_id);                
            } else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            if(request.getParameter("doc_id") != null){
            //objdb.setDoc_id(request.getParameter("doc_id").trim());
            objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
            }            
            if(request.getParameter("doc_date") != null){
            objdb.setDoc_date(request.getParameter("doc_date"));
            }
            if(request.getParameter("doc_time") != null){
            objdb.setDoc_time(request.getParameter("doc_time"));
            }
            if(request.getParameter("doc_type") != null){
            objdb.setDoc_type(request.getParameter("doc_type"));
            }
            if(request.getParameter("remark") != null){
            objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            if(request.getParameter("username") != null){
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            }
            
            if(request.getParameter("complete_flag") != null){
            objdb.setComplete_flag(en.EncodeTexttoTIS(request.getParameter("complete_flag")));
            }
            

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
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        objex.update(objdb);
                        out.print("แก้ไขสำเร็จ");
                    }else{
                        out.print("edit");
                    }
                    break;
                case 3:
                    objex.UpDel(objdb);
                    out.print("ลบข้อมูลสำเร็จ");
                    break;
                case 4:
                    Runer_Doc_id objrun = new Runer_Doc_id();
                    out.print(objrun.Run_Next_id(runer_id,"d_adjust_rawmat_header", "d_adjust_rawmat_detail"));
                    break;
                default:
                    out.print("No Statment");
            }
%>