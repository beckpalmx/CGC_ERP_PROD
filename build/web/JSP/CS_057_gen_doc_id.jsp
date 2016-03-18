<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="com.cgc.DB.D_rawmatt_bigbag_withdraw_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_rawmatt_bigbag_withdraw_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_rawmatt_bigbag_withdraw_header objdb = new DataBeanD_rawmatt_bigbag_withdraw_header();
    D_rawmatt_bigbag_withdraw_headerDAO objex = new D_rawmatt_bigbag_withdraw_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%                  
        System.out.println("doc_date = " + request.getParameter("doc_date"));
        //out.print(new Runer_Doc_id().Run_id_date("D_rawmatt_bigbag_withdraw_headerDAO",request.getParameter("doc_date")));


%>