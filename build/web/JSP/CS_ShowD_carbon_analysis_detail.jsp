<%@page import="com.cgc.DB.CS_D_carbon_analysis_detailDAO"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
CS_D_carbon_analysis_detailDAO objdetail = new CS_D_carbon_analysis_detailDAO();
System.out.println("Show Data Doc IS = " + request.getParameter("doc_id") );
%>
<%=objdetail.ShowDetail(request.getParameter("doc_id"))%>


