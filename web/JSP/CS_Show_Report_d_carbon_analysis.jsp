<%@page import="com.cgc.report.PrintReport_d_carbon_analysis"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_requisition_product_detail_whDAO"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
PrintReport_d_carbon_analysis objdetail = new PrintReport_d_carbon_analysis();
%>
<%=objdetail.ShowDetail(Integer.parseInt(request.getParameter("select_case")),request.getParameter("search_date"))%>