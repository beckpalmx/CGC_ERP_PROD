
<%@page import="com.cgc.DB.D_packing_product_detail_prodDAO"%>
<%@page import="com.cgc.bean.DataBeanD_packing_product_detail_prod"%>
<%@page import="javax.swing.JOptionPane"%>
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
    DataBeanD_packing_product_detail_prod objdb = new DataBeanD_packing_product_detail_prod();
    D_packing_product_detail_prodDAO objex = new D_packing_product_detail_prodDAO();


%>
<%

    String total = "";
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_a") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_packing_product_detail_prod where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 1;
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_packing_product_detail_prod where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
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
    if (request.getParameter("wh_id") != null) {
        objdb.setWh_id(en.EncodeTexttoTIS(request.getParameter("wh_id")));
    }
    if (request.getParameter("product_id") != null) {
        objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));
    }
    if (request.getParameter("size") != null) {
        objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
    }
    if (request.getParameter("i2") != null) {
        objdb.setI2(en.EncodeTexttoTIS(request.getParameter("i2")));
    }
    if (request.getParameter("bag") != null) {
        objdb.setBag(request.getParameter("bag"));
    }
    if (request.getParameter("weight") != null) {
        objdb.setWeight(request.getParameter("weight"));
    }
    if (request.getParameter("remark") != null) {
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }
    if (request.getParameter("weight_unit") != null) {
        objdb.setWeight_unit(request.getParameter("weight_unit"));
    }
    if (request.getParameter("product_no") != null) {
        objdb.setProduct_no(request.getParameter("product_no"));
    }

    if (request.getParameter("pack_repacking_status") != null && request.getParameter("pack_repacking_status").equals("Y")) {
        objdb.setPack_repacking_status("Y");
        System.out.println("pack_repacking_status = 1");
    } else {
        objdb.setPack_repacking_status("N");
        System.out.println("pack_repacking_status = 2");
    }

    if (request.getParameter("carbon_trap_status") != null && request.getParameter("carbon_trap_status").equals("Y")) {
        objdb.setCarbon_trap_status("Y");
        System.out.println("carbon_trap_status = 1");
    } else {
        objdb.setCarbon_trap_status("N");
        System.out.println("carbon_trap_status = 2");
    }

    if (request.getParameter("doc_type") != null) {
        objdb.setDoc_type(request.getParameter("doc_type"));
    }
    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    objdb.setDate(ts);

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
                total = objex.Delete_line_no_All(objdb);
                out.print(total);
            } else {

                total = objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                out.print(total);
            }
            break;
        default:
            out.print("No Statment");
    }
%>