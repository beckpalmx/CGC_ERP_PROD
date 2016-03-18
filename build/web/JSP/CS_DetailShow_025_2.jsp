

<%@page import="com.cgc.DB.D_carbon_friction_receive_detail_1DAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_friction_receive_detail_1DAO objdetail = new D_carbon_friction_receive_detail_1DAO();
%>
<%=objdetail.ShowDetail(request.getParameter("doc_id"))%>


