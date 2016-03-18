<%@page import="com.cgc.DB.CS_050DAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<% CS_050DAO objdetail = new CS_050DAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>
