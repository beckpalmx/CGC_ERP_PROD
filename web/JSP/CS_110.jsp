
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_analyze_packing_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_analyze_packing_detail"%>
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
    DataBeanD_analyze_packing_detail objdb = new DataBeanD_analyze_packing_detail();
    D_analyze_packing_detailDAO objex = new D_analyze_packing_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_analyze_packing_detail  where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                statusck = 1;
                objdb.setLine_no(Integer.toString(statusnum + 1));

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
            if (request.getParameter("bag") != null) {
                objdb.setBag(en.EncodeTexttoTIS(request.getParameter("bag")));

            }
            if (request.getParameter("prd_place") != null) {
                objdb.setPrd_place(en.EncodeTexttoTIS(request.getParameter("prd_place")));
            }
            if (request.getParameter("lat") != null) {
                objdb.setLat(en.EncodeTexttoTIS(request.getParameter("lat")));
            }
            if (request.getParameter("prd_code") != null) {
                objdb.setPrd_code(en.EncodeTexttoTIS(request.getParameter("prd_code")));
            }
            if (request.getParameter("h2o") != null) {
                objdb.setH2o(en.EncodeTexttoTIS(request.getParameter("h2o")));
            }
            if (request.getParameter("ba") != null) {
                objdb.setBa(en.EncodeTexttoTIS(request.getParameter("ba")));
            }
            if (request.getParameter("iod") != null) {
                objdb.setIod(en.EncodeTexttoTIS(request.getParameter("iod")));
            }
            if (request.getParameter("hd1") != null) {
                objdb.setHc1(en.EncodeTexttoTIS(request.getParameter("hd1")));
            }
            if (request.getParameter("hd2") != null) {
                objdb.setHc2(en.EncodeTexttoTIS(request.getParameter("hd2")));
            }
            if (request.getParameter("hd3") != null) {
                objdb.setHc3(en.EncodeTexttoTIS(request.getParameter("hd3")));
            }
            if (request.getParameter("hd4") != null) {
                objdb.setHc4(en.EncodeTexttoTIS(request.getParameter("hd4")));
            }
            if (request.getParameter("hd5") != null) {
                objdb.setHc5(en.EncodeTexttoTIS(request.getParameter("hd5")));
            }
            if (request.getParameter("hd6") != null) {
                objdb.setHc6(en.EncodeTexttoTIS(request.getParameter("hd6")));
            }
            if (request.getParameter("hd7") != null) {
                objdb.setHc7(en.EncodeTexttoTIS(request.getParameter("hd7")));
            }
            if (request.getParameter("hd8") != null) {
                objdb.setHc8(en.EncodeTexttoTIS(request.getParameter("hd8")));
            }
            if (request.getParameter("hd9") != null) {
                objdb.setHc9(en.EncodeTexttoTIS(request.getParameter("hd9")));
            }
            if (request.getParameter("hd10") != null) {
                objdb.setHc10(en.EncodeTexttoTIS(request.getParameter("hd10")));
            }
            if (request.getParameter("hd11") != null) {
                objdb.setHc11(en.EncodeTexttoTIS(request.getParameter("hd11")));
            }
            if (request.getParameter("hd12") != null) {
                objdb.setHc12(en.EncodeTexttoTIS(request.getParameter("hd12")));
            }
            if (request.getParameter("hd13") != null) {
                objdb.setHc13(en.EncodeTexttoTIS(request.getParameter("hd13")));
            }
            if (request.getParameter("hd14") != null) {
                objdb.setHc14(en.EncodeTexttoTIS(request.getParameter("hd14")));
            }
            if (request.getParameter("hd15") != null) {
                objdb.setHc15(en.EncodeTexttoTIS(request.getParameter("hd15")));
            }
            if (request.getParameter("valuepass") != null) {
                objdb.setStatus1(en.EncodeTexttoTIS(request.getParameter("valuepass")));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            switch (statusck) {
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("ไม่สามารถบันทึกได้");
                    }
                    break;
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("ไม่สามารถบันทึกได้");
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