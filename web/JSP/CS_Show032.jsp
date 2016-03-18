
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_job_order_headerDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_job_order_headerDAO objdetail = new D_job_order_headerDAO();
ThaiUtil objth = new ThaiUtil();
System.out.println("request.getParameter(doc_id) = " + request.getParameter("doc_id"));
%>
<%=objdetail.showDetail(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>
