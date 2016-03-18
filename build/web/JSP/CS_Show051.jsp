<%@page import="com.cgc.DB.CS_051DAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<% CS_051DAO objdetail = new CS_051DAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>
