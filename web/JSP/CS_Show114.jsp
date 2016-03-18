<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_carbon_return_detail_whDAO"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_return_detail_whDAO objdetail = new D_carbon_return_detail_whDAO();
ThaiUtil objth = new ThaiUtil();
%>
<%=objdetail.ShowDetailApprove(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>
