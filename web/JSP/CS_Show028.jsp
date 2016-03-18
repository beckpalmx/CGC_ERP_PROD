
<%@page import="com.cgc.DB.D_carbon_burn_in_detailDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_burn_in_detailDAO objdetail = new D_carbon_burn_in_detailDAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>


