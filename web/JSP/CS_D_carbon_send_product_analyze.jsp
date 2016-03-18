<%@page import="com.cgc.DB.D_carbon_send_product_detail_analyzeDAO"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_send_product_detail_analyzeDAO objdetail = new D_carbon_send_product_detail_analyzeDAO();
%>
<%=objdetail.ShowDetail(request.getParameter("doc_id"))%>


