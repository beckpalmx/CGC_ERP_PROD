<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_carbon_analyze_detailDAO"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_analyze_detailDAO objdetail = new D_carbon_analyze_detailDAO();
ThaiUtil objth = new ThaiUtil();
%>
<%=objdetail.showDetail(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>
