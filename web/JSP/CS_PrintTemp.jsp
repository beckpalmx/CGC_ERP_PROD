<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintTemp" %>
<%@page import="java.io.InputStream"%>
<%
PrintTemp obj = new PrintTemp();
obj.Print(request,response);
%>