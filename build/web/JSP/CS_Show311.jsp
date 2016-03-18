<%@page import="com.cgc.DB.CS_311DAO"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_requisition_product_detail_whDAO"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
CS_311DAO objdetail = new CS_311DAO();
%>
<%=objdetail.ShowAll()%>


