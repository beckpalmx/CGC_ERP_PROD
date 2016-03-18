
<%@page import="com.cgc.DB.D_rawmatt_bigbag_withdraw_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_rawmatt_bigbag_withdraw_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_rawmatt_bigbag_withdraw_header objdb = new DataBeanD_rawmatt_bigbag_withdraw_header();
    D_rawmatt_bigbag_withdraw_headerDAO objex = new D_rawmatt_bigbag_withdraw_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    String runer_id;
%>
<%

    int statusck = 0;
    int statusnum = 0;
    runer_id = request.getParameter("runer_id");
    if (request.getParameter("status_d") == null && request.getParameter("runer_id") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_bigbag_withdraw_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_bigbag_withdraw_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
        System.out.println("JSP runer_id = " + runer_id);
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
    }

    System.out.println("XXX JSP runer_id = " + runer_id);

    if (statusck != 4) {
        objdb.setDoc_id(request.getParameter("doc_id").trim());
        objdb.setDoc_date(request.getParameter("doc_date"));
        objdb.setDoc_time(request.getParameter("doc_time"));
        objdb.setRunner_id(request.getParameter("runner_id"));
        objdb.setRawmat_emp(request.getParameter("rawmat_emp"));
        objdb.setP_type(request.getParameter("p_type"));
        objdb.setWh_in(request.getParameter("wh_in"));
        objdb.setWh_out(request.getParameter("wh_out"));
        objdb.setComplete_flag(request.getParameter("complete_flag"));
        ts = new Timestamp(new java.util.Date().getTime());
        objdb.setDate(ts);

        System.out.println("YYY JSP runer_id = " + runer_id);

        if (request.getParameter("username") != null) {
            objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("username")));
        }

        if (request.getParameter("remark") != null) {
            objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
        }

    }

    System.out.println("YYY JSP runer_id = " + runer_id);

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
            } else {
                out.print("edit");
            }
            break;
        case 3:
            objex.UpDel(objdb);

            out.print("ลบข้อมูลสำเร็จ");

            break;
        case 4:
            Runer_Doc_id objrun = new Runer_Doc_id();
            System.out.println("Send = " + runer_id);
            out.print(objrun.Run_Next_id(runer_id, "d_rawmatt_bigbag_withdraw_header", "d_rawmatt_bigbag_withdraw_detail"));
            break;
        default:
            out.print("No Statment");
    }
%>