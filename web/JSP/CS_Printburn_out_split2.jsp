<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintBurn_out_and_split2" %>
<%@page import="java.io.InputStream"%>
<%
PrintBurn_out_and_split2 obj = new PrintBurn_out_and_split2();
obj.ReportBurn_out_and_split(request,response);
%>