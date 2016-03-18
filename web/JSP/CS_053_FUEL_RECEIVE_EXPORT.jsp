
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_FUEL_REC" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_FUEL_REC obj = new PrintCSV_FUEL_REC();
obj.ExportCSV(request,response);
%>