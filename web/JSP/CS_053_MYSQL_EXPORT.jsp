
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_MySQL" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_MySQL obj = new PrintCSV_MySQL();
obj.ExportCSV(request,response);
%>