<%@page import="com.cgc.report.PrintCSV_Summary_Warehouse"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_Summary_Warehouse obj = new PrintCSV_Summary_Warehouse();
obj.PrintExport_Summary_Warehouse(request,response);
%>