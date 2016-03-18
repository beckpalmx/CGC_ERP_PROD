<%@page import="com.cgc.DB.D_carbon_return_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_return_detail"%>
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
    DataBeanD_carbon_return_detail objdb = new DataBeanD_carbon_return_detail();
    D_carbon_return_detailDAO objex = new D_carbon_return_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_return_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_return_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
            if (request.getParameter("prd_no") != null) {
                objdb.setPrd_no(en.EncodeTexttoTIS(request.getParameter("prd_no")));

            }
            if (request.getParameter("size") != null) {
                objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
                //JOptionPane.showConfirmDialog(null, objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if (request.getParameter("c_type") != null) {
                objdb.setC_type(en.EncodeTexttoTIS(request.getParameter("c_type")));
            }
            if (request.getParameter("iod") != null) {
                objdb.setIod(en.EncodeTexttoTIS(request.getParameter("iod")));
            }
            if (request.getParameter("comp_palate") != null) {
                objdb.setComp_palate(en.EncodeTexttoTIS(request.getParameter("comp_palate")));
            }
            if (request.getParameter("late_no") != null) {
                objdb.setLate_no(en.EncodeTexttoTIS(request.getParameter("late_no")));
            }
            if (request.getParameter("machine") != null) {
                objdb.setMachine(en.EncodeTexttoTIS(request.getParameter("machine")));
            }
            if (request.getParameter("size_cont") != null) {
                objdb.setSize_cont(en.EncodeTexttoTIS(request.getParameter("size_cont")));
            }
            if (request.getParameter("bag") != null) {
                objdb.setBag(en.EncodeTexttoTIS(request.getParameter("bag")));
            }
            if (request.getParameter("s_weight") != null) {
                objdb.setS_weight(en.EncodeTexttoTIS(request.getParameter("s_weight")));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(en.EncodeTexttoTIS(request.getParameter("weight")));
            }
            if (request.getParameter("reason_ret") != null) {
                objdb.setReason_ret(en.EncodeTexttoTIS(request.getParameter("reason_ret")));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
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
                    } else {
                        out.print("ไม่สามารถบันทึกได้");
                    }
                    break;
                case 2:
                    //JOptionPane.showConfirmDialog(null,objdb.getLine_no());
                    if (objex.update(objdb) != -1) {
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("ไม่สามารถบันทึกได้");
                    }
                    break;
                case 3:

                    if (request.getParameter("chk_all") != null) {
                        //JOptionPane.showConfirmDialog(null,request.getParameter("chk_all"));
                        objex.Delete_line_no_All(objdb);
                    } else {
                        //JOptionPane.showConfirmDialog(null, request.getParameter("ckbox"));
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>