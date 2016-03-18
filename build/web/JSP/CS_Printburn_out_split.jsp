<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintBurn_out_and_split" %>
<%@page import="java.io.InputStream"%>
<%
PrintBurn_out_and_split obj = new PrintBurn_out_and_split();
obj.ReportBurn_out_and_split(request,response);
%>