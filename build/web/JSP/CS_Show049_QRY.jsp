<%@page import="com.cgc.DB.CS_049_2_QRY_DAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<% CS_049_2_QRY_DAO objdetail = new CS_049_2_QRY_DAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>
