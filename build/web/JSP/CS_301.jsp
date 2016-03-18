
<%@page import="com.cgc.DB.D_carbon_burn_out_detail_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_out_detail"%>
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
    DataBeanD_carbon_burn_out_detail objdb = new DataBeanD_carbon_burn_out_detail();
    D_carbon_burn_out_detail_whDAO objex = new D_carbon_burn_out_detail_whDAO();


%>
<%

            String total = "";
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_detail_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_detail_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y'");
                    statusck = 1;
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
                objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
            }
            if (request.getParameter("production_no") != null) {
                objdb.setProduction_no(en.EncodeTexttoTIS(request.getParameter("production_no")));
            }
            if (request.getParameter("size") != null) {
                objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
            }
            if (request.getParameter("g_code") != null) {
                objdb.setG_code(en.EncodeTexttoTIS(request.getParameter("g_code")));
            }
            if (request.getParameter("g_sum") != null) {
                objdb.setG_sum(en.EncodeTexttoTIS(request.getParameter("g_sum")));
            }
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("wh_out") != null) {
                objdb.setWh_out(en.EncodeTexttoTIS(request.getParameter("wh_out")));
            }
            if (request.getParameter("ctc_i2") != null) {
                objdb.setCtc_i2(request.getParameter("ctc_i2"));
            }
            if (request.getParameter("bag") != null) {
                objdb.setBag(request.getParameter("bag"));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(request.getParameter("weight"));
            }
            if (request.getParameter("lost") != null) {
                objdb.setLost(request.getParameter("lost"));
            }
            if (request.getParameter("doc_date") != null) {
                objdb.setDoc_date(request.getParameter("doc_date"));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            if (request.getParameter("bag_no") != null) {
                objdb.setBag_no(request.getParameter("bag_no"));
            }
            if (request.getParameter("wh_id") != null) {
                objdb.setWh_id(request.getParameter("wh_id"));
                objdb.setWh_warehouse_id(request.getParameter("wh_id"));
            }
            if (request.getParameter("location_id") != null) {
                objdb.setLocation_id(request.getParameter("location_id"));
                objdb.setWh_location_id(request.getParameter("location_id"));
            }            
            if (request.getParameter("product_id") != null) {
                objdb.setProduct_id(request.getParameter("product_id"));
                objdb.setWh_product_id(request.getParameter("product_id"));
            }
            if (request.getParameter("wh_weight") != null) {
                objdb.setWh_weight(request.getParameter("wh_weight"));
                objdb.setWh_weight_final(request.getParameter("wh_weight"));
            }            
            if (request.getParameter("weight_diff") != null) {
                objdb.setWeight_diff(request.getParameter("weight_diff"));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            switch (statusck) {
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
                        objex.Delete_line_no_All(objdb);
                    } else {
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>