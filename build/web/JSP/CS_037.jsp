
<%@page import="com.cgc.DB.D_product_receive_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_product_receive_detail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_product_receive_detail objdb = new DataBeanD_product_receive_detail();
    D_product_receive_detailDAO objex = new D_product_receive_detailDAO();


%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
            if (request.getParameter("burn_no") != null) {
                objdb.setBurn_no(en.EncodeTexttoTIS(request.getParameter("burn_no")));
            }
            if (request.getParameter("location_id") != null) {
                objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if (request.getParameter("wh_id") != null) {
                objdb.setWh_id(request.getParameter("wh_id"));
            }
            if (request.getParameter("size") != null) {
                objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
            }
            if (request.getParameter("job_edit_no") != null) {
                objdb.setJob_edit_no(en.EncodeTexttoTIS(request.getParameter("job_edit_no")));
            }
            if (request.getParameter("qty") != null) {
                objdb.setQty(en.EncodeTexttoTIS(request.getParameter("qty")));
            }
            if (request.getParameter("ctc_i2") != null) {
                objdb.setCtc_i2(en.EncodeTexttoTIS(request.getParameter("ctc_i2")));
            }
            if (request.getParameter("shift") != null) {
                objdb.setShift(en.EncodeTexttoTIS(request.getParameter("shift")));
            }
            if (request.getParameter("palate_no") != null) {
                objdb.setPalate_no(en.EncodeTexttoTIS(request.getParameter("palate_no")));
            }
            
            //if (request.getParameter("product_id") != null) {
            //    objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));
            //    System.out.println("SC Product ID : " + request.getParameter("product_id"));
            //}
            
            if (request.getParameter("c_type") != null) {
                objdb.setC_type(en.EncodeTexttoTIS(request.getParameter("c_type")));
                System.out.println("SC c_type : " + request.getParameter("c_type"));
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
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            
            objdb.setProcess_order(request.getParameter("process_order"));
            
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