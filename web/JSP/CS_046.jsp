
<%@page import="com.cgc.DB.D_rawmatt_analyze_headerDAO"%>
<%@page import="com.cgc.DB.D_rawmatt_analyze_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_rawmatt_analyze_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_rawmatt_analyze_header objdb = new DataBeanD_rawmatt_analyze_header();
    D_rawmatt_analyze_headerDAO objex = new D_rawmatt_analyze_headerDAO();
    D_rawmatt_analyze_detailDAO objdetail = new D_rawmatt_analyze_detailDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%

    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null && request.getParameter("status_cal") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_analyze_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_analyze_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                statusck = -1;
            } else {
                statusck = 1;
            }
        } else if (statusnum == 1) {
            statusck = 2;
        } else {
            statusck = -1;
        }
    } else {
        if (request.getParameter("status_cal") == null) {
            statusck = Integer.parseInt(request.getParameter("status_d"));
            System.out.println("Loop 2 statusck = " + statusck);
        } else {
            statusck = 4;
            System.out.println("Loop 3 statusck = " + statusck + " status_cal = " + request.getParameter("status_cal"));
        }
    }    

    if (request.getParameter("status_cal") == null||request.getParameter("status_cal").equals("")) {
        objdb.setDoc_id(request.getParameter("doc_id").trim());
        objdb.setDoc_date(request.getParameter("doc_date"));
        objdb.setCar_no(en.EncodeTexttoTIS(request.getParameter("car_no")));
        objdb.setC_type(en.EncodeTexttoTIS(request.getParameter("c_type")));
        objdb.setSender_id(en.EncodeTexttoTIS(request.getParameter("sender_id")));
        objdb.setReport_name(en.EncodeTexttoTIS(request.getParameter("report_id")));
        objdb.setApprove_name(en.EncodeTexttoTIS(request.getParameter("approve_id")));
        //objdb.setApprove_status(en.EncodeTexttoTIS(request.getParameter("approve_status")));
        objdb.setApprove_status(request.getParameter("approve_status") == null || (request.getParameter("approve_status")).trim().equals("") ? "N" : en.EncodeTexttoTIS(request.getParameter("approve_status")).trim());
        System.out.println("Save approve status = " + request.getParameter("approve_status"));
        //System.out.println("#############################");
        //System.out.println("++++++++++++ QC2 ++++++++++++");
        //System.out.println(request.getParameter("approve_status"));
        //System.out.println("++++++++++++ QC2 ++++++++++++");

        objdb.setCar_date_in(request.getParameter("car_date_in"));
        objdb.setMoisture_average(request.getParameter("moisture_average"));
        ts = new Timestamp(new java.util.Date().getTime());
        objdb.setDate(ts);
        objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
        if (request.getParameter("remark") != null) {
            objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            System.out.println("Remark Encode : " + en.EncodeTexttoTIS(request.getParameter("remark")));
        }
    } else {
        System.out.println("BBB");
    }

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
            System.out.println("xxx");
            System.out.println("xxx status_runid = " + request.getParameter("status_cal"));
            out.print(objdetail.Moisture_Avg(request.getParameter("status_cal")));
            System.out.println("yyy");
            break;
        default:
            out.print("No Statment");
    }
%>