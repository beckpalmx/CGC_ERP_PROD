
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_rawmatt_analyze_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_rawmatt_analyze_detail"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_rawmatt_analyze_detail objdb = new DataBeanD_rawmatt_analyze_detail();
    D_rawmatt_analyze_detailDAO objex = new D_rawmatt_analyze_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_analyze_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_analyze_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
            if(request.getParameter("moisture_percent") != null)
            objdb.setMoisture_percent(en.EncodeTexttoTIS(request.getParameter("moisture_percent")));
            if (request.getParameter("ashes_percent") != null) {
                objdb.setAshes_percent(en.EncodeTexttoTIS(request.getParameter("ashes_percent")));
                //JOptionPane.showConfirmDialog(null, objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if(request.getParameter("dust_percent") != null)
            objdb.setDust_percent(en.EncodeTexttoTIS(request.getParameter("dust_percent")));
            if(request.getParameter("volatile_percent") != null)
            objdb.setVolatile_percent(en.EncodeTexttoTIS(request.getParameter("volatile_percent")));
            if(request.getParameter("mixed_percent") != null)
            objdb.setMixed_percent(en.EncodeTexttoTIS(request.getParameter("mixed_percent")));
            if(request.getParameter("weight") != null)
            objdb.setWeight(request.getParameter("weight"));
            if(request.getParameter("doc_date") != null)
            objdb.setDoc_date(request.getParameter("doc_date"));
            
            System.out.println("Remark : Deail Save = " + en.EncodeTexttoTIS(request.getParameter("remark").trim()));
                     
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark").trim()));
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
                    }
                    else {
                        //JOptionPane.showConfirmDialog(null, request.getParameter("ckbox"));
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>
