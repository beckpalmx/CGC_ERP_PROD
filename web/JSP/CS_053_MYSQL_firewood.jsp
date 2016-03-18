
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_MySQL_firewood" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV_MySQL_firewood obj = new PrintCSV_MySQL_firewood();
obj.ExportCSV(request,response);
%>