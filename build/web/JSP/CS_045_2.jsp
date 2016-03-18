<%@page import="com.cgc.DB.D_product_receive_detail_prod_whDAO"%>
<%@page import="com.cgc.bean.DataBeanD_product_receive_detail_prod"%>
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
    DataBeanD_product_receive_detail_prod objdb = new DataBeanD_product_receive_detail_prod();
    D_product_receive_detail_prod_whDAO objex = new D_product_receive_detail_prod_whDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail_prod_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail_prod_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("wh_out") != null) {
                objdb.setWh_out(en.EncodeTexttoTIS(request.getParameter("wh_out")));
            }
            if (request.getParameter("doc_date") != null) {
                objdb.setDoc_date(en.EncodeTexttoTIS(request.getParameter("doc_date")));
            }
            if (request.getParameter("line_no") != null) {
                objdb.setLine_no(en.EncodeTexttoTIS(request.getParameter("line_no")));
            }
            if (request.getParameter("machine") != null) {
                objdb.setMachine(en.EncodeTexttoTIS(request.getParameter("machine")));
            }
            if (request.getParameter("shift") != null) {
                objdb.setShift(en.EncodeTexttoTIS(request.getParameter("shift")));
            }
            if (request.getParameter("size") != null) {
                objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(en.EncodeTexttoTIS(request.getParameter("weight")));
            }
            if (request.getParameter("complete_code") != null) {
                objdb.setPalate_complete_code(en.EncodeTexttoTIS(request.getParameter("complete_code")));
            }
            if (request.getParameter("palate_no") != null) {
                objdb.setPalate_no(en.EncodeTexttoTIS(request.getParameter("palate_no")));
            }
            if (request.getParameter("palate_complete") != null) {
                objdb.setPalate_complete(en.EncodeTexttoTIS(request.getParameter("palate_complete")));
            }
            if (request.getParameter("ctc_i2") != null) {
                objdb.setCtc_i2(en.EncodeTexttoTIS(request.getParameter("ctc_i2")));
            }
            if (request.getParameter("bag") != null) {
                objdb.setBag(en.EncodeTexttoTIS(request.getParameter("bag")));
            }
            if (request.getParameter("emp_id") != null) {
                objdb.setEmp_id(en.EncodeTexttoTIS(request.getParameter("emp_id")));
            }
            if (request.getParameter("palate_chk") != null) {
                objdb.setPalate_chk(en.EncodeTexttoTIS(request.getParameter("palate_chk")));
            }
            if (request.getParameter("unit_id") != null) {
                objdb.setUnit_id(request.getParameter("unit_id"));
            }
            if (request.getParameter("job_type_id") != null) {
                objdb.setJob_type_id(request.getParameter("job_type_id"));
            }
            if (request.getParameter("job_type_desc") != null) {
                objdb.setJob_type_desc(en.EncodeTexttoTIS(request.getParameter("job_type_desc")));
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
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail_prod_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 0) {
                        if (objex.update(objdb) != -1) {
                            out.print("แก้ไขสำเร็จ");
                        }
                    } else {
                        out.print("ไม่สามารถแก้ไขได้เนื่องจากมีรายการที่อนุมัติไปแล้ว");
                    }
                    break;
                case 3:
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail_prod_wh where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 0) {

                        if (request.getParameter("chk_all") != null) {
                            objex.Delete_line_no_All(objdb);
                        } else {
                            objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                        }
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>