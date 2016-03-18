
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="com.cgc.Util.DateUtil"%>

<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%!    
    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;

%>
<%
        DateUtil objrun = new DateUtil();
        System.out.println(objrun.Return_Date_Now_full()); 
        out.print(objrun.Return_Date_Now_full());
        
%>