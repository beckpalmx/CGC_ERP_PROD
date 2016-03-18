<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_WAREHOUSE" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_WAREHOUSE obj = new PrintCSV_WAREHOUSE();
obj.ExportCSV(request,response);
%>