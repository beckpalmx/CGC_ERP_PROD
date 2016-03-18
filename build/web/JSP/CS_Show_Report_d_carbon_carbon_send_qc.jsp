<%@page import="com.cgc.report.PrintReport_d_carbon_send_product"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
PrintReport_d_carbon_send_product objdetail = new PrintReport_d_carbon_send_product();
%>
<%=objdetail.ShowDetail(Integer.parseInt(request.getParameter("select_case")),request.getParameter("search_date"))%>