

<%@page import="com.cgc.DB.D_product_receive_detail_prod_whDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_product_receive_detail_prod_whDAO objdetail = new D_product_receive_detail_prod_whDAO();
%>
<%=objdetail.showDetail(request.getParameter("doc_id"))%>
