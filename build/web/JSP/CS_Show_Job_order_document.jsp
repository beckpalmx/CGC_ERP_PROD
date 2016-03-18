<%@page import="com.cgc.report.PrintReport_d_job_order_ducument"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
PrintReport_d_job_order_ducument objdetail = new PrintReport_d_job_order_ducument();
%>
<%=objdetail.ShowDetail(request.getParameter("cust_id"),request.getParameter("spec1"))%>        
       
