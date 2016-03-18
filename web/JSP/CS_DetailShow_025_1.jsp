<%@page import="com.cgc.DB.D_carbon_friction_withdraw_detailDAO"%>
<%@page import="com.cgc.DB.D_product_receive_detail_prodDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_friction_withdraw_detailDAO objdetail = new D_carbon_friction_withdraw_detailDAO();
%>
<%=objdetail.ShowDetail(request.getParameter("doc_id"))%>


