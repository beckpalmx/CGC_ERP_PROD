

<%@page import="com.cgc.DB.D_product_receive_detailDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_product_receive_detailDAO objdetail = new D_product_receive_detailDAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>


