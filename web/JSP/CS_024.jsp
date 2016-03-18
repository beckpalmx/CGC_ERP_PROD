
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_rawmatt_withdraw_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_rawmatt_withdraw_detail"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_rawmatt_withdraw_detail objdb = new DataBeanD_rawmatt_withdraw_detail();
    D_rawmatt_withdraw_detailDAO objex = new D_rawmatt_withdraw_detailDAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_a") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_withdraw_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 1;
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_withdraw_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
    if (request.getParameter("product_id") != null) {
        objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));

    }
    if (request.getParameter("location_id") != null) {
        objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
        //JOptionPane.showConfirmDialog(null, objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
    }
    if (request.getParameter("wh_in") != null) {
        objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
    }
    if (request.getParameter("car_no") != null) {
        objdb.setCar_no(en.EncodeTexttoTIS(request.getParameter("car_no")));
    }
    if (request.getParameter("runno") != null) {
        objdb.setRunno(request.getParameter("runno"));
    }
    if (request.getParameter("cust_id") != null) {
        objdb.setCust_id(en.EncodeTexttoTIS(request.getParameter("cust_id")));
    }
    if (request.getParameter("quantity") != null) {
        objdb.setQuatity(en.EncodeTexttoTIS(request.getParameter("quantity")));

    }
    if (request.getParameter("weight") != null) {
        objdb.setWeight(request.getParameter("weight"));

    }
    if (request.getParameter("remark") != null) {
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }
    if (request.getParameter("supplier_id") != null) {
        objdb.setSupplier_id(en.EncodeTexttoTIS(request.getParameter("supplier_id")));
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