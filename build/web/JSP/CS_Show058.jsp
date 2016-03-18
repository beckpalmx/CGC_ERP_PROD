
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_rawmatt_bigbag_withdraw_detailDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_rawmatt_bigbag_withdraw_detailDAO objdetail = new D_rawmatt_bigbag_withdraw_detailDAO();
ThaiUtil objth = new ThaiUtil();
%>
<%=objdetail.showDetail(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>


