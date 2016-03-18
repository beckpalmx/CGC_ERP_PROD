
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_job_order_detailDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_job_order_detailDAO objdetail = new D_job_order_detailDAO();
ThaiUtil objth = new ThaiUtil();
%>
<%=objdetail.showDetail2(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>
