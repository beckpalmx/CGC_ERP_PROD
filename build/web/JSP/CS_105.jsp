
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="com.cgc.DB.D_carbon_analyze_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_analyze_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_analyze_header objdb = new DataBeanD_carbon_analyze_header();
    D_carbon_analyze_headerDAO objex = new D_carbon_analyze_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

    int statusck = 0;
    int statusnum = 0;
    
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_analyze_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            statusck = 1;
        } else if (statusnum == 1) {
            statusck = 2;
        } else {
            statusck = -1;
        }
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
    }
    objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id")));
    objdb.setDoc_date(request.getParameter("doc_date"));
    objdb.setShift(request.getParameter("shift"));
    objdb.setReporter_id(request.getParameter("reporter_id"));
    objdb.setChecker_id(request.getParameter("checker_id"));
    //objdb.setApprove_status(request.getParameter("approve_status"));
    objdb.setApprove_status((request.getParameter("approve_status")).trim().equals("")?"N":en.EncodeTexttoTIS(request.getParameter("approve_status")).trim());     
    
    //System.out.println("-----------------approve_status-----------------");
    //System.out.println(request.getParameter("approve_status"));
    //System.out.println("-----------------approve_status-----------------");    
    
    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setDate(ts);
    if (request.getParameter("doc_time") != null) {
        objdb.setDoc_time(en.EncodeTexttoTIS(request.getParameter("doc_time")));
    }
    if (request.getParameter("remark") != null) {
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }
    if (request.getParameter("hc1") != null) {
        objdb.setHc1(en.EncodeTexttoTIS(request.getParameter("hc1")));
    }
    if (request.getParameter("hc2") != null) {
        objdb.setHc2(en.EncodeTexttoTIS(request.getParameter("hc2")));
    }
    if (request.getParameter("hc3") != null) {
        objdb.setHc3(en.EncodeTexttoTIS(request.getParameter("hc3")));
    }
    if (request.getParameter("hc4") != null) {
        objdb.setHc4(en.EncodeTexttoTIS(request.getParameter("hc4")));
    }
    if (request.getParameter("hc5") != null) {
        objdb.setHc5(en.EncodeTexttoTIS(request.getParameter("hc5")));
    }
    if (request.getParameter("hc6") != null) {
        objdb.setHc6(en.EncodeTexttoTIS(request.getParameter("hc6")));
    }
    if (request.getParameter("hc7") != null) {
        objdb.setHc7(en.EncodeTexttoTIS(request.getParameter("hc7")));
    }
    if (request.getParameter("hc8") != null) {
        objdb.setHc8(en.EncodeTexttoTIS(request.getParameter("hc8")));
    }
    if (request.getParameter("hc9") != null) {
        objdb.setHc9(en.EncodeTexttoTIS(request.getParameter("hc9")));
    }
    if (request.getParameter("hc10") != null) {
        objdb.setHc10(en.EncodeTexttoTIS(request.getParameter("hc10")));
    }
    if (request.getParameter("hc11") != null) {
        objdb.setHc11(en.EncodeTexttoTIS(request.getParameter("hc11")));
    }
    if (request.getParameter("hc12") != null) {
        objdb.setHc12(en.EncodeTexttoTIS(request.getParameter("hc12")));
    }
    if (request.getParameter("hc13") != null) {
        objdb.setHc13(en.EncodeTexttoTIS(request.getParameter("hc13")));
    }
    if (request.getParameter("hc14") != null) {
        objdb.setHc14(en.EncodeTexttoTIS(request.getParameter("hc14")));
    }
    if (request.getParameter("hc15") != null) {
        objdb.setHc15(en.EncodeTexttoTIS(request.getParameter("hc15")));
    }
    objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    switch (statusck) {
        case 1:
            //objdb.setDoc_id(new Runer_Doc_id().Run_id_date("D_carbon_analyze_header", objdb.getDoc_date()));
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
            objex.UpDel(objdb);

            out.print("ลบข้อมูลสำเร็จ");

            break;
        default:
            out.print("No Statment");
    }
%>