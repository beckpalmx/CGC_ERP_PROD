<%@page import="com.cgc.DB.D_carbon_out_analysis_detailDAO"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_requisition_product_detail_whDAO"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_carbon_out_analysis_detailDAO objdetail = new D_carbon_out_analysis_detailDAO();
%>
<%=objdetail.ShowDetail(request.getParameter("doc_id"))%>


