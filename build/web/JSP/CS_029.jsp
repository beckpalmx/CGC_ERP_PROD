
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_carbon_burn_out_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_out_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_burn_out_header objdb = new DataBeanD_carbon_burn_out_header();
    D_carbon_burn_out_headerDAO objex = new D_carbon_burn_out_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
            objdb.setWork_date(request.getParameter("work_date"));
            objdb.setTime_from(request.getParameter("time_from"));
            objdb.setTime_to(request.getParameter("time_to"));
            objdb.setRunner_id(request.getParameter("runner_id"));
            objdb.setBurn_no(request.getParameter("burn_no"));
            objdb.setShift(request.getParameter("shift"));
            objdb.setProduct_id(request.getParameter("product_id"));
            objdb.setCh_from(request.getParameter("ch_from"));
            objdb.setCh_to(request.getParameter("ch_to"));
            objdb.setWeight_split(request.getParameter("weight_split"));
            objdb.setBurn_out_date(request.getParameter("burn_out_date"));
            objdb.setLost_weight(request.getParameter("lost_weight"));
            objdb.setTotal_weight(request.getParameter("total_weight"));
            objdb.setComplete_flag(request.getParameter("complete_flag"));
            //JOptionPane.showConfirmDialog(null, objdb.getComplete_flag());
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            if (request.getParameter("report_id") != null) {
                objdb.setReport_id(en.EncodeTexttoTIS(request.getParameter("report_id")));
            }

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
                default:
                    out.print("No Statment");
            }
%>