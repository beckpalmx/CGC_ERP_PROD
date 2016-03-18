<%@page import="com.cgc.DB.D_carbon_send_product_detailDAO"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_send_product_detailDAO objdetail = new D_carbon_send_product_detailDAO();
%>
<%=objdetail.ShowDetail(request.getParameter("doc_id"))%>


