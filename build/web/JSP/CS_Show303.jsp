

<%@page import="com.cgc.DB.D_carbon_withdraw_detail_whDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_withdraw_detail_whDAO objdetail = new D_carbon_withdraw_detail_whDAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>


