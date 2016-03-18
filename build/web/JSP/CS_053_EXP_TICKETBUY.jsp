<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV" %>
<%@page import="java.io.InputStream"%>
<%
PrintCSV obj = new PrintCSV();
obj.ExportCSV(request,response);
%>