<%@page import="com.cgc.report.PrintReport_Rawmat_bigbag_balance"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
PrintReport_Rawmat_bigbag_balance objdetail = new PrintReport_Rawmat_bigbag_balance();

System.out.println(request.getParameter("month_id"));
System.out.println(request.getParameter("price_year"));
System.out.println(request.getParameter("location_id"));

%>
<%=objdetail.ShowDetail(request.getParameter("month_id"),request.getParameter("price_year"),request.getParameter("location_id"))%>        
       
