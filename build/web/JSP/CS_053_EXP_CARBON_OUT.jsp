<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_CARBON_OUT" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_CARBON_OUT obj = new PrintCSV_CARBON_OUT();
obj.ExportCSV(request,response);
%>