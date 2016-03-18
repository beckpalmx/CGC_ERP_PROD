<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.DB.D_packing_product_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_packing_product_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_packing_product_header objdb = new DataBeanD_packing_product_header();
    D_packing_product_headerDAO objex = new D_packing_product_headerDAO();
    DataBean_Display_Document_Status obj_record = new DataBean_Display_Document_Status();
    Display_Document_Status r_c = new Display_Document_Status();

    Runer_Doc_id objrun = new Runer_Doc_id();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    String runer_id, doc_id_last;
%>
<%

    int statusck = 0;
    int statusnum = 0;
    runer_id = request.getParameter("runer_id");
    //System.out.print("First runer_id = " + runer_id);
    if (runer_id != null) {
        if (runer_id.equals("1")) {
            statusck = 5;
            obj_record = r_c.Fn_Doc_ID_Last(obj_record, "select doc_id as doc_id_last from d_job_order_header where delete_flag = 'N' order by runno desc limit 1 ");
        } 
    } 
    switch (statusck) {
        case 5:
            out.print(obj_record.getDoc_id_last());
            //System.out.println("doc_id_last = " + obj_record.getDoc_id_last());
            break;
        default:
            out.print("No Statment");
    }
%>