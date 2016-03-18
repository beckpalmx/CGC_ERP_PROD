

<%@page import="com.cgc.DB.D_product_receive_detail_prodDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_product_receive_detail_prodDAO objdetail = new D_product_receive_detail_prodDAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>


