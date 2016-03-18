<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_WAREHOUSE_TRANSFER" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_WAREHOUSE_TRANSFER obj = new PrintCSV_WAREHOUSE_TRANSFER();
obj.ExportCSV(request,response);
%>