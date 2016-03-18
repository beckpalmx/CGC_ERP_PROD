
<%@page import="com.cgc.DB.CS_052DAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<% CS_052DAO objdetail = new CS_052DAO();
%>
<%=objdetail.showDetail(request.getParameter("process_id"),request.getParameter("doc_id"),request.getParameter("table"))%>
