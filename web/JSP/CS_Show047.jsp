<%@page import="com.cgc.DB.D_rawmatt_analyze_detailDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<% 
    D_rawmatt_analyze_detailDAO objdetail = new D_rawmatt_analyze_detailDAO();
    System.out.println("doc_id = " + request.getParameter("doc_id"));
%>
<%=objdetail.showDatail(request.getParameter("doc_id"))%>


