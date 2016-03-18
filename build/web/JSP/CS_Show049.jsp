<%@page import="com.cgc.DB.CS_049DAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<% CS_049DAO objdetail = new CS_049DAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>
