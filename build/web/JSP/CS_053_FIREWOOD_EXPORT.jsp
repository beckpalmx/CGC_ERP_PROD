
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.report.PrintCSV_FIREWOOD_EXPORT" %>
<%@page import="java.io.InputStream"%>
<%

    System.out.println(" Data For = : " + request.getParameter("data_for"));
    
PrintCSV_FIREWOOD_EXPORT obj = new PrintCSV_FIREWOOD_EXPORT();
obj.ExportCSV(request,response);
%>